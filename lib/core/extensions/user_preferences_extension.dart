import 'package:taskify/features/home/domain/entities/preferences/app_theme_mode.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_icon_badge_style.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/auto_lock_after.dart';

extension AppThemeModeX on AppThemeMode {
  String get label {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }
}

extension AppLanguageX on AppLanguage {
  String get label {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.arabic:
        return 'Arabic';
    }
  }
}

extension AppIconBadgeStyleX on AppIconBadgeStyle {
  String get label {
    switch (this) {
      case AppIconBadgeStyle.number:
        return 'Number';
      case AppIconBadgeStyle.dot:
        return 'Dot';
    }
  }
}

extension AppLockTypeX on AppLockType {
  String get label {
    switch (this) {
      case AppLockType.none:
        return 'None';
      case AppLockType.pin:
        return 'PIN';
      case AppLockType.password:
        return 'Password';
    }
  }
}

extension AutoLockAfterX on AutoLockAfter {
  String get label {
    switch (this) {
      case AutoLockAfter.immediately:
        return 'Immediately';
      case AutoLockAfter.tenSeconds:
        return 'After 10 seconds';
      case AutoLockAfter.thirtySeconds:
        return 'After 30 seconds';
      case AutoLockAfter.sixtySeconds:
        return 'After 60 seconds';
    }
  }

  Duration get duration {
    switch (this) {
      case AutoLockAfter.immediately:
        return Duration.zero;
      case AutoLockAfter.tenSeconds:
        return const Duration(seconds: 10);
      case AutoLockAfter.thirtySeconds:
        return const Duration(seconds: 30);
      case AutoLockAfter.sixtySeconds:
        return const Duration(seconds: 60);
    }
  }
}
