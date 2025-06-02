// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_icon_badge_style.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppIconBadgeStyleAdapter extends TypeAdapter<AppIconBadgeStyle> {
  @override
  final int typeId = 14;

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
