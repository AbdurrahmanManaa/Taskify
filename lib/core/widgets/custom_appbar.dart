import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    this.showBackButton = true,
    required this.title,
    this.actions,
    this.result,
  });
  final bool showBackButton;
  final String title;
  final List<Widget>? actions;
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showBackButton,
          child: GestureDetector(
            onTap: () {
              if (result != null) {
                Navigator.pop(context, result);
              } else {
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppTextStyles.medium24.copyWith(color: Colors.black),
        ),
        Spacer(),
        ...actions ?? [],
      ],
    );
  }
}
