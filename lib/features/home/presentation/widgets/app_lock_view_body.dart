import 'package:flutter/material.dart';
import 'package:taskify/core/services/crypto_service.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_wrapper_container.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/user_preferences_entity.dart';

class AppLockViewBody extends StatefulWidget {
  const AppLockViewBody({super.key});

  @override
  State<AppLockViewBody> createState() => _AppLockViewBodyState();
}

class _AppLockViewBodyState extends State<AppLockViewBody> {
  Future<void> _handleLockTypeSelection(BuildContext context,
      UserPreferencesEntity value, AppLockType type, String saltName) async {
    final result = await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.appLockType,
      arguments: type,
    );

    if (result is String && result.isNotEmpty) {
      final salt = saltName;
      final hashed = CryptoService.hashPassword(result, salt);
      final updated = value.copyWith(
        appLockType: type,
        hashedPassword: hashed,
        isAppLockEnabled: true,
      );
      HiveService().setUserPreferences(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.preferencesNotifier,
      builder: (context, value, _) {
        final currentLock = value.appLockType;

        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomAppbar(
                title: 'App Lock',
              ),
              const SizedBox(height: 20),
              CustomWrapperContainer(
                child: Column(
                  children: [
                    OptionItem(
                      onTap: () async {
                        await _handleLockTypeSelection(
                          context,
                          value,
                          AppLockType.pin,
                          'pinSalt',
                        );
                      },
                      title: Text(
                        'PIN',
                        style: AppTextStyles.medium22,
                      ),
                      subtitle: currentLock == AppLockType.pin
                          ? RichText(
                              text: TextSpan(
                                text: 'Medium-high security, ',
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.bodyTextColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Current lock type',
                                    style: AppTextStyles.regular16.copyWith(
                                      color: AppColors.primaryLightColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'Medium-high security',
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.bodyTextColor,
                              ),
                            ),
                    ),
                    Divider(),
                    OptionItem(
                      onTap: () async {
                        await _handleLockTypeSelection(
                          context,
                          value,
                          AppLockType.password,
                          'passwordSalt',
                        );
                      },
                      title: Text(
                        'Password',
                        style: AppTextStyles.medium22,
                      ),
                      subtitle: currentLock == AppLockType.password
                          ? RichText(
                              text: TextSpan(
                                text: 'High security, ',
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.bodyTextColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Current lock type',
                                    style: AppTextStyles.regular16.copyWith(
                                      color: AppColors.primaryLightColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'High security',
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.bodyTextColor,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
