import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskify/core/errors/exceptions.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/services/supabase_storage_service.dart';
import 'package:taskify/core/utils/endpoints.dart';
import 'package:taskify/core/utils/file_manager.dart';
import 'package:taskify/features/home/data/models/attachment_model.dart';
import 'package:taskify/features/home/data/models/sub_task_model.dart';
import 'package:taskify/features/home/data/models/task_model.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/domain/repos/home_repo.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class HomeRepoImpl implements HomeRepo {
  final SupabaseStorageService _supabaseStorage;
  final HiveService _hiveService;

  HomeRepoImpl(this._supabaseStorage, this._hiveService);

  List<TaskEntity> _tasks = [];
  List<SubtaskEntity> _subtasks = [];
  List<AttachmentEntity> _attachments = [];
  List<TaskEntity> _filteredTasks = [];

  @override
  List<TaskEntity> get tasks => _tasks;
  @override
  List<SubtaskEntity> get subtasks => _subtasks;
  @override
  List<AttachmentEntity> get attachments => _attachments;
  @override
  List<TaskEntity> get filteredTasks => _filteredTasks;

  @override
  Future<void> addTaskData({required TaskEntity taskEntity}) async {
    try {
      await _supabaseStorage.addData(
        table: Endpoints.tasksTable,
        data: TaskModel.fromEntity(taskEntity).toJson(),
        dataId: taskEntity.userId,
        column: 'user_id',
      );
      await refreshTasks(userId: taskEntity.userId);
    } catch (e) {
      log('Exception in HomeRepoImpl.addTaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<List<TaskEntity>> getAllTaskData({required String userId}) async {
    try {
      if (userId.isEmpty) {
        throw CustomException('User ID is missing. Cannot fetch tasks.');
      }

      final taskData = await _supabaseStorage.getAllData(
        table: Endpoints.tasksTable,
        dataId: userId,
        column: 'user_id',
      );

      final taskEntities =
          taskData.map((task) => TaskModel.fromJson(task).toEntity()).toList();

      _tasks = taskEntities;
      _filteredTasks = List.from(_tasks);
      await saveTaskData(taskEntities: _tasks);
      return _tasks;
    } catch (e) {
      log('Exception in HomeRepoImpl.getAllTaskData: $e');
      throw CustomException('Something went wrong while fetching tasks.');
    }
  }

  @override
  void filterTasks({
    String? query,
    List<String>? statuses,
    List<String>? priorities,
    List<String>? categories,
    List<String>? dueDates,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year + 1, 1, 1);

    _filteredTasks = _tasks.where((task) {
      final matchesQuery = query == null ||
          task.title.toLowerCase().contains(query.toLowerCase());

      final matchesStatus = statuses == null ||
          statuses.isEmpty ||
          statuses.contains(task.status);

      final matchesPriority = priorities == null ||
          priorities.isEmpty ||
          priorities.contains(task.priority);

      final matchesCategory = categories == null ||
          categories.isEmpty ||
          task.categories.any((cat) => categories.contains(cat.name));

      bool matchesDueDate = true;
      if (dueDates != null && dueDates.isNotEmpty) {
        matchesDueDate = dueDates.any((dateFilter) {
          switch (dateFilter) {
            case 'Today':
              return DateUtils.isSameDay(task.dueDate, today);
            case 'Tomorrow':
              return DateUtils.isSameDay(task.dueDate, tomorrow);
            case 'This Week':
              return task.dueDate.isAfter(startOfWeek) &&
                  task.dueDate.isBefore(endOfWeek.add(Duration(days: 1)));
            case 'This Month':
              return task.dueDate.isAfter(startOfMonth) &&
                  task.dueDate.isBefore(endOfMonth.add(Duration(days: 1)));
            case 'This Year':
              return task.dueDate.isAfter(startOfYear) &&
                  task.dueDate.isBefore(endOfYear);
            default:
              return true;
          }
        });
      }

      return matchesQuery &&
          matchesStatus &&
          matchesPriority &&
          matchesCategory &&
          matchesDueDate;
    }).toList();
  }

  @override
  void sortTasks({
    required String sortBy,
    bool ascending = true,
  }) {
    _filteredTasks.sort(
      (a, b) {
        int compare;

        switch (sortBy) {
          case 'dueDate':
            compare = (a.dueDate).compareTo(b.dueDate);
            break;
          case 'priority':
            const priorityOrder = {'High': 0, 'Medium': 1, 'Low': 2};
            compare = (priorityOrder[a.priority] ?? 1)
                .compareTo(priorityOrder[b.priority] ?? 1);
            break;
          case 'alphabet':
            compare = a.title.toLowerCase().compareTo(b.title.toLowerCase());
            break;
          default:
            compare = 0;
        }
        return ascending ? compare : -compare;
      },
    );
  }

  @override
  Future<void> addAttachmentsData({
    required List<File> files,
    required List<AttachmentEntity> baseEntities,
    required String taskId,
    required String userId,
  }) async {
    try {
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final base = baseEntities[i];

        final fileName = p.basename(file.path);
        final fileNameWithoutExtension = p.basenameWithoutExtension(file.path);
        final fileExtension = p.extension(file.path);
        final fileType = FileUtils.getFileType(fileName);
        final fileSize = await file.length();
        final path = '$userId/$taskId/$fileNameWithoutExtension$fileExtension';

        await _supabaseStorage.uploadFile(
          bucket: Endpoints.taskAttachmentsBucket,
          path: path,
          file: file,
        );

        await _hiveService.setFileCacheData(
          fileName: fileName,
          filePath: file.path,
          supabasePath: path,
        );

        final updatedAttachment = base.copyWith(
          id: Uuid().v4(),
          taskId: taskId,
          filePath: path,
          fileName: fileName,
          fileType: fileType,
          fileSize: fileSize,
          status: 'Uploaded',
          createdAt: DateTime.now(),
        );

        final data = AttachmentModel.fromEntity(updatedAttachment).toJson();

        await _supabaseStorage.addData(
          table: Endpoints.attachmentsTable,
          data: data,
          dataId: taskId,
          column: 'task_id',
        );
      }

      await refreshAttachments(taskId: taskId);
    } catch (e) {
      log('Exception in HomeRepoImpl.addAttachmentsData: ${e.toString()}');
      throw CustomException(
          'Something went wrong while uploading attachments.');
    }
  }

  @override
  Future<List<AttachmentEntity>> getAttachmentsData(
      {required String taskId}) async {
    try {
      final attachmentsData = await _supabaseStorage.getAllData(
        table: Endpoints.attachmentsTable,
        dataId: taskId,
        column: 'task_id',
      );

      final attachmentsEntities =
          await Future.wait(attachmentsData.map((task) async {
        final model = AttachmentModel.fromJson(task);

        final publicUrl = _supabaseStorage.getFileUrl(
          bucket: Endpoints.taskAttachmentsBucket,
          path: model.filePath,
        );

        return model.copyWith(fileUrl: await publicUrl).toEntity();
      }));

      _attachments = attachmentsEntities;
      await saveAttachmentsData(attachmentEntities: _attachments);
      return _attachments;
    } catch (e) {
      log('Exception in HomeRepoImpl.getAllTaskData: $e');
      throw CustomException('Something went wrong while fetching tasks.');
    }
  }

  @override
  Future<void> updateTaskData({
    required Map<String, dynamic> data,
    required String taskId,
    required String userId,
  }) async {
    try {
      if (data['reminder'] != null) {
        data['reminder'] = {
          'option': data['reminder']?.option,
          'value': data['reminder']?.value,
          'unit': data['reminder']?.unit,
        };
      }

      if (data['repeat'] != null) {
        data['repeat'] = {
          'option': data['repeat']?.option,
          'duration': data['repeat']?.duration,
          'interval': data['repeat']?.interval,
          'count': data['repeat']?.count,
          'week_days': data['repeat']?.weekDays,
          'until_date': data['repeat']?.untilDate?.toIso8601String(),
        };
      }

      await _supabaseStorage.updateData(
        table: Endpoints.tasksTable,
        data: data,
        dataId: taskId,
        column: 'id',
      );
      await refreshTasks(userId: userId);
    } catch (e) {
      log('Exception in HomeRepoImpl.updateTaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> saveTaskData({required List<TaskEntity> taskEntities}) async {
    try {
      await _hiveService.setTaskData(taskEntities);
    } catch (e) {
      log('Exception in HomeRepoImpl.saveTaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> saveAttachmentsData(
      {required List<AttachmentEntity> attachmentEntities}) async {
    try {
      await _hiveService.setAttachmentsData(attachmentEntities);
    } catch (e) {
      log('Exception in HomeRepoImpl.saveAttachmentsData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> refreshAttachments({required String taskId}) async {
    try {
      await getAttachmentsData(taskId: taskId);
    } catch (e) {
      log('Error refreshing attachments: $e');
      throw CustomException('Failed to refresh attachments.');
    }
  }

  @override
  Future<void> refreshTasks({required String userId}) async {
    try {
      _tasks = await getAllTaskData(userId: userId);
    } catch (e) {
      log('Error refreshing tasks: $e');
      throw CustomException('Failed to refresh tasks.');
    }
  }

  @override
  Future<void> addSubtaskData({
    required List<SubtaskEntity> subtaskEntities,
    required String taskId,
  }) async {
    try {
      List<Map<String, dynamic>> subtasksData = subtaskEntities
          .map((subTask) => SubtaskModel.fromEntity(
                subTask.copyWith(taskId: taskId),
              ).toJson())
          .toList();
      for (var data in subtasksData) {
        await _supabaseStorage.addData(
          table: Endpoints.subtasksTable,
          data: data,
          dataId: taskId,
          column: 'task_id',
        );
      }
    } catch (e) {
      log('Exception in HomeRepoImpl.addSubtaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> addNewSubtask(
      {required List<SubtaskEntity> subtaskEntities,
      required String taskId}) async {
    try {
      await _supabaseStorage.addData(
        table: Endpoints.subtasksTable,
        data: SubtaskModel.fromEntity(subtaskEntities.first).toJson(),
        dataId: taskId,
        column: 'task_id',
      );
      await refreshSubtask(taskId: taskId);
    } catch (e) {
      log('Exception in HomeRepoImpl.addNewSubtask: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<List<SubtaskEntity>> getAllSubtaskData(
      {required String taskId}) async {
    try {
      var subTaskData = await _supabaseStorage.getAllData(
        table: Endpoints.subtasksTable,
        dataId: taskId,
        column: 'task_id',
      );
      _subtasks =
          subTaskData.map((e) => SubtaskModel.fromJson(e).toEntity()).toList();
      await saveSubtaskData(
        subtaskEntities: _subtasks,
      );
      return _subtasks;
    } catch (e) {
      log('Exception in HomeRepoImpl.getAllSubtaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future saveSubtaskData({required List<SubtaskEntity> subtaskEntities}) async {
    try {
      await _hiveService.setSubtaskData(subtaskEntities);
    } catch (e) {
      log('Exception in HomeRepoImpl.saveSubtaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> updateSubtaskData({
    required Map<String, dynamic> data,
    required String subtaskId,
    required String taskId,
  }) async {
    try {
      await _supabaseStorage.updateData(
        table: Endpoints.subtasksTable,
        data: data,
        dataId: subtaskId,
        column: 'id',
      );
      await refreshSubtask(taskId: taskId);
    } catch (e) {
      log('Exception in HomeRepoImpl.updateSubtaskData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> refreshSubtask({required String taskId}) async {
    try {
      _subtasks = await getAllSubtaskData(taskId: taskId);
    } catch (e) {
      log('Error refreshing subtasks: $e');
      throw CustomException('Failed to refresh subtasks.');
    }
  }

  @override
  Future<void> deleteTaskAttachmentFromStorage(
      {required List<String> dataPaths, required String taskId}) async {
    try {
      await _supabaseStorage.deleteDataFromStorage(
        bucket: Endpoints.taskAttachmentsBucket,
        dataPaths: dataPaths,
      );
      await refreshAttachments(taskId: taskId);
    } catch (e) {
      log('Exception in HomeRepoImpl.deleteTaskAttachmentFromStorage: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<String> moveAttachmentFromStorage({
    required String taskId,
    required String userId,
    required String oldPath,
    required String newFileName,
  }) async {
    String oldFileExtension = p.extension(oldPath);
    String newPath = '$userId/$taskId/$newFileName$oldFileExtension';
    try {
      await _supabaseStorage.moveDataFromStorage(
        bucket: Endpoints.taskAttachmentsBucket,
        oldPath: oldPath,
        newPath: newPath,
      );
      await refreshAttachments(taskId: taskId);
      return newPath;
    } catch (e) {
      log('Error moving attachment from storage: $e');
      throw CustomException('Failed to move attachment from storage.');
    }
  }

  @override
  Future<void> deleteSingleTask(
      {required String taskId, required String userId}) async {
    try {
      await _supabaseStorage.deleteSingleDataFromTable(
        table: Endpoints.tasksTable,
        dataId: taskId,
        column: 'id',
      );
      await refreshTasks(userId: userId);
    } catch (e) {
      log('Error deleting data: $e');
      throw CustomException('Failed to delete data.');
    }
  }

  @override
  Future<void> deleteSingleSubtask(
      {required String subtaskId, required String taskId}) async {
    try {
      await _supabaseStorage.deleteSingleDataFromTable(
        table: Endpoints.subtasksTable,
        dataId: subtaskId,
        column: 'id',
      );
      await refreshSubtask(taskId: taskId);
    } catch (e) {
      log('Error deleting data: $e');
      throw CustomException('Failed to delete data.');
    }
  }

  @override
  Future<void> deleteMultipleData(
      {required String table,
      required List<String> dataIds,
      required String column}) async {
    try {
      await _supabaseStorage.deleteMultipleDataFromTable(
          table: table, dataIds: dataIds, column: column);
    } catch (e) {
      log('Error deleting data: $e');
      throw CustomException('Failed to delete data.');
    }
  }

  @override
  Future<void> deleteSingleTaskAttachment(
      {required String attachmentId, required String taskId}) async {
    try {
      await _supabaseStorage.deleteSingleDataFromTable(
        table: Endpoints.attachmentsTable,
        dataId: taskId,
        column: 'id',
      );
      await refreshAttachments(taskId: taskId);
    } catch (e) {
      log('Error deleting data: $e');
      throw CustomException('Failed to delete data.');
    }
  }

  @override
  Future<void> updateTaskAttachmentData({
    required Map<String, dynamic> data,
    required String attachmentId,
    required String taskId,
  }) async {
    try {
      await _supabaseStorage.updateData(
        table: Endpoints.attachmentsTable,
        data: data,
        dataId: attachmentId,
        column: 'id',
      );
      await refreshAttachments(taskId: taskId);
    } catch (e) {
      log('Exception in HomeRepoImpl.updateTaskAttachmentData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }
}
