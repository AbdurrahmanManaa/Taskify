import 'package:flutter/material.dart';
import 'package:taskify/features/auth/presentation/widgets/signin_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SigninViewBody(),
      ),
    );
  }
}
