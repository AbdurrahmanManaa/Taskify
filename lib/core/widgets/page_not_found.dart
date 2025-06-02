import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/widgets/custom_button.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Lottie.asset(
                AppAssets.animationsPageNotFound,
                filterQuality: FilterQuality.high,
                frameRate: FrameRate(120),
              ),
              const SizedBox(height: 24),
              const Text(
                "Oops! Page not found.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "We couldn't find the page you're looking for.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 50),
              CustomButton(
                title: 'Go Home',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.main, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
