import 'package:flutter/material.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';

List<TaskEntity> filterTasks(List<TaskEntity> tasks, String filterType) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime tomorrow = today.add(Duration(days: 1));
  DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
  DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
  DateTime startOfMonth = DateTime(now.year, now.month, 1);
  DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
  DateTime startOfYear = DateTime(now.year, 1, 1);
  DateTime endOfYear = DateTime(now.year + 1, 1, 1);

  switch (filterType) {
    case 'today':
      return tasks
          .where((task) =>
              DateUtils.isSameDay(task.dueDate, today) &&
              task.status == TaskStatus.inProgress)
          .toList();
    case 'tomorrow':
      return tasks
          .where((task) =>
              DateUtils.isSameDay(task.dueDate, tomorrow) &&
              task.status == TaskStatus.inProgress)
          .toList();
    case 'thisWeek':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(startOfWeek) &&
              task.dueDate.isBefore(endOfWeek.add(Duration(days: 1))) &&
              task.status == TaskStatus.inProgress)
          .toList();
    case 'thisMonth':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(startOfMonth) &&
              task.dueDate.isBefore(endOfMonth.add(Duration(days: 1))) &&
              task.status == TaskStatus.inProgress)
          .toList();
    case 'thisYear':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(startOfYear) &&
              task.dueDate.isBefore(endOfYear) &&
              task.status == TaskStatus.inProgress)
          .toList();
    case 'upcoming':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(today) &&
              task.status == TaskStatus.inProgress)
          .toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    case 'overdue':
      return tasks
          .where((task) =>
              task.dueDate.isBefore(today) && task.status == TaskStatus.overdue)
          .toList()
        ..sort((a, b) => b.dueDate.compareTo(a.dueDate));
    case 'completed':
      return tasks.where((task) => task.status == TaskStatus.completed).toList()
        ..sort((a, b) =>
            (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
    case 'trash':
      return tasks.where((task) => task.status == TaskStatus.trash).toList()
        ..sort((a, b) =>
            (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
    case 'inProgress':
      return tasks
          .where((task) => task.status == TaskStatus.inProgress)
          .toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    case 'lowPriority':
      return tasks.where((task) => task.priority == TaskPriority.low).toList();
    case 'mediumPriority':
      return tasks
          .where((task) => task.priority == TaskPriority.medium)
          .toList();
    case 'highPriority':
      return tasks.where((task) => task.priority == TaskPriority.high).toList();
    default:
      return tasks;
  }
}
