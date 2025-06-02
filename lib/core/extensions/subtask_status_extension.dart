import 'package:taskify/features/home/domain/entities/subtask/subtask_status.dart';

extension SubtaskStatusX on SubtaskStatus {
  String get label {
    switch (this) {
      case SubtaskStatus.inProgress:
        return 'In Progress';
      case SubtaskStatus.completed:
        return 'Completed';
    }
  }

  static SubtaskStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'in progress':
        return SubtaskStatus.inProgress;
      case 'completed':
        return SubtaskStatus.completed;
      default:
        return SubtaskStatus.inProgress;
    }
  }
}
