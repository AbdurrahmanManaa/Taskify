part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskAdded extends TaskState {}

final class TasksFiltered extends TaskState {}

final class TasksLoaded extends TaskState {}

final class TaskUpdated extends TaskState {}

final class TaskDeleted extends TaskState {}

final class TasksDeleted extends TaskState {}

final class TaskFailure extends TaskState {
  final String message;
  TaskFailure({required this.message});
}
