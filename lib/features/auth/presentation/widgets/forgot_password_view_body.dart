import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/generated/l10n.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  late TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Column _forgotPasswordPlaceholder() {
    return Column(
      children: [
        Lottie.asset(
          AppAssets.animationsForgotPassword,
          filterQuality: FilterQuality.high,
          frameRate: FrameRate(120),
        ),
        Text(
          S.of(context).forgotPasswordBody,
          style: AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomAppbar(title: S.of(context).forgotPasswordAppBar),
              _forgotPasswordPlaceholder(),
              const SizedBox(height: 40),
              CustomTextFormField(
                hintText: S.of(context).emailTextFieldHint,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.done,
                maxLength: 100,
                controller: _emailController,
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: S.of(context).sendButton,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await context.read<UserCubit>().resetPassword(
                          email: _emailController.text.trim(),
                        );
                    if (!context.mounted) return;
                    buildSnackbar(context,
                        message: 'Password reset email sent.');
                    _emailController.clear();
                  } else {
                    _autovalidateMode = AutovalidateMode.always;
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
