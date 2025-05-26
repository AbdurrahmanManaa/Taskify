import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.settingsSectionBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: AppTextStyles.semiBold20.copyWith(
          color: AppColors.primaryLightColor,
        ),
      ),
    );
  }
}
