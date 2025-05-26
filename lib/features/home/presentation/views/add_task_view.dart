import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/get_it_service.dart';
import 'package:taskify/features/home/presentation/widgets/add_task_view_body.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return AddTaskViewBody(
      supabase: getIt<SupabaseClient>(),
    );
  }
}
