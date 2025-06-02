import 'package:hive_flutter/hive_flutter.dart';

part 'app_theme_mode.g.dart';

@HiveType(typeId: 12)
enum AppThemeMode {
  @HiveField(0)
  light,
  @HiveField(1)
  dark,
  @HiveField(2)
  system,
}
