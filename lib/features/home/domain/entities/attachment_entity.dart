import 'package:hive_flutter/hive_flutter.dart';

part 'attachment_entity.g.dart';

@HiveType(typeId: 3)
class AttachmentEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String taskId;
  @HiveField(2)
  final String fileName;
  @HiveField(3)
  final String fileType;
  @HiveField(4)
  final int fileSize;
  @HiveField(5)
  final String filePath;
  @HiveField(6)
  final String? fileUrl;
  @HiveField(7)
  final String status;
  @HiveField(8)
  final DateTime? createdAt;
  @HiveField(9)
  final DateTime? updatedAt;

  AttachmentEntity({
    required this.id,
    required this.taskId,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.filePath,
    this.fileUrl,
    String? status,
    this.createdAt,
    this.updatedAt,
  }) : status = status ?? 'Pending';

  AttachmentEntity copyWith({
    String? id,
    String? taskId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String? filePath,
    String? fileUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttachmentEntity(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      filePath: filePath ?? this.filePath,
      fileUrl: fileUrl ?? this.fileUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

const customDocumentsAllowedExtensions = [
  'pdf',
  'doc',
  'docx',
  'txt',
  'xlsx',
  'ppt',
  'pptx',
  'csv',
  'html',
  'css',
  'json',
  'xml',
  'md',
  'zip',
  'rar',
  '7z',
  'tar',
  'gz',
  'xz',
  'iso',
];
const allAllowedExtensions = [
  'png',
  'jpg',
  'jpeg',
  'gif',
  'bmp',
  'webp',
  'tiff',
  'svg',
  'ico',
  'heif',
  'heic',
  'raw',
  'nef',
  'cr2',
  'mp4',
  'mov',
  'avi',
  'mkv',
  'flv',
  'wmv',
  'webm',
  'mpg',
  'mpeg',
  '3gp',
  'ts',
  'pdf',
  'doc',
  'docx',
  'txt',
  'xlsx',
  'ppt',
  'pptx',
  'csv',
  'html',
  'css',
  'json',
  'xml',
  'md',
  'zip',
  'rar',
  '7z',
  'tar',
  'gz',
  'xz',
  'iso',
];
