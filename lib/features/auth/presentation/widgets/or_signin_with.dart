import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'Or',
          textAlign: TextAlign.center,
          style: AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
        ),
        const SizedBox(width: 5),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
