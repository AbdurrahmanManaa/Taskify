import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/edit_user_view_body.dart';

class EditUserView extends StatelessWidget {
  const EditUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EditUserViewBody(),
      ),
    );
  }
}
