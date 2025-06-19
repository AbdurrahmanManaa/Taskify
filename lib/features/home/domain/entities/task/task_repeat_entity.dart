import 'package:hive_flutter/hive_flutter.dart';

part 'task_repeat_entity.g.dart';

@HiveType(typeId: 6)
class TaskRepeatEntity {
  @HiveField(0)
  final int interval;
  @HiveField(1)
  final String option;
  @HiveField(2)
  final String duration;
  @HiveField(3)
  final int count;
  @HiveField(4)
  final List<String> weekDays;
  @HiveField(5)
  final DateTime? untilDate;

  TaskRepeatEntity({
    required this.interval,
    required this.option,
    required this.duration,
    required this.count,
    required this.weekDays,
    this.untilDate,
  });

  TaskRepeatEntity copyWith({
    int? interval,
    String? option,
    String? duration,
    int? count,
    List<String>? weekDays,
    DateTime? untilDate,
  }) {
    return TaskRepeatEntity(
      interval: interval ?? this.interval,
      option: option ?? this.option,
      duration: duration ?? this.duration,
      count: count ?? this.count,
      weekDays: weekDays ?? this.weekDays,
      untilDate: untilDate ?? this.untilDate,
    );
  }
}
