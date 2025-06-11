import 'package:hive_flutter/hive_flutter.dart';

import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_theme_mode.dart';
import 'package:taskify/features/home/domain/entities/preferences/auto_lock_after.dart';

part 'user_preferences_entity.g.dart';

@HiveType(typeId: 11)
class UserPreferencesEntity extends HiveObject {
  @HiveField(0)
  final bool isOnboardingSeen;
  @HiveField(1)
  final bool isNotificationEnabled;
  @HiveField(2)
  final AppThemeMode appThemeMode;
  @HiveField(3)
  final AppLanguage appLanguage;
  @HiveField(4)
  final AppIconBadgeStyle appIconBadgeStyle;
  @HiveField(5)
  final AppLockType appLockType;
  @HiveField(6)
  final String? hashedPassword;
  @HiveField(7)
  final AutoLockAfter autoLockAfter;

  UserPreferencesEntity({
    this.isOnboardingSeen = false,
    this.isNotificationEnabled = true,
    this.appIconBadgeStyle = AppIconBadgeStyle.number,
    this.appThemeMode = AppThemeMode.light,
    this.appLanguage = AppLanguage.english,
    this.appLockType = AppLockType.none,
    this.hashedPassword,
    this.autoLockAfter = AutoLockAfter.thirtySeconds,
  });

  UserPreferencesEntity copyWith({
    bool? isOnboardingSeen,
    bool? isNotificationEnabled,
    AppThemeMode? appThemeMode,
    AppLanguage? appLanguage,
    AppIconBadgeStyle? appIconBadgeStyle,
    AppLockType? appLockType,
    String? hashedPassword,
    AutoLockAfter? autoLockAfter,
  }) {
    return UserPreferencesEntity(
      isOnboardingSeen: isOnboardingSeen ?? this.isOnboardingSeen,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      appThemeMode: appThemeMode ?? this.appThemeMode,
      appLanguage: appLanguage ?? this.appLanguage,
      appIconBadgeStyle: appIconBadgeStyle ?? this.appIconBadgeStyle,
      appLockType: appLockType ?? this.appLockType,
      hashedPassword: hashedPassword ?? this.hashedPassword,
      autoLockAfter: autoLockAfter ?? this.autoLockAfter,
    );
  }
}
