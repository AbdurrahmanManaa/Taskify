import 'package:flutter/material.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/generated/l10n.dart';

extension TaskStatusX on TaskStatus {
  String label(BuildContext context) {
    switch (this) {
      case TaskStatus.inProgress:
        return S.of(context).taskStatusInProgress;
      case TaskStatus.completed:
        return S.of(context).taskStatusCompleted;
      case TaskStatus.overdue:
        return S.of(context).taskStatusOverdue;
      case TaskStatus.trash:
        return S.of(context).taskStatusTrash;
    }
  }

  String get labelDB {
    switch (this) {
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.overdue:
        return 'Overdue';
      case TaskStatus.trash:
        return 'Trash';
    }
  }

  static TaskStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'in progress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      case 'overdue':
        return TaskStatus.overdue;
      case 'trash':
        return TaskStatus.trash;
      default:
        return TaskStatus.inProgress;
    }
  }
}

extension TaskPriorityX on TaskPriority {
  String label(BuildContext context) {
    switch (this) {
      case TaskPriority.low:
        return S.of(context).taskPriorityLow;
      case TaskPriority.medium:
        return S.of(context).taskPriorityMedium;
      case TaskPriority.high:
        return S.of(context).taskPriorityHigh;
    }
  }

  String get labelDB {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }

  static TaskPriority fromString(String value) {
    switch (value.toLowerCase()) {
      case 'low':
        return TaskPriority.low;
      case 'medium':
        return TaskPriority.medium;
      case 'high':
        return TaskPriority.high;
      default:
        return TaskPriority.medium;
    }
  }
}
