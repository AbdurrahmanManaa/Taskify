import 'package:flutter/material.dart';
import 'package:taskify/features/home/presentation/widgets/task_details_view_body.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TaskDetailsViewBody(),
      ),
    );
  }
}
