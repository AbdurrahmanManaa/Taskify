import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/file_manager.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/home/data/models/attachment_model.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/attachment_item.dart';
import 'package:path/path.dart' as p;

class AttachmentsTab extends StatefulWidget {
  const AttachmentsTab({
    super.key,
    required this.taskDetails,
  });
  final TaskEntity taskDetails;

  @override
  State<AttachmentsTab> createState() => _AttachmentsTabState();
}

class _AttachmentsTabState extends State<AttachmentsTab> {
  late final TextEditingController _attachmentController;
  final GlobalKey<FormState> _attachmentFormKey = GlobalKey();
  AutovalidateMode _attachmentAutoValidateMode = AutovalidateMode.disabled;
  final List<AttachmentEntity> _mediaAttachments = [];
  final List<AttachmentEntity> _documentAttachments = [];
  final List<File> _mediaFiles = [];
  final List<File> _documentFiles = [];
  Map<String, Uint8List?> videoThumbnails = {};

  @override
  void initState() {
    super.initState();
    _attachmentController = TextEditingController();
  }

  @override
  void dispose() {
    _attachmentController.dispose();
    super.dispose();
  }

  void _updateFiles(
    List<File> pickedFiles,
    List<AttachmentEntity> targetList,
    List<File> fileList,
  ) {
    setState(() {
      if (pickedFiles.isNotEmpty) {
        final newAttachments = pickedFiles.map((file) {
          final fileName = file.path.split('/').last;
          final fileType = FileUtils.getFileType(fileName);
          final fileSize = file.lengthSync();

          return AttachmentEntity(
            id: '',
            taskId: '',
            fileName: fileName,
            fileType: fileType,
            fileSize: fileSize,
            filePath: file.path,
            status: AttachmentStatus.pending,
          );
        }).toList();

        targetList
          ..clear()
          ..addAll(newAttachments);

        fileList
          ..clear()
          ..addAll(pickedFiles);
      }
    });
  }

  Future<Uint8List?> _generateThumbnail(String videoUrl) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final thumbnailPath = '${cacheDir.path}/${videoUrl.hashCode}.jpg';
      final thumbnailFile = File(thumbnailPath);

      if (await thumbnailFile.exists()) {
        return await thumbnailFile.readAsBytes();
      }

