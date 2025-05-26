import 'package:intl/intl.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/domain/entities/category_entity.dart';
import 'package:taskify/features/home/domain/entities/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task_repeat_entity.dart';

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime dueDate;
  final String startTime;
  final String endTime;
  final TaskReminderEntity reminder;
  final TaskRepeatEntity repeat;
  final String priority;
  final List<CategoryEntity> categories;
  final String status;
  final DateTime? createdAt;
  final DateTime? completedAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int subtaskCount;
  final int attachmentsCount;

  TaskModel({
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
    this.subtaskCount = 0,
    this.attachmentsCount = 0,
  })  : dueDate = dueDate ??
            DateFormat('yyyy-MM-dd')
                .parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
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
              weekDays: [],
              untilDate: null,
            ),
        priority = priority ?? 'Medium',
        categories = categories ?? [CategoryEntity.defaultCategory()],
        status = status ?? 'In Progress';

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      dueDate:
          json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      startTime: json['start_time'],
      endTime: json['end_time'],
      reminder: json['reminder'] != null
          ? TaskReminderEntity(
              option: json['reminder']['option'] ?? 'Custom',
              value: json['reminder']['value'] ?? 0,
              unit: json['reminder']['unit'] ?? 'Minutes',
            )
          : TaskReminderEntity(
              option: '10 mins before',
              value: 0,
              unit: 'Minutes',
            ),
      repeat: json['repeat'] != null
          ? TaskRepeatEntity(
              option: json['repeat']['option'] ?? 'Don\'t repeat',
              duration: json['repeat']['duration'] ?? 'Forever',
              interval: json['repeat']['interval'] ?? 1,
              count: json['repeat']['count'] ?? 0,
              weekDays: json['repeat']['week_days'] != null
                  ? List<String>.from(json['repeat']['week_days'])
                  : [],
              untilDate: json['repeat']['until_date'] != null
                  ? DateTime.parse(json['repeat']['until_date'])
                  : null,
            )
          : TaskRepeatEntity(
              option: 'Don\'t repeat',
              duration: 'Forever',
              interval: 1,
              count: 0,
              weekDays: [],
              untilDate: null,
            ),
      priority: json['priority'],
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => CategoryEntity.fromJson(e))
              .toList()
          : [CategoryEntity.defaultCategory()],
      status: json['status'] ?? 'In Progress',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      subtaskCount: json['subtask_count'] ?? 0,
      attachmentsCount: json['attachments_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'reminder': {
        'option': reminder.option,
        'value': reminder.value,
        'unit': reminder.unit,
      },
      'repeat': {
        'option': repeat.option,
        'duration': repeat.duration,
        'interval': repeat.interval,
        'count': repeat.count,
        'week_days': repeat.weekDays,
        'until_date': repeat.untilDate?.toIso8601String(),
      },
      'priority': priority,
      'categories': categories.map((c) => c.toJson()).toList(),
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      dueDate: entity.dueDate,
      startTime: entity.startTime,
      endTime: entity.endTime,
      reminder: entity.reminder,
      repeat: entity.repeat,
      priority: entity.priority,
      categories: entity.categories,
      status: entity.status,
      createdAt: entity.createdAt,
      completedAt: entity.completedAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      subtaskCount: entity.subtaskCount,
      attachmentsCount: entity.attachmentsCount,
    );
  }

  TaskEntity toEntity({List<String>? attachmentUrls}) {
    return TaskEntity(
      id: id,
      userId: userId,
      title: title,
      description: description,
      dueDate: dueDate,
      startTime: startTime,
      endTime: endTime,
      reminder: reminder,
      repeat: repeat,
      priority: priority,
      categories: categories,
      status: status,
      createdAt: createdAt,
      completedAt: completedAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      subtaskCount: subtaskCount,
      attachmentsCount: attachmentsCount,
    );
  }
}
