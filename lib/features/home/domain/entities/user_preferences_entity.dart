import 'package:hive_flutter/hive_flutter.dart';

part 'user_preferences_entity.g.dart';

@HiveType(typeId: 8)
enum AppLanguage {
  @HiveField(0)
  english,
  @HiveField(1)
  arabic,
}

@HiveType(typeId: 9)
enum AppIconBadgeStyle {
  @HiveField(0)
  number,
  @HiveField(1)
  dot,
}

@HiveType(typeId: 10)
enum AppLockType {
  @HiveField(0)
  none,
  @HiveField(1)
  pin,
  @HiveField(2)
  password,
}

@HiveType(typeId: 7)
class UserPreferencesEntity extends HiveObject {
  @HiveField(0)
  final bool isOnboardingSeen;
  @HiveField(1)
  final bool isNotificationEnabled;
  @HiveField(2)
  final AppIconBadgeStyle appIconBadgeStyle;
  @HiveField(3)
  final bool isDarkMode;
  @HiveField(4)
  final AppLanguage appLanguage;
  @HiveField(5)
  final bool isAppLockEnabled;
  @HiveField(6)
  final AppLockType appLockType;
  @HiveField(7)
  final String hashedPassword;
  @HiveField(8)
  final int autoLockAfterMinutes;

  UserPreferencesEntity({
    this.isOnboardingSeen = false,
    this.isNotificationEnabled = true,
    this.appIconBadgeStyle = AppIconBadgeStyle.number,
    this.isDarkMode = false,
    this.appLanguage = AppLanguage.english,
    this.isAppLockEnabled = false,
    this.appLockType = AppLockType.none,
    this.hashedPassword = '',
    this.autoLockAfterMinutes = 5,
  });

  UserPreferencesEntity copyWith({
    bool? isOnboardingSeen,
    bool? isNotificationEnabled,
    AppIconBadgeStyle? appIconBadgeStyle,
    bool? isDarkMode,
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
      isDarkMode: isDarkMode ?? this.isDarkMode,
      appLanguage: appLanguage ?? this.appLanguage,
      isAppLockEnabled: isAppLockEnabled ?? this.isAppLockEnabled,
      appLockType: appLockType ?? this.appLockType,
      hashedPassword: hashedPassword ?? this.hashedPassword,
      autoLockAfterMinutes: autoLockAfterMinutes ?? this.autoLockAfterMinutes,
    );
  }
}
