import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/widgets/page_not_found.dart';
import 'package:taskify/features/auth/presentation/views/forgot_password_view.dart';
import 'package:taskify/features/auth/presentation/views/reset_password_view.dart';
import 'package:taskify/features/auth/presentation/views/signin_view.dart';
import 'package:taskify/features/auth/presentation/views/signup_view.dart';
import 'package:taskify/features/home/presentation/views/main_view.dart';
import 'package:taskify/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:taskify/features/initial/presentation/views/initial_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.initial:
      return MaterialPageRoute(
        builder: (_) => const InitialView(),
      );

    case AppRoutes.onBoarding:
      return MaterialPageRoute(
        builder: (_) => const OnboardingView(),
      );

    case AppRoutes.signIn:
      return MaterialPageRoute(
        builder: (_) => const SigninView(),
      );

    case AppRoutes.signUp:
      return MaterialPageRoute(
        builder: (_) => const SignupView(),
      );

    case AppRoutes.forgotPassword:
      return MaterialPageRoute(
        builder: (_) => const ForgotPasswordView(),
      );

    case AppRoutes.resetPassword:
      return MaterialPageRoute(
        builder: (_) => const ResetPasswordView(),
      );

    case AppRoutes.main:
      return MaterialPageRoute(
        builder: (_) => const MainView(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const PageNotFound(),
      );
  }
}
