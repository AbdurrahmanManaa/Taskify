import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/edit_user_entity.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_theme_mode.dart';
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
  bool _isNotificationsToggleActive = false;
  final bool _isDarkModeToggleActive = false;

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
                'App Badge Style',
                style: AppTextStyles.medium24
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              Divider(),
              OptionItem(
                leading: Icon(
                  Icons.circle,
                  size: 30,
                  color: AppColors.errorColor,
                ),
                title: Text(
                  'Dot',
                  style: AppTextStyles.medium18,
                ),
                trailing: Icon(
                  Icons.check,
                  color: AppColors.primaryLightColor,
                ),
              ),
              Divider(),
              OptionItem(
                leading: Icon(
                  Icons.looks_one,
                  size: 30,
                  color: AppColors.errorColor,
                ),
                title: Text(
                  'Number',
                  style: AppTextStyles.medium18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void toggleDarkMode(bool value, BuildContext context) {
    final prefs = HiveService.preferencesNotifier.value;
    final updatedPrefs = prefs.copyWith(
        appThemeMode: value ? AppThemeMode.dark : AppThemeMode.light);
    HiveService().setUserPreferences(updatedPrefs);
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
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserDeleted) {
                buildSnackbar(context,
                    message: 'Account deleted successfully.');
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.signIn, (route) => false);
              } else if (state is UserFailure) {
                buildSnackbar(context, message: 'Failed to delete account.');
              }
            },
            child: TextButton(
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
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.profile);
              },
              connectedAccountsOnTap: () async {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.connectedAccounts);
              },
              deleteAccountOnTap: () => _deleteAccount(context),
            ),
            const SizedBox(height: 20),
            SecuritySettingsSection(
              changePasswordOnTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoutes.editUser,
                  arguments: EditUserEntity(
                    userEntity: context.read<UserCubit>().userEntity,
                    mode: EditProfileType.password,
                  ),
                );
              },
              appLockOnTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.appLockType);
              },
            ),
            const SizedBox(height: 20),
            PreferencesSettingsSection(
              isNotificationsToggleActive: _isNotificationsToggleActive,
              isDarkModeToggleActive: _isDarkModeToggleActive,
              toggleNotifications: (value) =>
                  setState(() => _isNotificationsToggleActive = value),
              toggleDarkMode: (value) => toggleDarkMode(value, context),
              appIconBadgesOnTap: () async {
                await _notificationStyleSelection(context);
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
