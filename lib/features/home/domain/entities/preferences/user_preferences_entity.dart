import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_theme_mode.dart';

part 'user_preferences_entity.g.dart';

@HiveType(typeId: 11)
class UserPreferencesEntity extends HiveObject {
  @HiveField(0)
  final bool isOnboardingSeen;
  @HiveField(1)
  final bool isNotificationEnabled;
  @HiveField(2)
  final bool isAppLockEnabled;
  @HiveField(3)
  final AppThemeMode appThemeMode;
  @HiveField(4)
  final AppLanguage appLanguage;
  @HiveField(5)
  final AppIconBadgeStyle appIconBadgeStyle;
  @HiveField(6)
  final AppLockType? appLockType;
  @HiveField(7)
  final String? hashedPassword;
  @HiveField(8)
  final int? autoLockAfterMinutes;

  UserPreferencesEntity({
    this.isOnboardingSeen = false,
    this.isNotificationEnabled = true,
    this.appIconBadgeStyle = AppIconBadgeStyle.number,
    this.appThemeMode = AppThemeMode.light,
    this.appLanguage = AppLanguage.english,
    this.isAppLockEnabled = false,
    this.appLockType,
    this.hashedPassword,
    this.autoLockAfterMinutes,
  });

  UserPreferencesEntity copyWith({
    bool? isOnboardingSeen,
    bool? isNotificationEnabled,
    AppIconBadgeStyle? appIconBadgeStyle,
    AppThemeMode? appThemeMode,
    AppLanguage? appLanguage,
    bool? isAppLockEnabled,
    AppLockType? appLockType,
    String? hashedPassword,
    int? autoLockAfterMinutes,
  }) {
    return UserPreferencesEntity(
      isOnboardingSeen: isOnboardingSeen ?? this.isOnboardingSeen,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      appIconBadgeStyle: appIconBadgeStyle ?? this.appIconBadgeStyle,
      appThemeMode: appThemeMode ?? this.appThemeMode,
      appLanguage: appLanguage ?? this.appLanguage,
      isAppLockEnabled: isAppLockEnabled ?? this.isAppLockEnabled,
      appLockType: appLockType ?? this.appLockType,
      hashedPassword: hashedPassword ?? this.hashedPassword,
      autoLockAfterMinutes: autoLockAfterMinutes ?? this.autoLockAfterMinutes,
    );
  }
}
