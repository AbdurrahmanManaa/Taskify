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
      isNotificationsEnabled: fields[1] as bool,
      appIconBadgeStyle: fields[6] as AppIconBadgeStyle,
      appThemeMode: fields[2] as AppThemeMode,
      appScheme: fields[3] as AppScheme,
      appLanguage: fields[4] as AppLanguage,
      appFont: fields[5] as AppFonts,
      appLockType: fields[7] as AppLockType,
      hashedPassword: fields[8] as String?,
      autoLockAfter: fields[9] as AutoLockAfter,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferencesEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.isOnboardingSeen)
      ..writeByte(1)
      ..write(obj.isNotificationsEnabled)
      ..writeByte(2)
      ..write(obj.appThemeMode)
      ..writeByte(3)
      ..write(obj.appScheme)
      ..writeByte(4)
      ..write(obj.appLanguage)
      ..writeByte(5)
      ..write(obj.appFont)
      ..writeByte(6)
      ..write(obj.appIconBadgeStyle)
      ..writeByte(7)
      ..write(obj.appLockType)
      ..writeByte(8)
      ..write(obj.hashedPassword)
      ..writeByte(9)
      ..write(obj.autoLockAfter);
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
