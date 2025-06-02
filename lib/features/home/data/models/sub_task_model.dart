import 'package:taskify/core/extensions/subtask_status_extension.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/features/home/domain/entities/subtask/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/subtask/subtask_status.dart';

class SubtaskModel {
  final String id;
  final String taskId;
  final String title;
  final String? note;
  final SubtaskStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubtaskModel({
    required this.id,
    required this.taskId,
    required this.title,
    this.note,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SubtaskModel.fromJson(Map<String, dynamic> json) => SubtaskModel(
        id: json['id'],
        taskId: json['task_id'],
        title: json['title'],
        note: json['note'],
        status: json['status'] != null
            ? SubtaskStatusX.fromString(json['status'])
            : SubtaskStatus.inProgress,
        createdAt: json['created_at'] != null
            ? DateTimeUtils.parseIsoDateTime(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTimeUtils.parseIsoDateTime(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'task_id': taskId,
        'title': title,
        'note': note,
        'status': status.label,
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
