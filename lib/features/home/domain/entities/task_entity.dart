import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/features/home/domain/entities/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task_repeat_entity.dart';

import 'category_entity.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 2)
enum TaskPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}

@HiveType(typeId: 3)
enum TaskStatus {
  @HiveField(0)
  inProgress,
  @HiveField(1)
  completed,
  @HiveField(2)
  overdue,
  @HiveField(3)
  trash,
}

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
  final DateTime startTime;
  @HiveField(6)
  final DateTime endTime;
  @HiveField(7)
  final TaskReminderEntity reminder;
  @HiveField(8)
  final TaskRepeatEntity repeat;
  @HiveField(9)
  final TaskPriority priority;
  @HiveField(10)
  final List<CategoryEntity> categories;
  @HiveField(11)
  final TaskStatus status;
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
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.repeat,
    required this.priority,
    required this.categories,
    required this.status,
    this.createdAt,
    this.completedAt,
    this.updatedAt,
    this.deletedAt,
    required this.attachmentsCount,
    required this.subtaskCount,
  });

  TaskEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? dueDate,
    DateTime? startTime,
    DateTime? endTime,
    TaskReminderEntity? reminder,
    TaskRepeatEntity? repeat,
    TaskPriority? priority,
    List<CategoryEntity>? categories,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? attachmentsCount,
    int? subtaskCount,
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
      attachmentsCount: attachmentsCount ?? this.attachmentsCount,
      subtaskCount: subtaskCount ?? this.subtaskCount,
    );
  }
}