      final thumbnail = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200,
        quality: 75,
      );

      await thumbnailFile.writeAsBytes(thumbnail);
      return thumbnail;
    } catch (e) {
      log('Error generating thumbnail: $e');
      return null;
    }
  }

  Future<void> _openFile(String filePath) async {
    final localPath = await FileManager.downloadFile(filePath);
    if (localPath != null) {
      await FileManager.openFile(localPath);
    } else {
      log('Failed to download file');
    }
  }

  Future<void> _downloadFile(String filePath) async {
    final localPath = await FileManager.downloadFile(filePath);
    if (localPath != null) {
      final publicPath = await FileManager.moveFileToPublic(localPath);
      if (publicPath != null) {
        log('File is now available in public storage: $publicPath');
      } else {
        log('Failed to move file to public folder');
      }
    } else {
      log('Failed to download file');
    }
  }

  List<AttachmentEntity> _getMediaAttachments(
      List<AttachmentEntity> attachments) {
    return attachments
        .where((attachment) =>
            attachment.fileType == 'image' || attachment.fileType == 'video')
        .toList();
  }

  List<AttachmentEntity> _getDocumentAttachments(
      List<AttachmentEntity> attachments) {
    return attachments
        .where((attachment) =>
            attachment.fileType == 'document' ||
            attachment.fileType == 'archive')
        .toList();
  }

  Future<void> _deleteAttachment(
    BuildContext context,
    AttachmentEntity attachment,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text('Delete Attachment Permanently'),
        content: const Text(
            'Are you sure you want to delete this attachment permanently?'),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () async {
              await context
                  .read<AttachmentCubit>()
                  .deleteAttachmentsFromStorage(
                dataPaths: [attachment.filePath],
                taskId: widget.taskDetails.id,
              );
              if (!context.mounted) return;
              await context.read<AttachmentCubit>().deleteSingleAttachment(
                    attachmentId: attachment.id,
                    taskId: widget.taskDetails.id,
                  );
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future<void> _renameAttachment(
    BuildContext context,
    AttachmentEntity attachment,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Form(
            key: _attachmentFormKey,
            autovalidateMode: _attachmentAutoValidateMode,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FieldItem(
                    label: 'New Attachement Name',
                    widget: CustomTextFormField(
                      hintText: attachment.fileName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      maxLength: 100,
                      controller: _attachmentController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_attachmentFormKey.currentState!.validate()) {
                        var newPath = await context
                            .read<AttachmentCubit>()
                            .moveAttachmentFromStorage(
                              taskId: widget.taskDetails.id,
                              userId: widget.taskDetails.userId,
                              oldPath: attachment.filePath,
                              newFileName: _attachmentController.text.trim(),
                            );
                        final updatedAttachment = attachment.copyWith(
                          filePath: newPath,
                          fileName: p.basename(newPath),
                        );
                        if (!context.mounted) return;
                        await context.read<AttachmentCubit>().updateAttachment(
                              data:
                                  AttachmentModel.fromEntity(updatedAttachment)
                                      .toJson(),
                              attachmentId: updatedAttachment.id,
                              taskId: widget.taskDetails.id,
                            );
                        _attachmentController.clear();
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _attachmentAutoValidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    child: Text(
                      'Change Name',
                      style:
                          AppTextStyles.medium20.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future<void> _attachmentActions(
    BuildContext context,
    AttachmentEntity attachment,
  ) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.xmark,
                      size: 28,
                      color: AppColors.primaryLightColor,
                    ),
                  ),
                  Text(
                    'Attachment',
                    style: AppTextStyles.semiBold20
                        .copyWith(color: AppColors.primaryLightColor),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _deleteAttachment(
                        context,
                        attachment,
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.trash,
                      size: 20,
                      color: AppColors.primaryLightColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _downloadFile(attachment.filePath);

                          if (!context.mounted) return;
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 1,
                                color: AppColors.borderColor,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.download,
                              size: 32,
                              color: AppColors.primaryLightColor,
                            ),
                          ),
                        ),
                      ),
                      Text('Download', style: AppTextStyles.regular16),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _renameAttachment(
                            context,
                            attachment,
                          );
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 1,
                                color: AppColors.borderColor,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 32,
                              color: AppColors.primaryLightColor,
                            ),
                          ),
                        ),
                      ),
                      Text('Rename', style: AppTextStyles.regular16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadNewMediaAttachments(
      BuildContext context, String taskId, String userId) async {
    await pickFilesAndValidate(
      context,
      (pickedFiles) => _updateFiles(
        pickedFiles,
        _mediaAttachments,
        _mediaFiles,
      ),
      fileType: FileType.media,
    );

    if (_mediaAttachments.isNotEmpty) {
      if (!context.mounted) return;
      await context.read<AttachmentCubit>().addAttachment(
            files: _mediaFiles,
            baseEntities: _mediaAttachments,
            taskId: taskId,
            userId: userId,
          );
    }
  }

  Future<void> _uploadNewDocumentAttachments(
      BuildContext context, String taskId, String userId) async {
    await pickFilesAndValidate(
      context,
      (pickedFiles) => _updateFiles(
        pickedFiles,
        _documentAttachments,
        _documentFiles,
      ),
      fileType: FileType.custom,
      allowedFileExtensions: customDocumentsAllowedExtensions,
    );

    if (_documentAttachments.isNotEmpty) {
      if (!context.mounted) return;
      await context.read<AttachmentCubit>().addAttachment(
            files: _documentFiles,
            baseEntities: _documentAttachments,
            taskId: taskId,
            userId: userId,
          );
    }
  }

  Skeletonizer _attachmentsPlaceholder() {
    return Skeletonizer(
      enabled: true,
      containersColor: AppColors.inputDecorationLightFillColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Media (2)', style: AppTextStyles.medium18),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        AppConstants.defaultMediaImage),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text('Files (3)', style: AppTextStyles.medium18),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AttachmentItem(
                  fileName: 'This is a placeholder name',
                  fileExtension: 'This is a placeholder extension',
                  trailing: CustomPopupMenuButton(
                    items: [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentCubit, AttachmentState>(
      listener: (context, state) {
        if (state is AttachmentSuccess) {
          buildSnackbar(context, message: state.message!);
        } else if (state is AttachmentFailure) {
          buildSnackbar(context, message: state.message!);
        }
      },
      builder: (context, state) {
        if (state is AttachmentLoading) {
          return _attachmentsPlaceholder();
        } else if (state is AttachmentFailure) {
          return Center(
            child: Text(
              'Failed to load attachments',
              style:
                  AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
            ),
          );
        } else {
          final attachments = context.watch<AttachmentCubit>().attachments;
          final mediaAttachments = _getMediaAttachments(attachments);
          final documentAttachments = _getDocumentAttachments(attachments);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (mediaAttachments.isNotEmpty)
                Text('Media (${mediaAttachments.length})',
                    style: AppTextStyles.medium18),
              const SizedBox(height: 10),
              mediaAttachments.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: mediaAttachments.length + 1,
                      itemBuilder: (context, index) {
                        if (index == mediaAttachments.length) {
                          return GestureDetector(
                            onTap: () async {
                              await _uploadNewMediaAttachments(
                                context,
                                widget.taskDetails.id,
                                widget.taskDetails.userId,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff8f9fb),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          );
                        }
                        final attachment = mediaAttachments[index];
                        final attachmentPath = attachment.filePath;
                        final attachmentUrl = attachment.fileUrl;
                        final isImage = attachment.fileType == 'image';

                        if (!videoThumbnails.containsKey(attachmentUrl) &&
                            attachment.fileType == 'video') {
                          _generateThumbnail(attachmentUrl!).then((thumbnail) {
                            if (thumbnail != null) {
                              if (mounted) {
                                setState(() {
                                  videoThumbnails[attachmentUrl] = thumbnail;
                                });
                              }
                            }
                          });
                        }

                        return GestureDetector(
                          onTap: () => _openFile(attachmentPath),
                          onLongPress: () =>
                              _attachmentActions(context, attachment),
                          child: isImage
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          attachmentUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Stack(
                                  children: [
                                    videoThumbnails.containsKey(attachmentUrl)
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: MemoryImage(
                                                    videoThumbnails[
                                                        attachmentUrl]!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Skeletonizer(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          AppConstants
                                                              .defaultMediaImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                    const Center(
                                      child: Icon(Icons.play_circle_fill,
                                          size: 50, color: AppColors.greyColor),
                                    ),
                                  ],
                                ),
                        );
                      },
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _uploadNewMediaAttachments(
                          context,
                          widget.taskDetails.id,
                          widget.taskDetails.userId,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xfff8f9fb),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: AppColors.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Add Attachment',
                            style: AppTextStyles.regular14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
              if (documentAttachments.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: 20),
                    Text('Files (${documentAttachments.length})',
                        style: AppTextStyles.medium18),
                  ],
                ),
              const SizedBox(height: 20),
              documentAttachments.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: documentAttachments.length + 1,
                      itemBuilder: (context, index) {
                        if (index == documentAttachments.length) {
                          return GestureDetector(
                            onTap: () async {
                              await _uploadNewDocumentAttachments(
                                context,
                                widget.taskDetails.id,
                                widget.taskDetails.userId,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xfff8f9fb),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.borderColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Add File',
                                  style: AppTextStyles.regular14
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          );
                        }

                        final attachment = documentAttachments[index];
                        var attachmentPath = attachment.filePath;
                        var attachementName = attachment.fileName;
                        var attachmentExtension = p.extension(attachementName);
                        var attachmentSize =
                            FileUtils.formatFileSize(attachment.fileSize);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () async {
                              _openFile(
                                attachmentPath,
                              );
                            },
                            child: AttachmentItem(
                              fileName: attachementName,
                              fileExtension: attachmentExtension,
                              fileSize: attachmentSize,
                              trailing: CustomPopupMenuButton(
                                taskEntity: widget.taskDetails,
                                items: [
                                  PopupMenuItem(
                                    value: 1,
                                    onTap: () async {
                                      await _renameAttachment(
                                        context,
                                        attachment,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('Rename'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    onTap: () async {
                                      await _downloadFile(attachmentPath);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.download,
                                          color: AppColors.primaryLightColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('Download'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 3,
                                    onTap: () async {
                                      await _deleteAttachment(
                                        context,
                                        attachment,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: AppColors.errorColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _uploadNewDocumentAttachments(
                          context,
                          widget.taskDetails.id,
                          widget.taskDetails.userId,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xfff8f9fb),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: AppColors.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Add File',
                            style: AppTextStyles.regular14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        }
      },
    );
  }
}
