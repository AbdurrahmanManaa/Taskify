import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/task_repeat_view_body.dart';

class TaskRepeatView extends StatelessWidget {
  const TaskRepeatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TaskRepeatViewBody(),
      ),
    );
  }
}
