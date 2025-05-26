import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';

class CustomWrapperContainer extends StatelessWidget {
  const CustomWrapperContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.inputDecorationLightFillColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
