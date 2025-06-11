import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/app_lock_type_field.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/page_not_found.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';

enum _LockPhase { firstEntry, confirmEntry }

class AppLockTypeViewBody extends StatefulWidget {
  const AppLockTypeViewBody({super.key});

  @override
  State<AppLockTypeViewBody> createState() => _AppLockTypeViewBodyState();
}

class _AppLockTypeViewBodyState extends State<AppLockTypeViewBody> {
  late final AppLockType appLockType;
  late final TextEditingController _controller;
  _LockPhase _phase = _LockPhase.firstEntry;
  String? _firstInput;
  String? _error;

  @override
  void initState() {
    super.initState();
    appLockType = context.read<AppLockType>();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    switch (appLockType) {
      case AppLockType.pin:
        return _buildPinEditor();
      case AppLockType.password:
        return _buildPasswordEditor();
      default:
        return PageNotFound();
    }
  }

  Widget _buildPinEditor() {
    return Column(
      children: [
        SizedBox(height: 20),
        CustomAppbar(
          title: 'Set PIN',
          showBackButton: false,
        ),
        SizedBox(height: 20),
        Text(
          'Remember this PIN. if you forget it, you\'ll need to reset to access app again.',
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.errorColor,
          ),
        ),
        SizedBox(height: 30),
        AppLockTypeField(
          controller: _controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          isPassword: false,
        ),
        if (_error != null) ...[
          SizedBox(height: 10),
          Text(
            _error!,
            style: TextStyle(color: AppColors.errorColor),
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: AppTextStyles.medium18
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  final input = _controller.text.trim();
                  if (input.isEmpty) return;
                  if (_phase == _LockPhase.firstEntry) {
                    setState(() {
                      _firstInput = input;
                      _controller.clear();
                      _phase = _LockPhase.confirmEntry;
                      _error = null;
                    });
                  } else {
                    if (_firstInput == input) {
                      Navigator.pop(context, input);
                    } else {
                      setState(() {
                        _error = 'Values do not match. Try again.';
                        _firstInput = null;
                        _controller.clear();
                        _phase = _LockPhase.firstEntry;
                      });
                    }
                  }
                },
                child: Text(
                  _phase == _LockPhase.firstEntry ? 'Continue' : 'OK',
                  style: AppTextStyles.medium18
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordEditor() {
    return Column(
      children: [
        SizedBox(height: 20),
        CustomAppbar(
          title: 'Set Password',
          showBackButton: false,
        ),
        SizedBox(height: 20),
        Text(
          'Remember this password. if you forget it, you\'ll need to reset to access app again.',
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.errorColor,
          ),
        ),
        SizedBox(height: 30),
        AppLockTypeField(controller: _controller),
        if (_error != null) ...[
          SizedBox(height: 10),
          Text(
            _error!,
            style: TextStyle(color: AppColors.errorColor),
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: AppTextStyles.medium18
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  final input = _controller.text.trim();
                  if (input.isEmpty) return;
                  if (_phase == _LockPhase.firstEntry) {
                    setState(() {
                      _firstInput = input;
                      _controller.clear();
                      _phase = _LockPhase.confirmEntry;
                      _error = null;
                    });
                  } else {
                    if (_firstInput == input) {
                      Navigator.pop(context, input);
                    } else {
                      setState(() {
                        _error = 'Values do not match. Try again.';
                        _firstInput = null;
                        _controller.clear();
                        _phase = _LockPhase.firstEntry;
                      });
                    }
                  }
                },
                child: Text(
                  _phase == _LockPhase.firstEntry ? 'Continue' : 'OK',
                  style: AppTextStyles.medium18
                      .copyWith(color: AppColors.primaryLightColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: Center(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }
}
