import 'package:hive_flutter/hive_flutter.dart';

part 'sub_task_entity.g.dart';

@HiveType(typeId: 2)
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
  final String status;
  @HiveField(5)
  final DateTime? createdAt;
  @HiveField(6)
  final DateTime? updatedAt;

  SubtaskEntity({
    required this.id,
    required this.taskId,
    required this.title,
    this.note,
    String? status,
    this.createdAt,
    this.updatedAt,
  }) : status = status ?? 'In Progress';

  SubtaskEntity copyWith({
    String? id,
    String? taskId,
    String? title,
    String? note,
    String? status,
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
