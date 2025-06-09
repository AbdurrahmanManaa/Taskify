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

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                        const AuthHeader(
                          title: 'Create an account,',
                          subtitle: 'Let’s create account together',
                        ),
                        const SizedBox(height: 25),
                        FieldItem(
                          label: 'Full Name',
                          widget: CustomTextFormField(
                            hintText: 'Enter your name',
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            textInputAction: TextInputAction.next,
                            maxLength: 100,
                            controller: _fullNameController,
                          ),
                        ),
                        FieldItem(
                          label: 'Email',
                          widget: CustomTextFormField(
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            maxLength: 254,
                            controller: _emailController,
                          ),
                        ),
                        FieldItem(
                          label: 'Password',
                          widget: PasswordTextFormField(
                            hintText: 'Enter your password',
                            maxLength: 30,
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                          ),
                        ),
                        FieldItem(
                          label: 'Confirm Password',
                          widget: PasswordTextFormField(
                            hintText: 'Confirm your password',
                            maxLength: 30,
                            textInputAction: TextInputAction.done,
                            controller: _confirmPasswordController,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          title: 'Sign Up',
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
                          title: 'Already have an account? ',
                          tapText: 'Sign In',
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
