// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentStatusAdapter extends TypeAdapter<AttachmentStatus> {
  @override
  final int typeId = 10;

  @override
  AttachmentStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AttachmentStatus.pending;
      case 1:
        return AttachmentStatus.uploaded;
      default:
        return AttachmentStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, AttachmentStatus obj) {
    switch (obj) {
      case AttachmentStatus.pending:
        writer.writeByte(0);
        break;
      case AttachmentStatus.uploaded:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
