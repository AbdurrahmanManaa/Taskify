import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/generated/l10n.dart';

class TaskTimelineInfo extends StatelessWidget {
  const TaskTimelineInfo({super.key, required this.taskDetails});
  final TaskEntity taskDetails;

  @override
  Widget build(BuildContext context) {
    String formattedCreationTime =
        DateTimeUtils.formatDateTimeWithSeconds(taskDetails.createdAt!);
    String? formattedCompletionTime = taskDetails.completedAt != null
        ? DateTimeUtils.formatDateTimeWithSeconds(taskDetails.completedAt!)
        : null;
    String? formattedUpdateTime = taskDetails.updatedAt != null
        ? DateTimeUtils.formatDateTimeWithSeconds(taskDetails.updatedAt!)
        : null;
    String? formattedDeletedTime = taskDetails.deletedAt != null
        ? DateTimeUtils.formatDateTimeWithSeconds(taskDetails.deletedAt!)
        : null;

    return RichText(
      text: TextSpan(
        style: AppTextStyles.regular18.copyWith(color: AppColors.bodyTextColor),
        children: [
          TextSpan(
            text: S.of(context).createdAt,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: formattedCreationTime,
          ),
          if (taskDetails.completedAt != null &&
              formattedCompletionTime != null) ...[
            TextSpan(
              text: S.of(context).completedAt,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: formattedCompletionTime,
              style: TextStyle(height: 1.5),
            ),
          ],
          if (formattedUpdateTime != null) ...[
            TextSpan(
              text: S.of(context).updatedAt,
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
              text: S.of(context).deletedAt,
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
