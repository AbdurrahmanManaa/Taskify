import 'package:hive_flutter/hive_flutter.dart';

part 'auto_lock_after.g.dart';

@HiveType(typeId: 16)
enum AutoLockAfter {
  @HiveField(0)
  immediately,
  @HiveField(1)
  tenSeconds,
  @HiveField(2)
  thirtySeconds,
  @HiveField(3)
  sixtySeconds,
}
