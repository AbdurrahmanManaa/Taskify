import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';

class AttachmentModel {
  final String id;
  final String taskId;
  final String fileName;
  final String fileType;
  final int fileSize;
  final String filePath;
  final String? fileUrl;
  final AttachmentStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttachmentModel({
    required this.id,
    required this.taskId,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.filePath,
    this.fileUrl,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'],
      taskId: json['task_id'],
      fileName: json['file_name'],
      fileType: json['file_type'],
      fileSize: json['file_size'],
      filePath: json['file_path'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTimeUtils.parseIsoDateTime(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTimeUtils.parseIsoDateTime(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'file_name': fileName,
      'file_type': fileType,
      'file_size': fileSize,
      'file_path': filePath,
      'status': status,
    };
  }

  factory AttachmentModel.fromEntity(AttachmentEntity entity) {
    return AttachmentModel(
      id: entity.id,
      taskId: entity.taskId,
      fileName: entity.fileName,
      fileType: entity.fileType,
      fileSize: entity.fileSize,
      filePath: entity.filePath,
      fileUrl: entity.fileUrl,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  AttachmentEntity toEntity() {
    return AttachmentEntity(
      id: id,
      taskId: taskId,
      fileName: fileName,
      fileType: fileType,
      fileSize: fileSize,
      filePath: filePath,
      fileUrl: fileUrl,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  AttachmentModel copyWith({String? fileUrl}) {
    return AttachmentModel(
      id: id,
      taskId: taskId,
      fileName: fileName,
      fileType: fileType,
      fileSize: fileSize,
      filePath: filePath,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
