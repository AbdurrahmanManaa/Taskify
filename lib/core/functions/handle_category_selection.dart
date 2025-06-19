import 'package:flutter/material.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';

void handleCategorySelection({
  required bool selected,
  required BuildContext context,
  required TaskCategoryEntity category,
  required List<TaskCategoryEntity> selectedCategories,
}) {
  if (selected) {
    if (selectedCategories.length >= 3) {
      buildSnackbar(
        context,
        message: 'You can select up to 3 categories only',
      );
      return;
    }
    if (!selectedCategories.any((c) => c.name == category.name)) {
      selectedCategories.add(category);
    }
  } else {
    selectedCategories.removeWhere((c) => c.name == category.name);
  }
}
