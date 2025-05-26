// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskEntityAdapter extends TypeAdapter<TaskEntity> {
  @override
  final int typeId = 1;

  @override
  TaskEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskEntity(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String?,
      dueDate: fields[4] as DateTime?,
      startTime: fields[5] as String?,
      endTime: fields[6] as String?,
      reminder: fields[7] as TaskReminderEntity?,
      repeat: fields[8] as TaskRepeatEntity?,
      priority: fields[9] as String?,
      categories: (fields[10] as List?)?.cast<CategoryEntity>(),
      status: fields[11] as String?,
      createdAt: fields[12] as DateTime?,
      completedAt: fields[13] as DateTime?,
      updatedAt: fields[14] as DateTime?,
      deletedAt: fields[15] as DateTime?,
      subtaskCount: fields[17] as int?,
      attachmentsCount: fields[16] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.dueDate)
      ..writeByte(5)
      ..write(obj.startTime)
      ..writeByte(6)
      ..write(obj.endTime)
      ..writeByte(7)
      ..write(obj.reminder)
      ..writeByte(8)
      ..write(obj.repeat)
      ..writeByte(9)
      ..write(obj.priority)
      ..writeByte(10)
      ..write(obj.categories)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.completedAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.deletedAt)
      ..writeByte(16)
      ..write(obj.attachmentsCount)
      ..writeByte(17)
      ..write(obj.subtaskCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
