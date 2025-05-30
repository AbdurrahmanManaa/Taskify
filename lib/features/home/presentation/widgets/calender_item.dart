import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';

class CalenderItem extends StatelessWidget {
  const CalenderItem({super.key, required this.taskEntity, this.onTap});
  final TaskEntity taskEntity;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            color: Color(0xfff8f9fb),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              side: BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            size: 20,
                            color: AppColors.bodyTextColor,
                          ),
                          Text(
                            '${DateTimeUtils.formatTime(taskEntity.startTime)} - ${DateTimeUtils.formatTime(taskEntity.endTime)}',
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ],
                      ),
                      Spacer(),
                      TaskUIHelper.buildStatusTag(taskEntity.status),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              AppColors.transparentColor),
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          visualDensity: VisualDensity.compact,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            onTap: () {
                              context.read<TaskCubit>().updateTask(
                                data: {'status': 'Completed'},
                                taskId: taskEntity.id,
                                userId: taskEntity.userId,
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text('Mark as Complete'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                'editTask',
                                arguments: taskEntity,
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor:
                                      AppColors.scaffoldLightBackgroundColor,
                                  title: const Text('Delete Task'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: AppColors.primaryLightColor),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: AppColors.primaryLightColor),
                                      ),
                                      onPressed: () async {
                                        await context
                                            .read<TaskCubit>()
                                            .deleteSingleTask(
                                                taskId: taskEntity.id,
                                                userId: taskEntity.userId);

                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColors.errorColor,
                                ),
                                const SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    taskEntity.title,
                    style: AppTextStyles.medium16
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  if (taskEntity.description != null &&
                      taskEntity.description!.isNotEmpty)
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      taskEntity.description!,
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.bodyTextColor,
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 4,
            bottom: 4,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: TaskUIHelper.getPriorityDetails(
                    taskEntity.priority)['color'], // Dynamic color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
