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
      appIconBadgeStyle: fields[2] as AppIconBadgeStyle,
      isDarkMode: fields[3] as bool,
      appLanguage: fields[4] as AppLanguage,
      isAppLockEnabled: fields[5] as bool,
      appLockType: fields[6] as AppLockType,
      hashedPassword: fields[7] as String,
      autoLockAfterMinutes: fields[8] as int,
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
      ..write(obj.appIconBadgeStyle)
      ..writeByte(3)
      ..write(obj.isDarkMode)
      ..writeByte(4)
      ..write(obj.appLanguage)
      ..writeByte(5)
      ..write(obj.isAppLockEnabled)
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

class AppLanguageAdapter extends TypeAdapter<AppLanguage> {
  @override
  final int typeId = 12;

  @override
  AppLanguage read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppLanguage.english;
      case 1:
        return AppLanguage.arabic;
      default:
        return AppLanguage.english;
    }
  }

  @override
  void write(BinaryWriter writer, AppLanguage obj) {
    switch (obj) {
      case AppLanguage.english:
        writer.writeByte(0);
        break;
      case AppLanguage.arabic:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppIconBadgeStyleAdapter extends TypeAdapter<AppIconBadgeStyle> {
  @override
  final int typeId = 13;

  @override
  AppIconBadgeStyle read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppIconBadgeStyle.number;
      case 1:
        return AppIconBadgeStyle.dot;
      default:
        return AppIconBadgeStyle.number;
    }
  }

  @override
  void write(BinaryWriter writer, AppIconBadgeStyle obj) {
    switch (obj) {
      case AppIconBadgeStyle.number:
        writer.writeByte(0);
        break;
      case AppIconBadgeStyle.dot:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppIconBadgeStyleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppLockTypeAdapter extends TypeAdapter<AppLockType> {
  @override
  final int typeId = 14;

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
