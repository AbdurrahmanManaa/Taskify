import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/extensions/user_preferences_extension.dart';
import 'package:taskify/core/services/crypto_service.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/custom_wrapper_container.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/auto_lock_after.dart';
import 'package:taskify/features/home/domain/entities/preferences/user_preferences_entity.dart';
import 'package:taskify/features/home/presentation/views/app_lock_type_view.dart';

class AppLockViewBody extends StatelessWidget {
  const AppLockViewBody({super.key});

  Future<void> _handleLockTypeSelection(BuildContext context,
      UserPreferencesEntity value, AppLockType type, String saltName) async {
    final result = await pushScreenWithoutNavBar(
      context,
      Provider.value(
        value: type,
        child: const AppLockTypeView(),
      ),
    );

    if (result is String && result.isNotEmpty) {
      final salt = saltName;
      final hashed = CryptoService.hashPassword(result, salt);
      final updated = value.copyWith(
        appLockType: type,
        hashedPassword: hashed,
      );
      HiveService().setUserPreferences(updated);
    }
  }

  Future<AutoLockAfter?> _autoLockAfterSelection(
      BuildContext context, AutoLockAfter current) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Auto-lock After',
                style: AppTextStyles.medium24.copyWith(
                  color: AppColors.primaryLightColor,
                ),
              ),
              Divider(),
              ...AutoLockAfter.values.map((e) {
                final isSelected = e == current;
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        e.label,
                        style: AppTextStyles.medium18,
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check,
                              color: AppColors.primaryLightColor)
                          : null,
                      onTap: () => Navigator.pop(context, e),
                    ),
                    if (e != AutoLockAfter.values.last) Divider(),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Future<void> _disableAppLock(
      BuildContext context, UserPreferencesEntity value) async {
    final shouldRemove = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text(
          "Change to a non-secure app lock type?",
          style: AppTextStyles.medium20,
        ),
        content: Text(
          "Your lock data will be removed for your security. You'll need to set new security data later.",
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.bodyTextColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Cancel",
              style: AppTextStyles.regular18.copyWith(
                color: AppColors.primaryLightColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "Remove",
              style: AppTextStyles.regular18.copyWith(
                color: AppColors.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
    if (shouldRemove == true) {
      final updated = value.copyWith(
        appLockType: AppLockType.none,
        hashedPassword: null,
      );
      await HiveService().setUserPreferences(updated);
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
                    Divider(),
                    OptionItem(
                      onTap: currentLock == AppLockType.none
                          ? null
                          : () async {
                              await _disableAppLock(
                                context,
                                value,
                              );
                            },
                      title: Text(
                        'None',
                        style: AppTextStyles.medium22,
                      ),
                      subtitle: currentLock == AppLockType.none
                          ? Text(
                              'Current lock type',
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.primaryLightColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FieldItem(
                label: 'Auto-lock After',
                widget: GestureDetector(
                  onTap: () async {
                    final selected = await _autoLockAfterSelection(
                      context,
                      value.autoLockAfter,
                    );
                    if (selected != null && selected != value.autoLockAfter) {
                      final updated = value.copyWith(autoLockAfter: selected);
                      HiveService().setUserPreferences(updated);
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: value.autoLockAfter.label,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
