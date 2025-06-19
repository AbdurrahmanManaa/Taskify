import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/subtask/sub_task_entity.dart';
import 'package:taskify/generated/l10n.dart';

class SubtasksCompletionProgress extends StatelessWidget {
  const SubtasksCompletionProgress({
    super.key,
    required this.subtasks,
    required this.completedSubtasks,
  });

  final List<SubtaskEntity> subtasks;
  final List<SubtaskEntity> completedSubtasks;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).todoList,
          style: AppTextStyles.medium18,
        ),
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: CircularProgressIndicator(
                value: subtasks.isNotEmpty
                    ? completedSubtasks.length / subtasks.length
                    : 0.0,
                backgroundColor: AppColors.greyColor.withAlpha(76),
                color: completedSubtasks.length == subtasks.length
                    ? Colors.green
                    : Colors.blue,
                strokeWidth: 6,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${completedSubtasks.length} / ${subtasks.length}',
              style: AppTextStyles.medium18,
            ),
          ],
        ),
      ],
    );
  }
}
