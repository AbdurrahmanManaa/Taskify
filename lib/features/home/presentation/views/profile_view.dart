import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProfileViewBody(),
      ),
    );
  }
}
