import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.title,
    required this.tapText,
    this.onTap,
  });
  final String title, tapText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppTextStyles.regular16
                .copyWith(color: AppColors.bodyTextColor),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: tapText,
            style: AppTextStyles.medium16
                .copyWith(color: AppColors.primaryLightColor),
          ),
        ],
      ),
    );
  }
}
