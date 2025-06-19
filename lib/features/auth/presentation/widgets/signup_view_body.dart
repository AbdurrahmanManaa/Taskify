import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_progress_hud.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/core/widgets/password_text_form_field.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/auth/presentation/widgets/auth_footer.dart';
import 'package:taskify/features/auth/presentation/widgets/auth_header.dart';
import 'package:taskify/generated/l10n.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserCreated) {
          buildSnackbar(context,
              message:
                  'User created successfully, Check your email for verification');
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.signIn, (route) => false);
        } else if (state is UserFailure) {
          buildSnackbar(context, message: 'Failed to create user');
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is UserLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        AuthHeader(
                          title: S.of(context).createAccount,
                          subtitle: S.of(context).letsCreateAccountTogether,
                        ),
                        const SizedBox(height: 25),
                        FieldItem(
                          label: S.of(context).fullNameTextField,
                          widget: CustomTextFormField(
                            hintText: S.of(context).fullNameTextFieldHint,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            textInputAction: TextInputAction.next,
                            maxLength: 100,
                            controller: _fullNameController,
                          ),
                        ),
                        FieldItem(
                          label: S.of(context).emailTextField,
                          widget: CustomTextFormField(
                            hintText: S.of(context).emailTextFieldHint,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            maxLength: 254,
                            controller: _emailController,
                          ),
                        ),
                        FieldItem(
                          label: S.of(context).passwordTextField,
                          widget: PasswordTextFormField(
                            hintText: S.of(context).passwordTextFieldHint,
                            maxLength: 30,
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          title: S.of(context).signUpButton,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<UserCubit>()
                                  .signUpWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    fullName: _fullNameController.text,
                                  );
                            } else {
                              _autoValidateMode = AutovalidateMode.always;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const Spacer(),
                        AuthFooter(
                          title: S.of(context).alreadyHaveAnAccount,
                          tapText: S.of(context).signInRedirect,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.signIn);
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
