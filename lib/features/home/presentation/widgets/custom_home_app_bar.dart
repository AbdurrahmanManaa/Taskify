import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/user_profile_image.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/core/widgets/custom_icon_button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.supabase});
  final SupabaseClient supabase;

  String formatFirstName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return '';

    final first = parts[0];
    return '${first[0].toUpperCase()}${first.substring(1)}';
  }

  Skeletonizer _profilePlaceholder() {
    return Skeletonizer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserProfileImage(
                size: 60,
                imageUrl: AppConstants.defaultMediaImage,
              ),
              const SizedBox(width: 19),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back !',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular18
                        .copyWith(color: AppColors.greyColor),
                  ),
                  Text(
                    'John Smith',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium24
                        .copyWith(color: AppColors.primaryLightColor),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomIconButton(
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColors.primaryLightColor,
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomIconButton(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.primaryLightColor,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trashTasksCount =
        filterTasks(context.watch<TaskCubit>().tasks, 'trash').length;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return _profilePlaceholder();
        } else if (state is UserFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          var userEntity = context.watch<UserCubit>().userEntity;
          var userFirstName = formatFirstName(userEntity.fullName);
          var userImageUrl =
              (userEntity.imageUrl != null && userEntity.imageUrl!.isNotEmpty)
                  ? userEntity.imageUrl
                  : AppConstants.defaultProfileImage;

          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(AppRoutes.profile);
                },
                child: UserProfileImage(
                  size: 60,
                  imageUrl: userImageUrl,
                ),
              ),
              const SizedBox(width: 19),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back !',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular18
                        .copyWith(color: AppColors.greyColor),
                  ),
                  Text(
                    userFirstName,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium24
                        .copyWith(color: AppColors.primaryLightColor),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(AppRoutes.trash);
                },
                child: CustomIconButton(
                  child: badges.Badge(
                    badgeContent: Text(
                      trashTasksCount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    showBadge: trashTasksCount > 0,
                    badgeAnimation: badges.BadgeAnimation.scale(
                      animationDuration: Duration(milliseconds: 300),
                    ),
                    position: badges.BadgePosition.topEnd(
                      top: -10,
                      end: -12,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColors.primaryLightColor,
                      size: 35,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(AppRoutes.notifications);
                },
                child: CustomIconButton(
                  child: badges.Badge(
                    showBadge: trashTasksCount > 0,
                    position: badges.BadgePosition.topEnd(
                      top: -3,
                      end: -5,
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.primaryLightColor,
                      size: 35,
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
