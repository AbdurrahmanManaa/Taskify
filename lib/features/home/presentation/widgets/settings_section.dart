import 'package:flutter/material.dart';
import 'package:taskify/features/auth/presentation/widgets/header_widget.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.widgets,
    required this.title,
  });
  final String title;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(title: title),
        ...widgets,
      ],
    );
  }
}
