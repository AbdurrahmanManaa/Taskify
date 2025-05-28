import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() async {
    final prefs = await HiveService().getUserPreferences();
    bool isOnboardingSeen = prefs.isOnboardingSeen;
    final session = widget.supabase.auth.currentSession;

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
    return Container(
      alignment: Alignment.center,
      color: AppColors.primaryLightColor,
      child: Image.asset(AppAssets.imagesLightModeLogo),
    );
  }
}
