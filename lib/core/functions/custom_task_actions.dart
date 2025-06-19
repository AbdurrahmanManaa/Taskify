import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/views/edit_task_view.dart';
import 'package:taskify/generated/l10n.dart';

Widget customTaskActions(
  BuildContext context,
  TaskEntity taskEntity,
  Future<void> Function() reschedule,
  Future<void> Function() delete,
) {
  return CustomPopupMenuButton(
    taskEntity: taskEntity,
    icon: Icon(
      Icons.more_vert,
      color: Colors.black,
    ),
    items: [
      if (taskEntity.status != TaskStatus.completed &&
          taskEntity.status != TaskStatus.trash)
        PopupMenuItem(
          value: 0,
          onTap: () async {
            await context.read<TaskCubit>().updateTask(
                  userId: taskEntity.userId,
                  data: {
                    'status': TaskStatus.completed.labelDB,
                  },
                  taskId: taskEntity.id,
                );
          },
          child: Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(S.of(context).markAsComplete),
            ],
          ),
        ),
      if (taskEntity.status != TaskStatus.trash)
        PopupMenuItem(
          value: 1,
          onTap: () {
            pushScreenWithoutNavBar(
              context,
              Provider.value(
                value: taskEntity,
                child: const EditTaskView(),
              ),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(S.of(context).editTaskAction),
            ],
          ),
        ),
      if (taskEntity.status == TaskStatus.overdue)
        PopupMenuItem(
          value: 5,
          onTap: () async {
            await reschedule();
          },
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.arrowRotateRight,
                color: Colors.blueAccent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(S.of(context).reschedule),
            ],
          ),
        ),
      if (taskEntity.status != TaskStatus.trash)
        PopupMenuItem(
          value: 2,
          onTap: () async {
            await context.read<TaskCubit>().updateTask(
                  userId: taskEntity.userId,
                  data: {
                    'status': TaskStatus.trash.labelDB,
                  },
                  taskId: taskEntity.id,
                );
          },
          child: Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: AppColors.greyColor,
              ),
              const SizedBox(width: 8),
              Text(S.of(context).moveToTrash),
            ],
          ),
        ),
      if (taskEntity.status == TaskStatus.trash)
        PopupMenuItem(
          value: 3,
          onTap: () async {
            await context.read<TaskCubit>().updateTask(
                  userId: taskEntity.userId,
                  data: {
                    'status': TaskStatus.inProgress.labelDB,
                  },
                  taskId: taskEntity.id,
                );
          },
          child: Row(
            children: [
              Icon(
                Icons.restore,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(S.of(context).restoreTaskAction),
            ],
          ),
        ),
      PopupMenuItem(
        value: 4,
        onTap: () async {
          await delete();
        },
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: AppColors.errorColor,
            ),
            const SizedBox(width: 8),
            Text(S.of(context).deleteTaskAction),
          ],
        ),
      ),
    ],
  );
}
