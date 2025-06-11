import 'package:flutter/material.dart';
import 'package:taskify/core/extensions/user_preferences_extension.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';

class PreferencesSettingsSection extends StatelessWidget {
  const PreferencesSettingsSection({
    super.key,
    required this.isNotificationsToggleActive,
    this.toggleNotifications,
    this.appIconBadgesOnTap,
    this.appThemeModeOnTap,
    this.languageOnTap,
  });
  final bool isNotificationsToggleActive;
  final Function(bool)? toggleNotifications;
  final Function()? appIconBadgesOnTap;
  final Function()? appThemeModeOnTap;
  final Function()? languageOnTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.preferencesNotifier,
      builder: (context, value, _) {
        final badgeStyle = value.appIconBadgeStyle;
        final appThemeMode = value.appThemeMode;
        final appLanguage = value.appLanguage;

        return SettingsSection(
          title: 'Preferences',
          widgets: [
            const SizedBox(height: 20),
            OptionItem(
              leading: Icon(
                Icons.notifications_active,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                'Notifications',
                style: AppTextStyles.medium18
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              trailing: Switch(
                value: isNotificationsToggleActive,
                onChanged: toggleNotifications,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            OptionItem(
              onTap: appIconBadgesOnTap,
              leading: Icon(
                Icons.palette,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                'App Icon Badges',
                style: AppTextStyles.medium18
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.settingsSectionBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeStyle.label,
                  style: AppTextStyles.regular16
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            OptionItem(
              onTap: appThemeModeOnTap,
              leading: Icon(
                Icons.dark_mode,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                'Theme Mode',
                style: AppTextStyles.medium18
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.settingsSectionBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  appThemeMode.label,
                  style: AppTextStyles.regular16
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            OptionItem(
              onTap: languageOnTap,
              leading: Icon(
                Icons.language,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                'Language',
                style: AppTextStyles.medium18
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.settingsSectionBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  appLanguage.label,
                  style: AppTextStyles.regular16
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
