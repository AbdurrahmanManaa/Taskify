import 'package:hive_flutter/hive_flutter.dart';

part 'app_icon_badge_style.g.dart';

@HiveType(typeId: 14)
enum AppIconBadgeStyle {
  @HiveField(0)
  number,
  @HiveField(1)
  dot,
}
