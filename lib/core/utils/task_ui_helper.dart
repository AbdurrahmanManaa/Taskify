import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskify/core/utils/app_colors.dart';

class TaskUIHelper {
  static Widget buildStatusTag(String status) {
    final details = getStatusDetails(status);
    final Color statusColor = details['color'] as Color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  static Map<String, dynamic> getPriorityDetails(String? priority) {
    switch (priority) {
      case 'High':
        return {
          'color': AppColors.errorColor,
          'icon': Icons.circle_rounded,
        };
      case 'Medium':
        return {
          'color': Colors.orange,
          'icon': Icons.circle_rounded,
        };
      case 'Low':
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

  static Map<String, dynamic> getStatusDetails(String status) {
    switch (status) {
      case 'In Progress':
        return {
          'icon': FontAwesomeIcons.circle,
          'color': AppColors.primaryLightColor,
        };
      case 'Completed':
        return {
          'icon': FontAwesomeIcons.circleCheck,
          'color': Colors.green,
        };
      case 'Overdue':
        return {
          'icon': FontAwesomeIcons.circleExclamation,
          'color': AppColors.errorColor,
        };
      case 'Trash':
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
