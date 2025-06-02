import 'package:hive_flutter/hive_flutter.dart';

part 'task_status.g.dart';

@HiveType(typeId: 3)
enum TaskStatus {
  @HiveField(0)
  inProgress,
  @HiveField(1)
  completed,
  @HiveField(2)
  overdue,
  @HiveField(3)
  trash,
}
