import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/user_profile_image.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/core/widgets/custom_icon_button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/views/notifications_view.dart';
import 'package:taskify/features/home/presentation/views/profile_view.dart';
import 'package:taskify/features/home/presentation/views/trash_view.dart';
import 'package:taskify/generated/l10n.dart';

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

    return Row(
      children: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return _profilePlaceholder();
            } else if (state is UserFailure) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              var userEntity = context.watch<UserCubit>().userEntity;
              var userFirstName = formatFirstName(userEntity.fullName);
              var userImageUrl = (userEntity.imageUrl != null &&
                      userEntity.imageUrl!.isNotEmpty)
                  ? userEntity.imageUrl
                  : AppConstants.defaultProfileImage;

              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      pushScreenWithoutNavBar(
                        context,
                        ProfileView(),
                      );
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
                        S.of(context).welcomeBackHomeView,
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
                ],
              );
            }
          },
        ),
        Spacer(),
        ValueListenableBuilder(
          valueListenable: HiveService.preferencesNotifier,
          builder: (context, value, _) {
            final badgeStyle = value.appIconBadgeStyle;

            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    pushScreenWithoutNavBar(
                      context,
                      TrashView(),
                    );
                  },
                  child: CustomIconButton(
                    child: badges.Badge(
                      badgeContent: badgeStyle == AppIconBadgeStyle.number
                          ? Text(
                              trashTasksCount.toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          : null,
                      showBadge: trashTasksCount > 0,
                      badgeAnimation: badges.BadgeAnimation.scale(
                        animationDuration: Duration(milliseconds: 300),
                      ),
                      position: badgeStyle == AppIconBadgeStyle.number
                          ? badges.BadgePosition.topEnd(top: -10, end: -12)
                          : badges.BadgePosition.topEnd(top: -3, end: -5),
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
                    pushScreenWithoutNavBar(
                      context,
                      NotificationsView(),
                    );
                  },
                  child: CustomIconButton(
                    child: badges.Badge(
                      showBadge: trashTasksCount > 0,
                      badgeContent: badgeStyle == AppIconBadgeStyle.number
                          ? Text(
                              trashTasksCount.toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          : null,
                      position: badgeStyle == AppIconBadgeStyle.number
                          ? badges.BadgePosition.topEnd(top: -10, end: -12)
                          : badges.BadgePosition.topEnd(top: -3, end: -5),
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
          },
        ),
      ],
    );
  }
}
