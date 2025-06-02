// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_repeat_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskRepeatEntityAdapter extends TypeAdapter<TaskRepeatEntity> {
  @override
  final int typeId = 6;

  @override
  TaskRepeatEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskRepeatEntity(
      interval: fields[0] as int,
      option: fields[1] as String,
      duration: fields[2] as String,
      count: fields[3] as int,
      weekDays: (fields[4] as List).cast<String>(),
      untilDate: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskRepeatEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.interval)
      ..writeByte(1)
      ..write(obj.option)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.weekDays)
      ..writeByte(5)
      ..write(obj.untilDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskRepeatEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
