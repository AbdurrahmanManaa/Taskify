import 'package:flutter/material.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/generated/l10n.dart';

Future<dynamic> showPrioritySelectionModalSheet(
  BuildContext context,
  TaskPriority selectedTaskPriority,
) {
  return showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: AppColors.scaffoldLightBackgroundColor,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).showPrioritySelectionModalSheetTitle,
              style: AppTextStyles.medium24.copyWith(
                color: AppColors.primaryLightColor,
              ),
            ),
            Divider(),
            ...List.generate(TaskPriority.values.length, (index) {
              final e = TaskPriority.values[index];
              final isLast = index == TaskPriority.values.length - 1;
              final isSelected = e == selectedTaskPriority;
              final label = e.label(context);

              return Column(
                children: [
                  ListTile(
                    title: Text(
                      label,
                      style: AppTextStyles.medium18,
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check, color: AppColors.primaryLightColor)
                        : null,
                    onTap: () {
                      Navigator.pop(context, e);
                    },
                  ),
                  if (!isLast) Divider(),
                ],
              );
            }),
          ],
        ),
      );
    },
  );
}
