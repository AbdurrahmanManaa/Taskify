import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/edit_user_entity.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/presentation/views/app_lock_view.dart';
import 'package:taskify/features/home/presentation/views/connected_accounts_view.dart';
import 'package:taskify/features/home/presentation/views/edit_user_view.dart';
import 'package:taskify/features/home/presentation/views/profile_view.dart';
import 'package:taskify/features/home/presentation/widgets/account_settings_section.dart';
import 'package:taskify/features/home/presentation/widgets/edit_user_view_body.dart';
import 'package:taskify/features/home/presentation/widgets/preferences_settings_section.dart';
import 'package:taskify/features/home/presentation/widgets/security_settings_section.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  bool _isNotificationsToggleActive = true;

  Future<dynamic> _languageSelection(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'App Language',
                style: AppTextStyles.medium24
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              Divider(),
              ListTile(
                leading: Image.asset(AppAssets.imagesUsa),
                title: Text(
                  'English',
                  style: AppTextStyles.medium18,
                ),
                trailing: Icon(
                  Icons.check,
                  color: AppColors.primaryLightColor,
                ),
              ),
              Divider(),
              ListTile(
                leading: Image.asset(AppAssets.imagesKsa),
                title: Text(
                  'Arabic',
                  style: AppTextStyles.medium18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _notificationStyleSelection(BuildContext context) {
    final prefs = HiveService.preferencesNotifier.value;
    final badgeStyle = prefs.appIconBadgeStyle;

    return showModalBottomSheet(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'App Badge Style',
                style: AppTextStyles.medium24
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              Divider(),
              OptionItem(
                onTap: () async {
                  final updated = prefs.copyWith(
                    appIconBadgeStyle: AppIconBadgeStyle.dot,
                  );
                  await HiveService().setUserPreferences(updated);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.circle,
                  size: 30,
                  color: AppColors.errorColor,
                ),
                title: Text(
                  'Dot',
                  style: AppTextStyles.medium18,
                ),
                trailing: badgeStyle == AppIconBadgeStyle.dot
                    ? Icon(
                        Icons.check,
                        color: AppColors.primaryLightColor,
                      )
                    : null,
              ),
              Divider(),
              OptionItem(
                onTap: () async {
                  final updated = prefs.copyWith(
                    appIconBadgeStyle: AppIconBadgeStyle.number,
                  );
                  await HiveService().setUserPreferences(updated);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.looks_one,
                  size: 30,
                  color: AppColors.errorColor,
                ),
                title: Text(
                  'Number',
                  style: AppTextStyles.medium18,
                ),
                trailing: badgeStyle == AppIconBadgeStyle.number
                    ? Icon(
                        Icons.check,
                        color: AppColors.primaryLightColor,
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _themeModeSelection(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'App Theme',
                style: AppTextStyles.medium24.copyWith(
                  color: AppColors.primaryLightColor,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.brightness_auto,
                  color: AppColors.primaryLightColor,
                ),
                title: Text(
                  'System',
                  style: AppTextStyles.medium18,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.light_mode,
                  color: AppColors.primaryLightColor,
                ),
                title: Text(
                  'Light',
                  style: AppTextStyles.medium18,
                ),
                trailing: Icon(
                  Icons.check,
                  color: AppColors.primaryLightColor,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.dark_mode,
                  color: AppColors.primaryLightColor,
                ),
                title: Text(
                  'Dark',
                  style: AppTextStyles.medium18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
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
              'Confirm',
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () async {
              await context.read<UserCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }

//! Adjust this method to remove attachments from storage first and then update paths in tables then delete user!.
  Future<void> _deleteAccount(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text('Delete Account Permanently'),
        content: const Text(
            'Are you sure you want to delete your account permanently?'),
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
              // await supabase
              //     .from(Endpoints.usersTable)
              //     .delete()
              //     .eq('id', supabase.auth.currentUser!.id);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollController>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAppbar(
              title: 'Settings',
              showBackButton: false,
            ),
            const SizedBox(height: 20),
            AccountSettingsSection(
              profileOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  ProfileView(),
                );
              },
              connectedAccountsOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  ConnectedAccountsView(),
                );
              },
              signOutOnTap: () async {
                await _signOut(context);
              },
              deleteAccountOnTap: () => _deleteAccount(context),
            ),
            const SizedBox(height: 20),
            SecuritySettingsSection(
              changePasswordOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  Provider.value(
                    value: EditUserEntity(
                      userEntity: context.read<UserCubit>().userEntity,
                      mode: EditProfileType.password,
                    ),
                    child: const EditUserView(),
                  ),
                );
              },
              appLockOnTap: () {
                pushScreenWithoutNavBar(
                  context,
                  AppLockView(),
                );
              },
            ),
            const SizedBox(height: 20),
            PreferencesSettingsSection(
              isNotificationsToggleActive: _isNotificationsToggleActive,
              toggleNotifications: (value) =>
                  setState(() => _isNotificationsToggleActive = value),
              appIconBadgesOnTap: () async {
                await _notificationStyleSelection(context);
              },
              appThemeModeOnTap: () async {
                await _themeModeSelection(context);
              },
              languageOnTap: () async {
                await _languageSelection(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
