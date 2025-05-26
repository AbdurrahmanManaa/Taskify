import 'package:flutter/material.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';

class PreferencesSettingsSection extends StatelessWidget {
  const PreferencesSettingsSection({
    super.key,
    required this.isNotificationsToggleActive,
    required this.isDarkModeToggleActive,
    this.toggleNotifications,
    this.languageOnTap,
    this.toggleDarkMode,
    this.appIconBadgesOnTap,
  });
  final bool isNotificationsToggleActive;
  final bool isDarkModeToggleActive;
  final Function(bool)? toggleNotifications;
  final Function(bool)? toggleDarkMode;
  final Function()? appIconBadgesOnTap;
  final Function()? languageOnTap;

  @override
  Widget build(BuildContext context) {
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
          trailing: GestureDetector(
            onTap: appIconBadgesOnTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.settingsSectionBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Dot',
                style: AppTextStyles.regular16
                    .copyWith(color: AppColors.primaryLightColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        OptionItem(
          leading: Icon(
            Icons.dark_mode,
            size: 30,
            color: AppColors.primaryLightColor,
          ),
          title: Text(
            'Dark Mode',
            style: AppTextStyles.medium18
                .copyWith(color: AppColors.primaryLightColor),
          ),
          trailing: ValueListenableBuilder(
            valueListenable: HiveService.preferencesNotifier,
            builder: (context, value, child) {
              return Switch(
                value: value.isDarkMode,
                onChanged: toggleDarkMode,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        OptionItem(
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
          trailing: GestureDetector(
            onTap: languageOnTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.settingsSectionBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'English',
                style: AppTextStyles.regular16
                    .copyWith(color: AppColors.primaryLightColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
