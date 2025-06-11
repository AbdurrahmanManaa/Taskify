import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';

extension TaskStatusX on TaskStatus {
  String get label {
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
  String get label {
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
