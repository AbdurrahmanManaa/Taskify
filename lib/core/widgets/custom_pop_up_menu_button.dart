import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    this.taskEntity,
    this.icon,
    required this.items,
    this.subtaskEntity,
    this.onSelected,
  });

  final TaskEntity? taskEntity;
  final SubtaskEntity? subtaskEntity;
  final Widget? icon;
  final List<PopupMenuEntry<int>> items;
  final Function(int)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
      icon: icon,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.transparentColor),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
        splashFactory: NoSplash.splashFactory,
      ),
      itemBuilder: (context) => items,
    );
  }
}
