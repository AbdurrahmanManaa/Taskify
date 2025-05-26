import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/utils/endpoints.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/repos/home_repo.dart';

part 'sub_task_state.dart';

class SubtaskCubit extends Cubit<SubtaskState> {
  SubtaskCubit(this._homeRepo) : super(SubtaskInitial());
  final HomeRepo _homeRepo;

  List<SubtaskEntity> get subtasks => _homeRepo.subtasks;

  Future<void> addSubTask(
      {required List<SubtaskEntity> subtaskEntities,
      required String taskId}) async {
    try {
      await _homeRepo.addSubtaskData(
          subtaskEntities: subtaskEntities, taskId: taskId);
      emit(
        SubtaskAdded(),
      );
    } catch (e) {
      emit(
        SubtaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> addNewSubtask(
      {required List<SubtaskEntity> subtaskEntities,
      required String taskId}) async {
    try {
      await _homeRepo.addNewSubtask(
        subtaskEntities: subtaskEntities,
        taskId: taskId,
      );
      emit(
        NewSubtaskAdded(),
      );
    } catch (e) {
      emit(
        SubtaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<List<SubtaskEntity>> getSubtasks({required String taskId}) async {
    emit(
      SubtaskLoading(),
    );
    try {
      var subtasks = await _homeRepo.getAllSubtaskData(taskId: taskId);
      emit(
        SubtasksLoaded(),
      );
      return subtasks;
    } catch (e) {
      emit(
        SubtaskFailure(
          message: e.toString(),
        ),
      );
      return [];
    }
  }

  Future<void> updateSubtask(
      {required Map<String, dynamic> data,
      required String subtaskId,
      required String taskId}) async {
    try {
      await _homeRepo.updateSubtaskData(
          data: data, subtaskId: subtaskId, taskId: taskId);
      emit(
        SubtaskUpdated(),
      );
    } catch (e) {
      emit(
        SubtaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteSingleSubtask(
      {required String subtaskId, required String taskId}) async {
    try {
      await _homeRepo.deleteSingleSubtask(subtaskId: subtaskId, taskId: taskId);
      emit(
        SubtaskDeleted(),
      );
    } catch (e) {
      emit(
        SubtaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteMultipleSubtasks({required List<String> dataIds}) async {
    try {
      await _homeRepo.deleteMultipleData(
        table: Endpoints.subtasksTable,
        dataIds: dataIds,
        column: 'id',
      );
      emit(
        SubtasksDeleted(),
      );
    } catch (e) {
      emit(
        SubtaskFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
