import 'package:flutter/material.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/generated/l10n.dart';

Future<void> deleteCustomTaskCategory(
  BuildContext context,
  TaskCategoryEntity category,
) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      title: Text(S.of(context).deleteCategoryTitle),
      content: Text(S.of(context).deleteCategoryContent),
      actions: [
        TextButton(
          child: Text(
            S.of(context).cancelModalSheetButton,
            style: TextStyle(color: AppColors.primaryLightColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(
            S.of(context).deleteModalSheetButton,
            style: TextStyle(color: AppColors.primaryLightColor),
          ),
          onPressed: () async {
            await HiveService().deleteCategory(category.name);
            if (!context.mounted) return;
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
