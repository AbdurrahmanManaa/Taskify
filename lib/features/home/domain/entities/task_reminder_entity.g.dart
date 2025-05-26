// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_reminder_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskReminderEntityAdapter extends TypeAdapter<TaskReminderEntity> {
  @override
  final int typeId = 5;

  @override
  TaskReminderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskReminderEntity(
      option: fields[0] as String,
      value: fields[1] as int,
      unit: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskReminderEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.option)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskReminderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
