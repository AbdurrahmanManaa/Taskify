import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/generated/l10n.dart';

Future<dynamic> showThemeModeSelectionModalSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: AppColors.scaffoldLightBackgroundColor,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).showThemeModeSelectionModalSheetTitle,
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
                S.of(context).ThemeModeSelectionOption1,
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
                S.of(context).ThemeModeSelectionOption2,
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
                S.of(context).ThemeModeSelectionOption3,
                style: AppTextStyles.medium18,
              ),
            ),
          ],
        ),
      );
    },
  );
}
