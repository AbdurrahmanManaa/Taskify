import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EditTaskViewBody(),
      ),
    );
  }
}
