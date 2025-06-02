// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_category_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCategoryEntityAdapter extends TypeAdapter<TaskCategoryEntity> {
  @override
  final int typeId = 4;

  @override
  TaskCategoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCategoryEntity(
      name: fields[0] as String,
      icon: IconData(
        fields[1] as int,
        fontFamily: 'MaterialIcons',
      ),
      color: Color(fields[2] as int),
    );
  }

  @override
  void write(BinaryWriter writer, TaskCategoryEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconCodePoint)
      ..writeByte(2)
      ..write(obj.colorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
