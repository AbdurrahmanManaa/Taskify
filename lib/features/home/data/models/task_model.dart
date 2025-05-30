import 'package:flutter/material.dart';
import 'package:taskify/core/extensions/task_priority_extension.dart';
import 'package:taskify/core/extensions/task_status_extension.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
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
  final DateTime startTime;
  final DateTime endTime;
  final TaskReminderEntity reminder;
  final TaskRepeatEntity repeat;
  final TaskPriority priority;
  final List<CategoryEntity> categories;
  final TaskStatus status;
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

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTimeUtils.parseIsoDateTime(json['due_date']),
      startTime:
          DateTimeUtils.parseTimeFrom24HourWithSeconds(json['start_time']),
      endTime: DateTimeUtils.parseTimeFrom24HourWithSeconds(json['end_time']),
      reminder: TaskReminderEntity(
        option: json['reminder']['option'] ?? 'Custom',
        value: json['reminder']['value'] ?? 0,
        unit: json['reminder']['unit'] ?? 'Minutes',
      ),
      repeat: TaskRepeatEntity(
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
      ),
      priority: json['priority'] != null
          ? TaskPriorityX.fromString(json['priority'])
          : TaskPriority.medium,
      categories: (json['categories'] as List)
          .map((e) => CategoryEntity(
                name: e['name'],
                icon: IconData(e['icon'], fontFamily: 'MaterialIcons'),
                color: Color(e['color']),
              ))
          .toList(),
      status: json['status'] != null
          ? TaskStatusX.fromString(json['status'])
          : TaskStatus.inProgress,
      createdAt: json['created_at'] != null
          ? DateTimeUtils.parseIsoDateTime(json['created_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTimeUtils.parseIsoDateTime(json['completed_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTimeUtils.parseIsoDateTime(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTimeUtils.parseIsoDateTime(json['deleted_at'])
          : null,
      subtaskCount: json['subtask_count'],
      attachmentsCount: json['attachments_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'due_date': DateTimeUtils.formatIsoDateTime(dueDate),
      'start_time': DateTimeUtils.formatTimeTo24HourWithSeconds(startTime),
      'end_time': DateTimeUtils.formatTimeTo24HourWithSeconds(endTime),
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
      'priority': priority.label,
      'categories': categories
          .map((c) => {
                'name': c.name,
                'icon': c.icon.codePoint,
                'color': c.color.toARGB32(),
              })
          .toList(),
      'status': status.label,
      'attachments_count': attachmentsCount,
      'subtask_count': subtaskCount,
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
