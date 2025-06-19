import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/password_text_form_field.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/generated/l10n.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Column _resetPasswordPlaceholder() {
    return Column(
      children: [
        Lottie.asset(
          AppAssets.animationsResetPassword,
          filterQuality: FilterQuality.high,
          frameRate: FrameRate(120),
        ),
        Text(
          S.of(context).resetPasswordBody,
          style: AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomAppbar(title: S.of(context).resetPasswordAppBar),
              _resetPasswordPlaceholder(),
              const SizedBox(height: 36),
              PasswordTextFormField(
                hintText: S.of(context).newPasswordTextFieldHint,
                maxLength: 30,
                textInputAction: TextInputAction.next,
                controller: _newPasswordController,
              ),
              const SizedBox(height: 15),
              PasswordTextFormField(
                hintText: S.of(context).confirmPasswordTextFieldHint,
                maxLength: 30,
                textInputAction: TextInputAction.done,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 30),
              BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserUpdated) {
                    buildSnackbar(context,
                        message: 'Password updated successfully.');
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.signIn, (route) => false);
                  } else if (state is UserFailure) {
                    buildSnackbar(context,
                        message: 'Failed to reset password.');
                  }
                },
                child: CustomButton(
                  title: S.of(context).resetPasswordButton,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_newPasswordController.text.trim() !=
                          _confirmPasswordController.text.trim()) {
                        buildSnackbar(context,
                            message: 'Passwords do not match.');
                        return;
                      }
                      await context.read<UserCubit>().updateUserData(
                            newPassword: _newPasswordController.text,
                            uid: widget.supabase.auth.currentUser!.id,
                          );
                    } else {
                      _autovalidateMode = AutovalidateMode.always;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
