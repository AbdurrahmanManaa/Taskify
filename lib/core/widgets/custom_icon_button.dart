import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const ShapeDecoration(
        shape: OvalBorder(
          side: BorderSide(
            width: 1,
            color: Color(0xFFDADADA),
          ),
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
