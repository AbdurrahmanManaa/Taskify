// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferencesEntityAdapter extends TypeAdapter<UserPreferencesEntity> {
  @override
  final int typeId = 11;

  @override
  UserPreferencesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferencesEntity(
      isOnboardingSeen: fields[0] as bool,
      isNotificationEnabled: fields[1] as bool,
      appIconBadgeStyle: fields[5] as AppIconBadgeStyle,
      appThemeMode: fields[3] as AppThemeMode,
      appLanguage: fields[4] as AppLanguage,
      isAppLockEnabled: fields[2] as bool,
      appLockType: fields[6] as AppLockType?,
      hashedPassword: fields[7] as String?,
      autoLockAfterMinutes: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferencesEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.isOnboardingSeen)
      ..writeByte(1)
      ..write(obj.isNotificationEnabled)
      ..writeByte(2)
      ..write(obj.isAppLockEnabled)
      ..writeByte(3)
      ..write(obj.appThemeMode)
      ..writeByte(4)
      ..write(obj.appLanguage)
      ..writeByte(5)
      ..write(obj.appIconBadgeStyle)
      ..writeByte(6)
      ..write(obj.appLockType)
      ..writeByte(7)
      ..write(obj.hashedPassword)
      ..writeByte(8)
      ..write(obj.autoLockAfterMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
