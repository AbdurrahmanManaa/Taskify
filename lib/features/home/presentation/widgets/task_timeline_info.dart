import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';

class TaskTimelineInfo extends StatelessWidget {
  const TaskTimelineInfo({super.key, required this.taskDetails});
  final TaskEntity taskDetails;

  @override
  Widget build(BuildContext context) {
    String formattedCreationTime =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(taskDetails.createdAt!);
    String? formattedCompletionTime = taskDetails.completedAt != null
        ? DateFormat('yyyy-MM-dd hh:mm:ss').format(taskDetails.completedAt!)
        : null;
    String? formattedUpdateTime = taskDetails.updatedAt != null
        ? DateFormat('yyyy-MM-dd hh:mm:ss').format(taskDetails.updatedAt!)
        : null;
    String? formattedDeletedTime = taskDetails.deletedAt != null
        ? DateFormat('yyyy-MM-dd hh:mm:ss').format(taskDetails.deletedAt!)
        : null;

    return RichText(
      text: TextSpan(
        style: AppTextStyles.regular18.copyWith(color: AppColors.bodyTextColor),
        children: [
          TextSpan(
            text: 'Created at  ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: formattedCreationTime,
          ),
          if (taskDetails.completedAt != null &&
              formattedCompletionTime != null) ...[
            TextSpan(
              text: '\nCompleted at  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: formattedCompletionTime,
              style: TextStyle(height: 1.5),
            ),
          ],
          if (formattedUpdateTime != null) ...[
            TextSpan(
              text: '\nUpdated at  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: formattedUpdateTime,
              style: TextStyle(height: 1.5),
            ),
          ],
          if (taskDetails.status == TaskStatus.trash &&
              formattedDeletedTime != null) ...[
            TextSpan(
              text: '\nDeleted at  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: formattedDeletedTime,
              style: TextStyle(height: 1.5),
            ),
          ],
        ],
      ),
    );
  }
}
