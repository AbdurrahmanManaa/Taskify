import 'package:hive_flutter/hive_flutter.dart';

part 'app_lock_type.g.dart';

@HiveType(typeId: 15)
enum AppLockType {
  @HiveField(0)
  none,
  @HiveField(1)
  pin,
  @HiveField(2)
  password,
}
