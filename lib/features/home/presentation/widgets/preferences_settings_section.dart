import 'package:flutter/material.dart';
import 'package:taskify/core/extensions/user_preferences_extension.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/presentation/widgets/settings_section.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/generated/l10n.dart';

class PreferencesSettingsSection extends StatelessWidget {
  const PreferencesSettingsSection({
    super.key,
    this.appIconBadgesOnTap,
    this.appThemeModeOnTap,
    this.appSchemeOnTap,
    this.appLanguageOnTap,
    this.appFontOnTap,
  });
  final Function()? appIconBadgesOnTap;
  final Function()? appThemeModeOnTap;
  final Function()? appSchemeOnTap;
  final Function()? appLanguageOnTap;
  final Function()? appFontOnTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.preferencesNotifier,
      builder: (context, value, _) {
        final isNotificationsEnabled = value.isNotificationsEnabled;
        final badgeStyle = value.appIconBadgeStyle;
        final appThemeMode = value.appThemeMode;
        final appScheme = value.appScheme;
        final appLanguage = value.appLanguage;
        final appFont = value.appFont;
        final badgeStyleLabel = badgeStyle.label(context);
        final appThemeModeLabel = appThemeMode.label(context);
        final appSchemeLabel = appScheme.label(context);
        final appLanguageLabel = appLanguage.label(context);
        final appFontLabel = appFont.label(context);

        return SettingsSection(
          title: S.of(context).preferencesSectionTitle,
          widgets: [
            const SizedBox(height: 20),
            OptionItem(
              leading: Icon(
                Icons.notifications_active,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                S.of(context).notificationsOptionItem,
                style: AppTextStyles.medium18
                    .copyWith(color: AppColors.primaryLightColor),
              ),
              trailing: Switch(
                value: isNotificationsEnabled,
                onChanged: (newValue) {
                  final updated = value.copyWith(
                    isNotificationEnabled: newValue,
                  );
                  HiveService().setUserPreferences(updated);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            OptionItem(
              onTap: appIconBadgesOnTap,
              leading: Image.asset(
                AppAssets.imagesBadgeStyle,
                height: 30,
                width: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                S.of(context).badgeStyleOptionItem,
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
                  badgeStyleLabel,
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
                Icons.palette,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                S.of(context).themeModeOptionItem,
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
                  appThemeModeLabel,
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
              onTap: appSchemeOnTap,
              leading: Icon(
                Icons.colorize,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                S.of(context).schemeColorOptionItem,
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
                  appSchemeLabel,
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
              onTap: appLanguageOnTap,
              leading: Icon(
                Icons.language,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                S.of(context).languageOptionItem,
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
                  appLanguageLabel,
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
              onTap: appFontOnTap,
              leading: Icon(
                Icons.text_fields,
                size: 30,
                color: AppColors.primaryLightColor,
              ),
              title: Text(
                S.of(context).fontOptionItem,
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
                  appFontLabel,
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
