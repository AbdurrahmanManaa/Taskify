import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';

class SubtaskItem extends StatelessWidget {
  const SubtaskItem(
      {super.key, required this.subtaskEntity, this.trailing, this.leading});
  final SubtaskEntity subtaskEntity;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Color.fromARGB(255, 223, 225, 231),
        ),
      ),
      tileColor: AppColors.scaffoldLightBackgroundColor,
      leading: leading,
      title: Text(subtaskEntity.title,
          style: AppTextStyles.medium16.copyWith(
            decoration: subtaskEntity.status == SubtaskStatus.completed
                ? TextDecoration.lineThrough
                : null,
          )),
      subtitle: (subtaskEntity.note != null && subtaskEntity.note!.isNotEmpty)
          ? Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xfff8f9fb),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 223, 225, 231),
                ),
              ),
              child: Text(
                subtaskEntity.note!,
                style: AppTextStyles.regular16.copyWith(
                  decoration: subtaskEntity.status == SubtaskStatus.completed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
