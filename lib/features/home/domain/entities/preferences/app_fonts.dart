import 'package:hive/hive.dart';

part 'app_fonts.g.dart';

@HiveType(typeId: 18)
enum AppFonts {
  @HiveField(0)
  inter,
  @HiveField(1)
  orbitron,
  @HiveField(2)
  archivo,
  @HiveField(3)
  playfairDisplay,
  @HiveField(4)
  caveat,
  @HiveField(5)
  cairo,
  @HiveField(6)
  changa,
  @HiveField(7)
  elMessiri,
  @HiveField(8)
  ibmPlexSansArabic,
  @HiveField(9)
  notoKufiArabic,
}
