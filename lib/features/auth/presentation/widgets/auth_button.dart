import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.leading, this.onTap, required this.title});
  final Widget? leading;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              offset: Offset(0, 4),
              blurRadius: 20,
            ),
          ],
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ?? const SizedBox.shrink(),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.regular18,
            ),
          ],
        ),
      ),
    );
  }
}
