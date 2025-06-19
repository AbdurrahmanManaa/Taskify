import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_fonts.dart';

import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_scheme.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_theme_mode.dart';
import 'package:taskify/features/home/domain/entities/preferences/auto_lock_after.dart';

part 'user_preferences_entity.g.dart';

@HiveType(typeId: 11)
class UserPreferencesEntity extends HiveObject {
  @HiveField(0)
  final bool isOnboardingSeen;
  @HiveField(1)
  final bool isNotificationsEnabled;
  @HiveField(2)
  final AppThemeMode appThemeMode;
  @HiveField(3)
  final AppScheme appScheme;
  @HiveField(4)
  final AppLanguage appLanguage;
  @HiveField(5)
  final AppFonts appFont;
  @HiveField(6)
  final AppIconBadgeStyle appIconBadgeStyle;
  @HiveField(7)
  final AppLockType appLockType;
  @HiveField(8)
  final String? hashedPassword;
  @HiveField(9)
  final AutoLockAfter autoLockAfter;

  UserPreferencesEntity({
    this.isOnboardingSeen = false,
    this.isNotificationsEnabled = true,
    this.appIconBadgeStyle = AppIconBadgeStyle.number,
    this.appThemeMode = AppThemeMode.light,
    this.appScheme = AppScheme.material,
    this.appLanguage = AppLanguage.english,
    this.appFont = AppFonts.inter,
    this.appLockType = AppLockType.none,
    this.hashedPassword,
    this.autoLockAfter = AutoLockAfter.thirtySeconds,
  });

  UserPreferencesEntity copyWith({
    bool? isOnboardingSeen,
    bool? isNotificationEnabled,
    AppThemeMode? appThemeMode,
    AppScheme? appScheme,
    AppLanguage? appLanguage,
    AppFonts? appFont,
    AppIconBadgeStyle? appIconBadgeStyle,
    AppLockType? appLockType,
    String? hashedPassword,
    AutoLockAfter? autoLockAfter,
  }) {
    return UserPreferencesEntity(
      isOnboardingSeen: isOnboardingSeen ?? this.isOnboardingSeen,
      isNotificationsEnabled:
          isNotificationEnabled ?? this.isNotificationsEnabled,
      appThemeMode: appThemeMode ?? this.appThemeMode,
      appScheme: appScheme ?? this.appScheme,
      appLanguage: appLanguage ?? this.appLanguage,
      appFont: appFont ?? this.appFont,
      appIconBadgeStyle: appIconBadgeStyle ?? this.appIconBadgeStyle,
      appLockType: appLockType ?? this.appLockType,
      hashedPassword: hashedPassword ?? this.hashedPassword,
      autoLockAfter: autoLockAfter ?? this.autoLockAfter,
    );
  }
}
