import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/get_it_service.dart';
import 'package:taskify/features/home/presentation/widgets/task_details_view_body.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TaskDetailsViewBody(
          supabase: getIt<SupabaseClient>(),
        ),
      ),
    );
  }
}
