import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyles.medium18,
      ),
    );
  }
}
