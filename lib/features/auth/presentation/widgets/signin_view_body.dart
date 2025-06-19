import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_progress_hud.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/core/widgets/password_text_form_field.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/auth/presentation/widgets/auth_button.dart';
import 'package:taskify/features/auth/presentation/widgets/auth_footer.dart';
import 'package:taskify/features/auth/presentation/widgets/auth_header.dart';
import 'package:taskify/features/auth/presentation/widgets/or_signin_with.dart';
import 'package:taskify/generated/l10n.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserLoggedIn) {
          buildSnackbar(context, message: 'Logged in successfully');
        } else if (state is UserFailure) {
          buildSnackbar(context, message: 'Failed to log in');
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
              autovalidateMode: _autovalidateMode,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        AuthHeader(
                          title: S.of(context).welcomeBackSignInView,
                          subtitle: S.of(context).signInToYourAccount,
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
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.forgotPassword),
                            child: Text(
                              S.of(context).forgotPassword,
                              style: AppTextStyles.regular18
                                  .copyWith(color: AppColors.greyColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          title: S.of(context).signInButton,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<UserCubit>()
                                  .signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                            } else {
                              _autovalidateMode = AutovalidateMode.always;
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                        const OrWidget(),
                        const SizedBox(height: 25),
                        AuthButton(
                          title: S.of(context).signInWithGoogle,
                          leading: SvgPicture.asset(
                            AppAssets.imagesGoogle,
                            height: 40,
                            width: 40,
                          ),
                          onTap: () async {
                            await context.read<UserCubit>().signInWithGoogle();
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
                          title: S.of(context).dontHaveAnAccount,
                          tapText: S.of(context).signUpRedirect,
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, AppRoutes.signUp, (route) => false);
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
