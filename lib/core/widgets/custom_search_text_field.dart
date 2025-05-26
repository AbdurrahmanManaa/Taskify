import 'package:flutter/material.dart';
import 'package:taskify/core/functions/build_border.dart';
import 'package:taskify/core/utils/app_colors.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomSearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.greyColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        filled: true,
        fillColor: AppColors.inputDecorationLightFillColor,
        border: buildBorder(Color(0xFFB8B8B8), 10),
        enabledBorder: buildBorder(Color(0xFFB8B8B8), 10),
        focusedBorder: buildBorder(Color(0xFFB8B8B8), 10),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
