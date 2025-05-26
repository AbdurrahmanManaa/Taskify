import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';

class CustomTagContainer extends StatelessWidget {
  const CustomTagContainer(
      {super.key,
      required this.iconColor,
      required this.iconCodePoint,
      required this.title});
  final Color iconColor;
  final int iconCodePoint;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderColor,
        ),
        color: AppColors.transparentColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            IconData(
              iconCodePoint,
              fontFamilyFallback: const ['MaterialIcons', 'CupertinoIcons'],
            ),
            color: iconColor,
          ),
          const SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }
}
