import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/get_it_service.dart';
import 'package:taskify/features/home/presentation/widgets/calender_view_body.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CalenderViewBody(
      supabase: getIt<SupabaseClient>(),
    );
  }
}
