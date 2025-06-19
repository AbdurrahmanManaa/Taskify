import 'package:flutter/material.dart';
import 'package:taskify/features/home/domain/entities/attachment/attachment_status.dart';
import 'package:taskify/generated/l10n.dart';

extension AttachmentStatusX on AttachmentStatus {
  String label(BuildContext context) {
    switch (this) {
      case AttachmentStatus.pending:
        return S.of(context).attachmentStatusPending;
      case AttachmentStatus.uploaded:
        return S.of(context).attachmentStatusUploaded;
    }
  }

  String get labelDB {
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
