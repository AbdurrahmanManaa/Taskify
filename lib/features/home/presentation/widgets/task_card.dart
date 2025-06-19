import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/functions/custom_task_actions.dart';
import 'package:taskify/core/functions/delete_task.dart';
import 'package:taskify/core/functions/reschedule_task.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tag_container.dart';
import 'package:taskify/generated/l10n.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late String? _selectedTaskDueDate;
  late String? _selectedTaskStartTime;
  late String? _selectedTaskEndTime;

  @override
  void initState() {
    super.initState();
    _selectedTaskDueDate = DateTimeUtils.formatDate(widget.taskEntity.dueDate);
    _selectedTaskStartTime =
        DateTimeUtils.formatTime(widget.taskEntity.startTime);
    _selectedTaskEndTime = DateTimeUtils.formatTime(widget.taskEntity.endTime);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateTimeUtils.formatDate(widget.taskEntity.dueDate);
    final Map<String, dynamic> uncategorizedCategory = {
      'name': S.of(context).uncategorized,
      'icon': Icons.help_outline,
      'color': AppColors.greyColor,
    };
    final predefinedCategories = predefinedTaskCategories(context);

    return Stack(
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
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.taskEntity.title,
                        style: AppTextStyles.medium16
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    TaskUIHelper.buildStatusTag(
                      context,
                      widget.taskEntity.status,
                    ),
                    customTaskActions(
                      context,
                      widget.taskEntity,
                      () async {
                        await rescheduleTask(
                          context,
                          _selectedTaskDueDate ??
                              DateTimeUtils.formatDate(
                                  widget.taskEntity.dueDate),
                          widget.taskEntity,
                          {
                            'due_date': _selectedTaskDueDate ??
                                widget.taskEntity.dueDate,
                            'start_time': _selectedTaskStartTime ??
                                widget.taskEntity.startTime,
                            'end_time': _selectedTaskEndTime ??
                                widget.taskEntity.endTime,
                            'status': TaskStatus.inProgress.labelDB,
                          },
                          _selectedTaskStartTime ??
                              DateTimeUtils.formatTime(
                                  widget.taskEntity.startTime),
                          _selectedTaskEndTime ??
                              DateTimeUtils.formatTime(
                                  widget.taskEntity.endTime),
                          (pickedDate) {
                            setState(() {
                              _selectedTaskDueDate = pickedDate;
                            });
                          },
                          (pickedStartTime) {
                            setState(() {
                              _selectedTaskStartTime = pickedStartTime;
                            });
                          },
                          (pickedEndTime) {
                            setState(() {
                              _selectedTaskEndTime = pickedEndTime;
                            });
                          },
                        );
                      },
                      () async {
                        final attachments =
                            context.read<AttachmentCubit>().attachments;
                        List<String> attachmentPaths = attachments
                            .where((attachment) =>
                                attachment.taskId == widget.taskEntity.id)
                            .map((attachment) => attachment.filePath)
                            .toList();
                        await deleteTask(
                          context,
                          widget.taskEntity.userId,
                          widget.taskEntity.id,
                          attachmentPaths,
                          null,
                        );
                      },
                    ),
                  ],
                ),
                if (widget.taskEntity.description != null &&
                    widget.taskEntity.description!.isNotEmpty)
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.taskEntity.description!,
                    style: AppTextStyles.regular16,
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: AppColors.bodyTextColor,
                        ),
                        Text(
                          formattedDate,
                          style: AppTextStyles.regular14
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        const Icon(
                          FontAwesomeIcons.clock,
                          size: 20,
                          color: AppColors.bodyTextColor,
                        ),
                        Text(
                          '${DateTimeUtils.formatTime(widget.taskEntity.startTime)} - ${DateTimeUtils.formatTime(widget.taskEntity.endTime)}',
                          style: AppTextStyles.regular14
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                ValueListenableBuilder<List<TaskCategoryEntity>>(
                    valueListenable: HiveService.categoriesNotifier,
                    builder: (context, customCategories, _) {
                      return Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        alignment: WrapAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.taskEntity.categories.isNotEmpty) ...[
                                ...widget.taskEntity.categories.map(
                                  (category) {
                                    bool isValidCategory = customCategories.any(
                                            (c) => c.name == category.name) ||
                                        predefinedCategories.any(
                                            (c) => c['name'] == category.name);
                                    if (!isValidCategory) {
                                      if (customCategories.isEmpty) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: CustomTagContainer(
                                            iconColor:
                                                uncategorizedCategory['color'],
                                            iconCodePoint:
                                                uncategorizedCategory['icon']
                                                    .codePoint,
                                            title:
                                                uncategorizedCategory['name'],
                                          ),
                                        );
                                      }
                                    }
                                    return CustomTagContainer(
                                      iconColor: category.color,
                                      iconCodePoint: category.icon.codePoint,
                                      title: category.name,
                                    );
                                  },
                                ),
                              ] else
                                CustomTagContainer(
                                  iconColor: uncategorizedCategory['color'],
                                  iconCodePoint:
                                      uncategorizedCategory['icon'].codePoint,
                                  title: uncategorizedCategory['name'],
                                ),
                              CustomTagContainer(
                                iconColor: AppColors.bodyTextColor,
                                iconCodePoint:
                                    Icons.attachment_outlined.codePoint,
                                title: widget.taskEntity.attachmentsCount
                                    .toString(),
                              ),
                              CustomTagContainer(
                                iconColor: AppColors.bodyTextColor,
                                iconCodePoint:
                                    Icons.assignment_outlined.codePoint,
                                title:
                                    widget.taskEntity.subtaskCount.toString(),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
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
                  widget.taskEntity.priority)['color'],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
