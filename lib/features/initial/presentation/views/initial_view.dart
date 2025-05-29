import 'package:flutter/material.dart';
import 'package:taskify/features/initial/presentation/widgets/initial_view_body.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InitialViewBody(),
      ),
    );
  }
}
