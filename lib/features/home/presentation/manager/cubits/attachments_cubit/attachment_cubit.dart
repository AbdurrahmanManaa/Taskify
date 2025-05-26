import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/utils/endpoints.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/repos/home_repo.dart';

part 'attachment_state.dart';

class AttachmentCubit extends Cubit<AttachmentState> {
  AttachmentCubit(this._homeRepo) : super(AttachmentInitial());
  final HomeRepo _homeRepo;

  List<AttachmentEntity> get attachments => _homeRepo.attachments;

  Future<void> addAttachment({
    required List<File> files,
    required List<AttachmentEntity> baseEntities,
    required String taskId,
    required String userId,
  }) async {
    emit(
      AttachmentLoading(),
    );
    try {
      await _homeRepo.addAttachmentsData(
        files: files,
        taskId: taskId,
        baseEntities: baseEntities,
        userId: userId,
      );

      emit(
        AttachmentSuccess(
          message: 'Attachments added successfully',
        ),
      );
    } catch (e) {
      emit(
        AttachmentFailure(
          message: 'Failed to add attachments',
        ),
      );
    }
  }

  Future<List<AttachmentEntity>> getAttachments(
      {required String taskId}) async {
    emit(
      AttachmentLoading(),
    );
    try {
      var attachments = await _homeRepo.getAttachmentsData(taskId: taskId);
      emit(
        AttachmentSuccess(
          message: 'Attachments fetched successfully',
        ),
      );

      return attachments;
    } catch (e) {
      emit(
        AttachmentFailure(
          message: 'Failed to fetch attachments',
        ),
      );
      return [];
    }
  }

  Future<void> updateAttachment({
    required Map<String, dynamic> data,
    required String attachmentId,
    required String taskId,
  }) async {
    emit(
      AttachmentLoading(),
    );
    try {
      await _homeRepo.updateTaskAttachmentData(
        data: data,
        attachmentId: attachmentId,
        taskId: taskId,
      );
      emit(
        AttachmentSuccess(
          message: 'Attachment updated successfully',
        ),
      );
    } catch (e) {
      emit(
        AttachmentFailure(
          message: 'Failed to update attachment',
        ),
      );
    }
  }

  Future<void> deleteAttachmentsFromStorage({
    required List<String> dataPaths,
    required String taskId,
  }) async {
    emit(
      AttachmentLoading(),
    );
    try {
      await _homeRepo.deleteTaskAttachmentFromStorage(
        dataPaths: dataPaths,
        taskId: taskId,
      );
      emit(
        AttachmentSuccess(),
      );
    } catch (e) {
      emit(
        AttachmentFailure(),
      );
    }
  }

  Future<String> moveAttachmentFromStorage({
    required String taskId,
    required String userId,
    required String oldPath,
    required String newFileName,
  }) async {
    emit(
      AttachmentLoading(),
    );
    try {
      var newPath = await _homeRepo.moveAttachmentFromStorage(
        taskId: taskId,
        userId: userId,
        oldPath: oldPath,
        newFileName: newFileName,
      );
      emit(
        AttachmentSuccess(),
      );
      return newPath;
    } catch (e) {
      emit(
        AttachmentFailure(),
      );
      return '';
    }
  }

  Future<void> deleteSingleAttachment({
    required String attachmentId,
    required String taskId,
  }) async {
    emit(
      AttachmentLoading(),
    );
    try {
      await _homeRepo.deleteSingleTaskAttachment(
        taskId: taskId,
        attachmentId: attachmentId,
      );
      emit(
        AttachmentSuccess(
          message: 'Attachment deleted successfully',
        ),
      );
    } catch (e) {
      emit(
        AttachmentFailure(
          message: 'Failed to delete attachment',
        ),
      );
    }
  }

  Future<void> deleteMultipleAttachments(
      {required List<String> dataIds}) async {
    emit(
      AttachmentLoading(),
    );
    try {
      await _homeRepo.deleteMultipleData(
        table: Endpoints.attachmentsTable,
        dataIds: dataIds,
        column: 'id',
      );
      emit(
        AttachmentSuccess(
          message: 'Attachments deleted successfully',
        ),
      );
    } catch (e) {
      emit(
        AttachmentFailure(
          message: 'Failed to delete attachments',
        ),
      );
    }
  }
}
