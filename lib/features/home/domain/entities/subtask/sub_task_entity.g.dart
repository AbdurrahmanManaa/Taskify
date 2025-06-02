// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtaskEntityAdapter extends TypeAdapter<SubtaskEntity> {
  @override
  final int typeId = 7;

  @override
  SubtaskEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubtaskEntity(
      id: fields[0] as String,
      taskId: fields[1] as String,
      title: fields[2] as String,
      note: fields[3] as String?,
      status: fields[4] as SubtaskStatus,
      createdAt: fields[5] as DateTime?,
      updatedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SubtaskEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
