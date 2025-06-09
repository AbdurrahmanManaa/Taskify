import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/app_lock_view_body.dart';

class AppLockView extends StatelessWidget {
  const AppLockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLockViewBody(),
      ),
    );
  }
}
