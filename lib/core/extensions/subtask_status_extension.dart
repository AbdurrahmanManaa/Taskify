import 'package:flutter/material.dart';
import 'package:taskify/features/home/domain/entities/subtask/subtask_status.dart';
import 'package:taskify/generated/l10n.dart';

extension SubtaskStatusX on SubtaskStatus {
  String label(BuildContext context) {
    switch (this) {
      case SubtaskStatus.inProgress:
        return S.of(context).subtaskStatusInProgress;
      case SubtaskStatus.completed:
        return S.of(context).subtaskStatusCompleted;
    }
  }

  String get labelDB {
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
