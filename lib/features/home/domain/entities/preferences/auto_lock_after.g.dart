// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_lock_after.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AutoLockAfterAdapter extends TypeAdapter<AutoLockAfter> {
  @override
  final int typeId = 16;

  @override
  AutoLockAfter read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AutoLockAfter.immediately;
      case 1:
        return AutoLockAfter.tenSeconds;
      case 2:
        return AutoLockAfter.thirtySeconds;
      case 3:
        return AutoLockAfter.sixtySeconds;
      default:
        return AutoLockAfter.immediately;
    }
  }

  @override
  void write(BinaryWriter writer, AutoLockAfter obj) {
    switch (obj) {
      case AutoLockAfter.immediately:
        writer.writeByte(0);
        break;
      case AutoLockAfter.tenSeconds:
        writer.writeByte(1);
        break;
      case AutoLockAfter.thirtySeconds:
        writer.writeByte(2);
        break;
      case AutoLockAfter.sixtySeconds:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoLockAfterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
