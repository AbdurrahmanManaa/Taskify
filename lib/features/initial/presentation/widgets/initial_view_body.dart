import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/get_it_service.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/services/hive_service.dart';

class InitialViewBody extends StatefulWidget {
  const InitialViewBody({super.key});

  @override
  State<InitialViewBody> createState() => _InitialViewBodyState();
}

class _InitialViewBodyState extends State<InitialViewBody> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() async {
    final prefs = await HiveService().getUserPreferences();
    final supabase = getIt<SupabaseClient>();
    bool isOnboardingSeen = prefs.isOnboardingSeen;
    final session = supabase.auth.currentSession;

    if (!mounted) return;
    if (isOnboardingSeen) {
      if (session != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.main,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.signIn,
          (route) => false,
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.onBoarding,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
