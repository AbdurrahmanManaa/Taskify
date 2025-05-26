import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/task_reminder_view_body.dart';

class TaskReminderView extends StatelessWidget {
  const TaskReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TaskReminderViewBody(),
      ),
    );
  }
}
