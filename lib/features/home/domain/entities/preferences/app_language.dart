import 'package:hive_flutter/hive_flutter.dart';

part 'app_language.g.dart';

@HiveType(typeId: 13)
enum AppLanguage {
  @HiveField(0)
  english,
  @HiveField(1)
  arabic,
}
