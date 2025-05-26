import 'package:flutter/material.dart';
import 'package:taskify/features/auth/presentation/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResetPasswordViewBody(),
      ),
    );
  }
}
