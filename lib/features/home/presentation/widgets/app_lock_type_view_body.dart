import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/app_lock_type_field.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_lock_type.dart';

class AppLockTypeViewBody extends StatefulWidget {
  const AppLockTypeViewBody({super.key});

  @override
  State<AppLockTypeViewBody> createState() => _AppLockTypeViewBodyState();
}

class _AppLockTypeViewBodyState extends State<AppLockTypeViewBody> {
  late final AppLockType appLockType;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    appLockType = context.read<AppLockType>();
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
                  final lock = _controller.text.trim();
                  Navigator.pop(context, lock);
                },
                child: Text(
                  'Confirm',
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
                  final lock = _controller.text.trim();
                  Navigator.pop(context, lock);
                },
                child: Text(
                  'Confirm',
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
      child: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }
}
