import 'package:hive_flutter/hive_flutter.dart';

part 'task_reminder_entity.g.dart';

@HiveType(typeId: 5)
class TaskReminderEntity extends HiveObject {
  @HiveField(0)
  final String option;
  @HiveField(1)
  final int value;
  @HiveField(2)
  final String unit;

  TaskReminderEntity({
    required this.option,
    required this.value,
    required this.unit,
  });

  TaskReminderEntity copyWith({
    String? option,
    int? value,
    String? unit,
  }) {
    return TaskReminderEntity(
      option: option ?? this.option,
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }
}

const List<String> reminderUnits = [
  'Minutes',
  'Hours',
  'Days',
  'Weeks',
];
const Map<String, int> reminderMaxValues = {
  'Minutes': 360,
  'Hours': 99,
  'Days': 365,
  'Weeks': 52,
};
