import 'package:day_picker/model/day_in_week.dart';
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

const List<String> repeatOptions = [
  'Don\'t repeat',
  'Everyday',
  'Every week',
  'Every month',
  'Every year',
];
const List<String> repeatDurations = [
  'Forever',
  'Specific number of times',
  'Until',
];
const List<String> days = [
  'Saturday',
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday'
];
final List<DayInWeek> weekDays = [
  DayInWeek('Sunday', dayKey: 'Sun'),
  DayInWeek('Monday', dayKey: 'Mon'),
  DayInWeek('Tuesday', dayKey: 'Tue'),
  DayInWeek(
    'Wednesday',
    dayKey: 'Wed',
    isSelected: true,
  ),
  DayInWeek('Thursday', dayKey: 'Thu'),
  DayInWeek('Friday', dayKey: 'Fri'),
  DayInWeek('Saturday', dayKey: 'Sat'),
];

const Map<String, int> repeatMaxValues = {
  'Everyday': 365,
  'Every week': 52,
  'Every month': 12,
  'Every year': 10,
  'Specific number of times': 100,
};
