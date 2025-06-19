import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:taskify/core/extensions/user_preferences_extension.dart';
import 'package:taskify/core/services/crypto_service.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/app_lock_type_field.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_progress_hud.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';
import 'package:taskify/features/home/domain/entities/preferences/user_preferences_entity.dart';
import 'package:taskify/generated/l10n.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  late final TextEditingController _controller;
  int _attempts = 0;
  String? _error;
  bool _isLockedOut = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _verify(
      BuildContext context, String input, UserPreferencesEntity prefs) async {
    final appLockTypeLabel = prefs.appLockType.label(context);

    if (_isLockedOut) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final success = CryptoService.verifyPassword(
      input,
      prefs.hashedPassword!,
      prefs.appLockType == AppLockType.pin ? 'pinSalt' : 'passwordSalt',
    );

    if (success) {
      if (!context.mounted) return;
      AppLock.of(context)?.didUnlock();
    } else {
      setState(() {
        _attempts++;
        _controller.clear();
        _error = S.of(context).incorrectLockType(appLockTypeLabel);
      });

      if (_attempts >= 5) {
        setState(() {
          _isLockedOut = true;
          _error = S.of(context).tooManyAttempts;
        });

        Future.delayed(const Duration(seconds: 10), () {
          setState(() {
            _isLockedOut = false;
            _attempts = 0;
            _error = null;
          });
        });
      }
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: HiveService.preferencesNotifier,
          builder: (context, prefs, _) {
            final isPin = prefs.appLockType == AppLockType.pin;

            return CustomProgressHud(
              isLoading: _isLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalPadding),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                            isPin
                                ? S.of(context).enterYourPin
                                : S.of(context).enterYourPassword,
                            style: AppTextStyles.medium22),
                        const SizedBox(height: 20),
                        AppLockTypeField(
                          controller: _controller,
                          textAlign: isPin ? TextAlign.center : TextAlign.start,
                          keyboardType:
                              isPin ? TextInputType.number : TextInputType.text,
                          isPassword: !isPin,
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            _error!,
                            style: TextStyle(color: AppColors.errorColor),
                          ),
                        ],
                        const SizedBox(height: 40),
                        CustomButton(
                          title: S.of(context).unlock,
                          onPressed: _isLockedOut
                              ? null
                              : () => _verify(
                                    context,
                                    _controller.text.trim(),
                                    prefs,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
