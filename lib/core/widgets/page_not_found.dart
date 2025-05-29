import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';

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
              const SizedBox(height: 20),
              CustomAppbar(title: ''),
              const SizedBox(height: 60),
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
            ],
          ),
        ),
      ),
    );
  }
}
