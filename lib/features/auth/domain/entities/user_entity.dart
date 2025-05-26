import 'package:hive_flutter/hive_flutter.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String? imagePath;
  @HiveField(4)
  final String? imageUrl;
  @HiveField(5)
  final DateTime? createdAt;
  @HiveField(6)
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.imagePath,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });
}
