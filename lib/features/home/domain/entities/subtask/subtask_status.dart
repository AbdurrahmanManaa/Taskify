import 'package:hive_flutter/hive_flutter.dart';

part 'subtask_status.g.dart';

@HiveType(typeId: 8)
enum SubtaskStatus {
  @HiveField(0)
  inProgress,
  @HiveField(1)
  completed,
}
