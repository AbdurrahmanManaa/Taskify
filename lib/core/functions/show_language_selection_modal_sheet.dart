import 'package:flutter/material.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_fonts.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/generated/l10n.dart';

Future<dynamic> showLanguageSelectionModalSheet(BuildContext context) {
  final prefs = HiveService.preferencesNotifier.value;
  final language = prefs.appLanguage;

  return showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: AppColors.scaffoldLightBackgroundColor,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).showLanguageSelectionModalSheetTitle,
              style: AppTextStyles.medium24
                  .copyWith(color: AppColors.primaryLightColor),
            ),
            Divider(),
            OptionItem(
              onTap: () async {
                final updated = prefs.copyWith(
                  appLanguage: AppLanguage.english,
                  appFont: AppFonts.inter,
                );
                await HiveService().setUserPreferences(updated);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
              leading: Image.asset(AppAssets.imagesUsa),
              title: Text(
                S.of(context).LanguageSelectionOption1,
                style: AppTextStyles.medium18,
              ),
              trailing: language == AppLanguage.english
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
                  appLanguage: AppLanguage.arabic,
                  appFont: AppFonts.cairo,
                );
                await HiveService().setUserPreferences(updated);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
              leading: Image.asset(AppAssets.imagesKsa),
              title: Text(
                S.of(context).LanguageSelectionOption2,
                style: AppTextStyles.medium18,
              ),
              trailing: language == AppLanguage.arabic
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
