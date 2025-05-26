import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskify/features/home/domain/entities/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task_repeat_entity.dart';
import 'category_entity.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 1)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final DateTime dueDate;
  @HiveField(5)
  final String startTime;
  @HiveField(6)
  final String endTime;
  @HiveField(7)
  final TaskReminderEntity reminder;
  @HiveField(8)
  final TaskRepeatEntity repeat;
  @HiveField(9)
  final String priority;
  @HiveField(10)
  final List<CategoryEntity> categories;
  @HiveField(11)
  final String status;
  @HiveField(12)
  final DateTime? createdAt;
  @HiveField(13)
  final DateTime? completedAt;
  @HiveField(14)
  final DateTime? updatedAt;
  @HiveField(15)
  final DateTime? deletedAt;
  @HiveField(16)
  final int attachmentsCount;
  @HiveField(17)
  final int subtaskCount;

  TaskEntity({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    DateTime? dueDate,
    String? startTime,
    String? endTime,
    TaskReminderEntity? reminder,
    TaskRepeatEntity? repeat,
    String? priority,
    List<CategoryEntity>? categories,
    String? status,
    this.createdAt,
    this.completedAt,
    this.updatedAt,
    this.deletedAt,
    int? subtaskCount,
    int? attachmentsCount,
  })  : dueDate = dueDate ?? DateTime.now(),
        startTime = startTime ?? DateFormat('hh:mm a').format(DateTime.now()),
        endTime = endTime ?? '9:30 AM',
        reminder = reminder ??
            TaskReminderEntity(
              option: '10 mins before',
              value: 0,
              unit: 'Minutes',
            ),
        repeat = repeat ??
            TaskRepeatEntity(
              option: 'Don\'t repeat',
              duration: 'Forever',
              interval: 1,
              count: 0,
              weekDays: weekDays
                  .where((day) => day.isSelected == true)
                  .map((day) => day.dayKey)
                  .toList(),
              untilDate: null,
            ),
        priority = priority ?? 'Medium',
        categories = categories ?? [CategoryEntity.defaultCategory()],
        status = status ?? 'In Progress',
        subtaskCount = subtaskCount ?? 0,
        attachmentsCount = attachmentsCount ?? 0;

  TaskEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? dueDate,
    String? startTime,
    String? endTime,
    TaskReminderEntity? reminder,
    TaskRepeatEntity? repeat,
    String? priority,
    List<CategoryEntity>? categories,
    String? status,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? subtaskCount,
    int? attachmentsCount,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      reminder: reminder ?? this.reminder,
      repeat: repeat ?? this.repeat,
      priority: priority ?? this.priority,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      subtaskCount: subtaskCount ?? this.subtaskCount,
      attachmentsCount: attachmentsCount ?? this.attachmentsCount,
    );
  }
}

const List<String> priorities = ['Low', 'Medium', 'High'];
