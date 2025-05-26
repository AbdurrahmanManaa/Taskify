import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';

class SubtaskModel {
  final String id;
  final String taskId;
  final String title;
  final String? note;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubtaskModel({
    required this.id,
    required this.taskId,
    required this.title,
    this.note,
    String? status,
    this.createdAt,
    this.updatedAt,
  }) : status = status ?? 'In Progress';

  factory SubtaskModel.fromJson(Map<String, dynamic> json) => SubtaskModel(
        id: json['id'],
        taskId: json['task_id'],
        title: json['title'],
        note: json['note'],
        status: json['status'] ?? 'In Progress',
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'task_id': taskId,
        'title': title,
        'note': note,
        'status': status,
        'updated_at': updatedAt?.toIso8601String(),
      };

  factory SubtaskModel.fromEntity(SubtaskEntity entity) => SubtaskModel(
        id: entity.id,
        taskId: entity.taskId,
        title: entity.title,
        note: entity.note,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  SubtaskEntity toEntity() => SubtaskEntity(
        id: id,
        taskId: taskId,
        title: title,
        note: note,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
