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
          const Opacity(
            opacity: 1.0,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: const SizedBox.expand(),
          ),
        ],
      ),
    );
  }
}
