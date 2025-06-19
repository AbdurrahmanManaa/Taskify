import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';

class TaskUIHelper {
  static Widget buildStatusTag(BuildContext context, TaskStatus status) {
    final details = getStatusDetails(status);
    final Color statusColor = details['color'] as Color;
    final label = status.label(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(51),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  static Map<String, dynamic> getPriorityDetails(TaskPriority? priority) {
    switch (priority) {
      case TaskPriority.high:
        return {
          'color': AppColors.errorColor,
          'icon': Icons.circle_rounded,
        };
      case TaskPriority.medium:
        return {
          'color': Colors.orange,
          'icon': Icons.circle_rounded,
        };
      case TaskPriority.low:
        return {
          'color': Colors.green,
          'icon': Icons.circle_rounded,
        };
      default:
        return {
          'color': AppColors.greyColor,
          'icon': Icons.circle_rounded,
        };
    }
  }

  static Map<String, dynamic> getStatusDetails(TaskStatus? status) {
    switch (status) {
      case TaskStatus.inProgress:
        return {
          'icon': FontAwesomeIcons.circle,
          'color': AppColors.primaryLightColor,
        };
      case TaskStatus.completed:
        return {
          'icon': FontAwesomeIcons.circleCheck,
          'color': Colors.green,
        };
      case TaskStatus.overdue:
        return {
          'icon': FontAwesomeIcons.circleExclamation,
          'color': AppColors.errorColor,
        };
      case TaskStatus.trash:
        return {
          'icon': FontAwesomeIcons.trash,
          'color': AppColors.greyColor,
        };
      default:
        return {
          'icon': FontAwesomeIcons.circle,
          'color': AppColors.greyColor,
        };
    }
  }
}
