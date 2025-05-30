// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentEntityAdapter extends TypeAdapter<AttachmentEntity> {
  @override
  final int typeId = 9;

  @override
  AttachmentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachmentEntity(
      id: fields[0] as String,
      taskId: fields[1] as String,
      fileName: fields[2] as String,
      fileType: fields[3] as String,
      fileSize: fields[4] as int,
      filePath: fields[5] as String,
      fileUrl: fields[6] as String?,
      status: fields[7] as AttachmentStatus,
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AttachmentEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.fileName)
      ..writeByte(3)
      ..write(obj.fileType)
      ..writeByte(4)
      ..write(obj.fileSize)
      ..writeByte(5)
      ..write(obj.filePath)
      ..writeByte(6)
      ..write(obj.fileUrl)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
