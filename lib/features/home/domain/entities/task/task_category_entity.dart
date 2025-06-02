import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_category_entity.g.dart';

@HiveType(typeId: 4)
class TaskCategoryEntity extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int iconCodePoint;
  @HiveField(2)
  final int colorValue;

  TaskCategoryEntity({
    required this.name,
    required IconData icon,
    required Color color,
  })  : iconCodePoint = icon.codePoint,
        colorValue = color.toARGB32();

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  Color get color => Color(colorValue);
}

final List<Map<String, dynamic>> predefinedCategories = [
  {
    'name': 'Work',
    'icon': Icons.work,
    'color': const Color(0xff000080),
  },
  {
    'name': 'Personal',
    'icon': Icons.person,
    'color': const Color(0xffADD8E6),
  },
  {
    'name': 'Health',
    'icon': Icons.favorite,
    'color': const Color(0xff98FF98),
  },
  {
    'name': 'Home',
    'icon': Icons.home,
    'color': const Color(0xffc0a891),
  },
  {
    'name': 'Finance',
    'icon': Icons.wallet,
    'color': const Color(0xffFFD700),
  },
  {
    'name': 'Family',
    'icon': Icons.calendar_month,
    'color': Colors.teal,
  },
  {
    'name': 'Shopping',
    'icon': Icons.shopping_bag,
    'color': const Color(0xffFF7F50),
  },
  {
    'name': 'Education',
    'icon': Icons.school,
    'color': const Color(0xff6A5ACD),
  },
  {
    'name': 'Fitness',
    'icon': Icons.fitness_center,
    'color': const Color(0xff228B22),
  },
  {
    'name': 'Travel',
    'icon': Icons.flight_takeoff,
    'color': const Color(0xff20B2AA),
  },
  {
    'name': 'Events',
    'icon': Icons.event,
    'color': const Color(0xffFF69B4),
  },
  {
    'name': 'Reading',
    'icon': Icons.menu_book,
    'color': const Color(0xff8B4513),
  },
];
