import 'dart:io';

import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';

abstract class HomeRepo {
  Future<void> addTaskData({required TaskEntity taskEntity});
  Future<List<TaskEntity>> getAllTaskData({required String userId});
  void filterTasks({
    String? query,
    List<TaskStatus>? statuses,
    List<TaskPriority>? priorities,
    List<String>? categories,
    List<String>? dueDates,
  });
  void sortTasks({required String sortBy, bool ascending = true});
  Future<void> updateTaskData({
    required Map<String, dynamic> data,
    required String taskId,
    required String userId,
  });

  Future<void> updateTaskAttachmentData({
    required Map<String, dynamic> data,
    required String attachmentId,
    required String taskId,
  });

  Future<void> addNewSubtask(
      {required List<SubtaskEntity> subtaskEntities, required String taskId});

  Future<void> addSubtaskData({
    required List<SubtaskEntity> subtaskEntities,
    required String taskId,
  });
  Future<List<SubtaskEntity>> getAllSubtaskData({required String taskId});
  Future<void> updateSubtaskData({
    required Map<String, dynamic> data,
    required String subtaskId,
    required String taskId,
  });
  Future<void> addAttachmentsData({
    required List<File> files,
    required List<AttachmentEntity> baseEntities,
    required String taskId,
    required String userId,
  });

  Future<List<AttachmentEntity>> getAttachmentsData({required String taskId});
  Future<String> moveAttachmentFromStorage({
    required String taskId,
    required String userId,
    required String oldPath,
    required String newFileName,
  });
  Future<void> deleteSingleTask(
      {required String taskId, required String userId});
  Future<void> refreshTasks({required String userId});
  Future<void> refreshAttachments({required String taskId});
  Future<void> deleteTaskAttachmentFromStorage({
    required List<String> dataPaths,
    required String taskId,
  });
  Future saveTaskData({required List<TaskEntity> taskEntities});
  Future saveSubtaskData({required List<SubtaskEntity> subtaskEntities});
  Future saveAttachmentsData(
      {required List<AttachmentEntity> attachmentEntities});

  Future<void> deleteSingleTaskAttachment(
      {required String attachmentId, required String taskId});

  Future<void> deleteSingleSubtask(
      {required String subtaskId, required String taskId});
  Future<void> refreshSubtask({required String taskId});

  Future<void> deleteMultipleData({
    required String table,
    required List<String> dataIds,
    required String column,
  });

  List<TaskEntity> get tasks;
  List<SubtaskEntity> get subtasks;
  List<AttachmentEntity> get attachments;
  List<TaskEntity> get filteredTasks;
}
