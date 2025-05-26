import 'package:flutter/material.dart';
import 'package:taskify/core/widgets/field_label.dart';

class FieldItem extends StatelessWidget {
  const FieldItem({super.key, required this.label, required this.widget});
  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FieldLabel(label: label),
        ),
        widget,
      ],
    );
  }
}
