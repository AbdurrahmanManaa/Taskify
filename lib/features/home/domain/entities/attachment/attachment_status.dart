import 'package:hive_flutter/hive_flutter.dart';

part 'attachment_status.g.dart';

@HiveType(typeId: 10)
enum AttachmentStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  uploaded,
}
