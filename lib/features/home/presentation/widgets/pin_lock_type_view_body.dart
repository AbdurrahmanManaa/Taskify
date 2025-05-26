import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/password_text_form_field.dart';

class PinLockTypeViewBody extends StatefulWidget {
  const PinLockTypeViewBody({super.key});

  @override
  State<PinLockTypeViewBody> createState() => _PinLockTypeViewBodyState();
}

class _PinLockTypeViewBodyState extends State<PinLockTypeViewBody> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomAppbar(
              title: 'Set PIN',
              showBackButton: false,
            ),
            SizedBox(height: 30),
            Text(
              'Remember this PIN. if you forget it, you\'ll need to reset your app and data wil be erased.',
              style: AppTextStyles.regular16.copyWith(
                color: AppColors.errorColor,
              ),
            ),
            SizedBox(height: 30),
            PasswordTextFormField(
              hintText: 'Enter PIN',
              controller: _controller,
              textAlign: TextAlign.center,
              maxLength: 6,
              autofocus: true,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.medium16
                          .copyWith(color: AppColors.primaryLightColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Continue',
                      style: AppTextStyles.medium16
                          .copyWith(color: AppColors.primaryLightColor),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
