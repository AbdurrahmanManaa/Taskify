import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:taskify/core/utils/app_assets.dart';

class CustomProgressHud extends StatelessWidget {
  const CustomProgressHud({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: Lottie.asset(
        AppAssets.animationsLoading,
        filterQuality: FilterQuality.high,
        frameRate: FrameRate(120),
        width: 200,
        height: 200,
      ),
      opacity: 0.5,
      inAsyncCall: isLoading,
      child: child,
    );
  }
}
