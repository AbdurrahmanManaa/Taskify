import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';

class CustomCheck extends StatelessWidget {
  const CustomCheck(
      {super.key, required this.isChecked, required this.onChecked});
  final bool isChecked;
  final ValueChanged<bool> onChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked(!isChecked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 24,
        height: 24,
        decoration: ShapeDecoration(
          color: isChecked
              ? AppColors.primaryLightColor
              : AppColors.scaffoldLightBackgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.50,
              color: isChecked
                  ? AppColors.transparentColor
                  : const Color(0xFFDCDEDE),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
