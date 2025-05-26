import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/core/utils/app_colors.dart';

part 'category_entity.g.dart';

@HiveType(typeId: 4)
class CategoryEntity extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int iconCodePoint;
  @HiveField(2)
  final int colorValue;

  CategoryEntity({
    required this.name,
    required IconData icon,
    required Color color,
  })  : iconCodePoint = icon.codePoint,
        colorValue = color.toARGB32();

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  Color get color => Color(colorValue);

  static CategoryEntity defaultCategory() {
    return CategoryEntity(
      name: predefinedCategories[0]['name'],
      icon: predefinedCategories[0]['icon'],
      color: predefinedCategories[0]['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': iconCodePoint,
      'color': colorValue,
    };
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(json['color']),
    );
  }
}

final List<Map<String, dynamic>> predefinedCategories = [
  {
    'name': 'Uncategorized',
    'icon': Icons.help_outline,
    'color': AppColors.greyColor,
  },
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
];
