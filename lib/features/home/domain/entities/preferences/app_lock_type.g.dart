// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppLockTypeAdapter extends TypeAdapter<AppLockType> {
  @override
  final int typeId = 15;

  @override
  AppLockType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppLockType.none;
      case 1:
        return AppLockType.pin;
      case 2:
        return AppLockType.password;
      default:
        return AppLockType.none;
    }
  }

  @override
  void write(BinaryWriter writer, AppLockType obj) {
    switch (obj) {
      case AppLockType.none:
        writer.writeByte(0);
        break;
      case AppLockType.pin:
        writer.writeByte(1);
        break;
      case AppLockType.password:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLockTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
