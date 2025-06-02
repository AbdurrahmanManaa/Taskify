import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/utils/endpoints.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/domain/repos/home_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._homeRepo) : super(TaskInitial());
  final HomeRepo _homeRepo;

  List<TaskEntity> get tasks => _homeRepo.tasks;
  List<TaskEntity> get filteredTasks => _homeRepo.filteredTasks;

  String? _lastQuery;
  List<TaskStatus>? _lastStatuses;
  List<TaskPriority>? _lastPriorities;
  List<String>? _lastCategories;
  List<String>? _lastDueDates;

  Future<void> addTask({required TaskEntity taskEntity}) async {
    emit(
      TaskLoading(),
    );
    try {
      await _homeRepo.addTaskData(taskEntity: taskEntity);
      emit(
        TaskAdded(),
      );
    } catch (e) {
      emit(
        TaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<List<TaskEntity>> getTasks({required String userId}) async {
    emit(
      TaskLoading(),
    );
    try {
      var tasks = await _homeRepo.getAllTaskData(userId: userId);
      emit(
        TasksLoaded(),
      );
      return tasks;
    } catch (e) {
      emit(
        TaskFailure(
          message: e.toString(),
        ),
      );
      return [];
    }
  }

  void applyFiltersAndSort({
    String? query,
    List<TaskStatus>? statuses,
    List<TaskPriority>? priorities,
    List<String>? categories,
    List<String>? dueDates,
    String? sortBy,
    bool ascending = true,
  }) {
    _homeRepo.filterTasks(
      query: query ?? _lastQuery,
      statuses: statuses ?? _lastStatuses,
      priorities: priorities ?? _lastPriorities,
      categories: categories ?? _lastCategories,
      dueDates: dueDates ?? _lastDueDates,
    );

    if (sortBy != null) {
      _homeRepo.sortTasks(
        sortBy: sortBy,
        ascending: ascending,
      );
    }

    _lastQuery = query ?? _lastQuery;
    _lastStatuses = statuses ?? _lastStatuses;
    _lastPriorities = priorities ?? _lastPriorities;
    _lastCategories = categories ?? _lastCategories;
    _lastDueDates = dueDates ?? _lastDueDates;

    emit(
      TasksFiltered(),
    );
  }

  Future<void> updateTask({
    required Map<String, dynamic> data,
    required String taskId,
    required String userId,
  }) async {
    emit(
      TaskLoading(),
    );
    try {
      await _homeRepo.updateTaskData(
          data: data, taskId: taskId, userId: userId);
      emit(
        TaskUpdated(),
      );
    } catch (e) {
      emit(
        TaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteSingleTask(
      {required String taskId, required String userId}) async {
    try {
      await _homeRepo.deleteSingleTask(
        taskId: taskId,
        userId: userId,
      );
      emit(
        TaskDeleted(),
      );
    } catch (e) {
      emit(
        TaskFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteMultipleTasks({required List<String> dataIds}) async {
    emit(
      TaskLoading(),
    );
    try {
      await _homeRepo.deleteMultipleData(
        table: Endpoints.tasksTable,
        dataIds: dataIds,
        column: 'id',
      );
      emit(
        TasksDeleted(),
      );
    } catch (e) {
      emit(
        TaskFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
