import 'package:hive_flutter/hive_flutter.dart';

part 'app_lock_type.g.dart';

@HiveType(typeId: 15)
enum AppLockType {
  @HiveField(0)
  pin,
  @HiveField(1)
  password,
}
