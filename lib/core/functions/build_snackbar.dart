import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

void buildSnackbar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: AppTextStyles.regular16,
        ),
      ),
      animation: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: Scaffold.of(context),
        ),
        curve: Curves.easeOut,
      )),
    ),
  );
}
