import 'dart:ui';
import 'package:flutter/material.dart';

class InActiveScreen extends StatelessWidget {
  const InActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ModalBarrier(
            dismissible: false,
            color: Colors.white,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.white.withAlpha(15),
            ),
          ),
        ],
      ),
    );
  }
}
