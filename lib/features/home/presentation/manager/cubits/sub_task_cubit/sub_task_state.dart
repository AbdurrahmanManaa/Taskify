part of 'sub_task_cubit.dart';

@immutable
sealed class SubtaskState {}

final class SubtaskInitial extends SubtaskState {}

final class SubtaskLoading extends SubtaskState {}

final class SubtaskAdded extends SubtaskState {}

final class NewSubtaskAdded extends SubtaskState {}

final class SubtasksLoaded extends SubtaskState {}

final class SubtaskUpdated extends SubtaskState {}

final class SubtaskDeleted extends SubtaskState {}

final class SubtasksDeleted extends SubtaskState {}

final class SubtaskFailure extends SubtaskState {
  final String message;
  SubtaskFailure({required this.message});
}
