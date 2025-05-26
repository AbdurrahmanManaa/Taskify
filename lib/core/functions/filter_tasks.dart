import 'package:flutter/material.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';

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
              task.status == 'In Progress')
          .toList();
    case 'tomorrow':
      return tasks
          .where((task) =>
              DateUtils.isSameDay(task.dueDate, tomorrow) &&
              task.status == 'In Progress')
          .toList();
    case 'thisWeek':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(startOfWeek) &&
              task.dueDate.isBefore(endOfWeek.add(Duration(days: 1))) &&
              task.status == 'In Progress')
          .toList();
    case 'thisMonth':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(startOfMonth) &&
              task.dueDate.isBefore(endOfMonth.add(Duration(days: 1))) &&
              task.status == 'In Progress')
          .toList();
    case 'thisYear':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(startOfYear) &&
              task.dueDate.isBefore(endOfYear) &&
              task.status == 'In Progress')
          .toList();
    case 'upcoming':
      return tasks
          .where((task) =>
              task.dueDate.isAfter(today) && task.status == 'In Progress')
          .toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    case 'overdue':
      return tasks
          .where((task) =>
              task.dueDate.isBefore(today) && task.status == 'Overdue')
          .toList()
        ..sort((a, b) => b.dueDate.compareTo(a.dueDate));
    case 'completed':
      return tasks.where((task) => task.status == 'Completed').toList()
        ..sort((a, b) =>
            (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
    case 'trash':
      return tasks.where((task) => task.status == 'Trash').toList()
        ..sort((a, b) =>
            (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
    case 'inProgress':
      return tasks.where((task) => task.status == 'In Progress').toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    case 'lowPriority':
      return tasks.where((task) => task.priority == 'Low').toList();
    case 'mediumPriority':
      return tasks.where((task) => task.priority == 'Medium').toList();
    case 'highPriority':
      return tasks.where((task) => task.priority == 'High').toList();
    default:
      return tasks;
  }
}
