// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtaskStatusAdapter extends TypeAdapter<SubtaskStatus> {
  @override
  final int typeId = 8;

  @override
  SubtaskStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubtaskStatus.inProgress;
      case 1:
        return SubtaskStatus.completed;
      default:
        return SubtaskStatus.inProgress;
    }
  }

  @override
  void write(BinaryWriter writer, SubtaskStatus obj) {
    switch (obj) {
      case SubtaskStatus.inProgress:
        writer.writeByte(0);
        break;
      case SubtaskStatus.completed:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
