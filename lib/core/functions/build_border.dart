import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';

OutlineInputBorder buildBorder([Color? borderColor, double? radius]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 8),
    borderSide: BorderSide(
      color: borderColor ?? AppColors.transparentColor,
    ),
  );
}
