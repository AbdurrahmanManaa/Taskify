import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/services/image_picker_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/user_profile_image.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/edit_user_entity.dart';
import 'package:taskify/features/home/presentation/views/edit_task_view.dart';
import 'package:taskify/features/home/presentation/widgets/edit_user_view_body.dart';
import 'package:taskify/features/home/presentation/widgets/user_info_widget.dart';
import 'package:taskify/generated/l10n.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? _imageFile;
  String _timezone = '';

  @override
  void initState() {
    super.initState();
    _getTimezone();
  }

  Future<void> _getTimezone() async {
    _timezone = await FlutterTimezone.getLocalTimezone();
    setState(() {});
  }

  Future<void> _pickImageFromGallery() async {
    File? pickedImage = await ImagePickerService().pickImage(
      context: context,
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
      if (!mounted) return;
      var imagePath = await context.read<UserCubit>().uploadUserImage(
            imageFile: _imageFile!,
            userId: widget.supabase.auth.currentUser!.id,
          );
      if (!mounted) return;
      await context.read<UserCubit>().updateUserData(
            newImagePath: imagePath,
            uid: widget.supabase.auth.currentUser!.id,
          );
    } else {
      return;
    }
  }

  Future<void> _pickImageFromCamera() async {
    File? pickedImage = await ImagePickerService().pickImage(
      context: context,
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
      if (!mounted) return;
      var imagePath = await context.read<UserCubit>().uploadUserImage(
            imageFile: _imageFile!,
            userId: widget.supabase.auth.currentUser!.id,
          );
      if (!mounted) return;
      await context.read<UserCubit>().updateUserData(
            newImagePath: imagePath,
            uid: widget.supabase.auth.currentUser!.id,
          );
    } else {
      return;
    }
  }

  Future<void> _updateProfilepicture(
      BuildContext context, String? userImagePath) async {
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
                    S.of(context).profilePictureBottomSheet,
                    style: AppTextStyles.semiBold20
                        .copyWith(color: AppColors.primaryLightColor),
                  ),
                  Visibility(
                    visible: userImagePath != null && userImagePath.isNotEmpty,
                    child: GestureDetector(
                      onTap: () async {
                        await context.read<UserCubit>().deleteImageFromStorage(
                          dataPaths: [userImagePath!],
                        );
                        if (!context.mounted) return;
                        await context.read<UserCubit>().updateUserData(
                              newImagePath: null,
                              uid: widget.supabase.auth.currentUser!.id,
                            );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.trash,
                        size: 20,
                        color: AppColors.primaryLightColor,
                      ),
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
                          await _pickImageFromCamera();

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
                                color: Color.fromARGB(255, 223, 225, 231),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 32,
                              color: AppColors.primaryLightColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        S.of(context).camera,
                        style: AppTextStyles.regular16,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _pickImageFromGallery();

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
                                color: Color.fromARGB(255, 223, 225, 231),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 32,
                              color: AppColors.primaryLightColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        S.of(context).gallery,
                        style: AppTextStyles.regular16,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserFailure) {
          return Center(
            child: Text('Faild to load user data.'),
          );
        } else {
          var userEntity = context.watch<UserCubit>().userEntity;
          var userFullName = userEntity.fullName;
          var userEmail = userEntity.email;
          var userCreatedAt =
              DateFormat('MMM d, yyyy').format(userEntity.createdAt!);
          var userImagePath = userEntity.imagePath;
          var userImageUrl =
              (userEntity.imageUrl != null && userEntity.imageUrl!.isNotEmpty)
                  ? userEntity.imageUrl
                  : AppConstants.defaultProfileImage;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CustomAppbar(title: S.of(context).profileAppBar),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    await _updateProfilepicture(
                      context,
                      userImagePath,
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: UserProfileImage(
                          size: 200,
                          broderWidth: 4,
                          imageUrl: userImageUrl,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: MediaQuery.sizeOf(context).width / 2 - 80,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primaryLightColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                UserInfoWidget(
                  onTap: () {
                    pushScreenWithoutNavBar(
                      context,
                      Provider.value(
                        value: EditUserEntity(
                          userEntity: userEntity,
                          mode: EditProfileType.name,
                        ),
                        child: const EditTaskView(),
                      ),
                    );
                  },
                  title: S.of(context).fullNameEditUser,
                  userData: userFullName,
                ),
                const SizedBox(height: 40),
                UserInfoWidget(
                  onTap: () {
                    pushScreenWithoutNavBar(
                      context,
                      Provider.value(
                        value: EditUserEntity(
                          userEntity: userEntity,
                          mode: EditProfileType.email,
                        ),
                        child: const EditTaskView(),
                      ),
                    );
                  },
                  title: S.of(context).fullNameEditUser,
                  userData: userEmail,
                ),
                const SizedBox(height: 40),
                UserInfoWidget(
                  title: S.of(context).timezone,
                  userData: _timezone,
                  showArrow: false,
                ),
                const SizedBox(height: 40),
                UserInfoWidget(
                  title: S.of(context).memberSince,
                  userData: userCreatedAt,
                  showArrow: false,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
