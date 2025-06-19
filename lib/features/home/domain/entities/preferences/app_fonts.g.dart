// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_fonts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppFontsAdapter extends TypeAdapter<AppFonts> {
  @override
  final int typeId = 18;

  @override
  AppFonts read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppFonts.inter;
      case 1:
        return AppFonts.orbitron;
      case 2:
        return AppFonts.archivo;
      case 3:
        return AppFonts.playfairDisplay;
      case 4:
        return AppFonts.caveat;
      case 5:
        return AppFonts.cairo;
      case 6:
        return AppFonts.changa;
      case 7:
        return AppFonts.elMessiri;
      case 8:
        return AppFonts.ibmPlexSansArabic;
      case 9:
        return AppFonts.notoKufiArabic;
      default:
        return AppFonts.inter;
    }
  }

  @override
  void write(BinaryWriter writer, AppFonts obj) {
    switch (obj) {
      case AppFonts.inter:
        writer.writeByte(0);
        break;
      case AppFonts.orbitron:
        writer.writeByte(1);
        break;
      case AppFonts.archivo:
        writer.writeByte(2);
        break;
      case AppFonts.playfairDisplay:
        writer.writeByte(3);
        break;
      case AppFonts.caveat:
        writer.writeByte(4);
        break;
      case AppFonts.cairo:
        writer.writeByte(5);
        break;
      case AppFonts.changa:
        writer.writeByte(6);
        break;
      case AppFonts.elMessiri:
        writer.writeByte(7);
        break;
      case AppFonts.ibmPlexSansArabic:
        writer.writeByte(8);
        break;
      case AppFonts.notoKufiArabic:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppFontsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
