import 'package:flutter/material.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final prefs = HiveService.preferencesNotifier.value;
    final language = prefs.appLanguage;

    return Align(
      alignment: language == AppLanguage.english
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Text(
        label,
        style: AppTextStyles.medium18,
      ),
    );
  }
}
