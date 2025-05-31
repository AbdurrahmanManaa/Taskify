import 'package:taskify/features/home/domain/entities/attachment_entity.dart';

extension AttachmentStatusX on AttachmentStatus {
  String get label {
    switch (this) {
      case AttachmentStatus.pending:
        return 'Pending';
      case AttachmentStatus.uploaded:
        return 'Uploaded';
    }
  }

  static AttachmentStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return AttachmentStatus.pending;
      case 'uploaded':
        return AttachmentStatus.uploaded;
      default:
        return AttachmentStatus.pending;
    }
  }
}
