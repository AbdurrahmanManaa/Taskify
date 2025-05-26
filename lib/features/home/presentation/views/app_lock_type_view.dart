import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/app_lock_type_view_body.dart';

class AppLockTypeView extends StatelessWidget {
  const AppLockTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLockTypeViewBody(),
      ),
    );
  }
}
