import 'package:flutter/material.dart';
import 'package:taskify/features/auth/presentation/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SignupViewBody(),
      ),
    );
  }
}
