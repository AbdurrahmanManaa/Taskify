import 'package:taskify/features/home/domain/entities/task_entity.dart';

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
