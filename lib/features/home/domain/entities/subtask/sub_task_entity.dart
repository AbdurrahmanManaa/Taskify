import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/features/home/domain/entities/subtask/subtask_status.dart';

part 'sub_task_entity.g.dart';

@HiveType(typeId: 7)
class SubtaskEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String taskId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? note;
  @HiveField(4)
  final SubtaskStatus status;
  @HiveField(5)
  final DateTime? createdAt;
  @HiveField(6)
  final DateTime? updatedAt;

  SubtaskEntity({
    required this.id,
    required this.taskId,
    required this.title,
    this.note,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  SubtaskEntity copyWith({
    String? id,
    String? taskId,
    String? title,
    String? note,
    SubtaskStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtaskEntity(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
