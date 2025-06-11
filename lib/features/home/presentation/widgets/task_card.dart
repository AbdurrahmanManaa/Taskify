import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/utils/task_dialog_utils.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/views/edit_task_view.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tag_container.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final GlobalKey<FormState> _taskFormKey = GlobalKey();
  AutovalidateMode _taskAutoValidateMode = AutovalidateMode.disabled;
  late String? _selectedTaskDueDate;
  late String? _selectedTaskStartTime;
  late String? _selectedTaskEndTime;
  List<TaskCategoryEntity> _customCategories = [];

  @override
  void initState() {
    super.initState();
    _selectedTaskDueDate = DateTimeUtils.formatDate(widget.taskEntity.dueDate);
    _selectedTaskStartTime =
        DateTimeUtils.formatTime(widget.taskEntity.startTime);
    _selectedTaskEndTime = DateTimeUtils.formatTime(widget.taskEntity.endTime);
    _loadCustomCategoriesFromHive();
  }

  Future<void> _loadCustomCategoriesFromHive() async {
    var categoriesBox = await Hive.openBox(AppConstants.categoriesBox);
    List<TaskCategoryEntity> categories =
        List<TaskCategoryEntity>.from(categoriesBox.values);
    setState(() {
      _customCategories = categories;
    });
  }

  Future<void> _rescheduleTask(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 23),
          child: Form(
            key: _taskFormKey,
            autovalidateMode: _taskAutoValidateMode,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FieldItem(
                    label: 'Due Date',
                    widget: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate =
                            await TaskDialogUtils.showCustomDatePickerDialog(
                          context: context,
                          initialDate: DateTime.parse(
                            _selectedTaskDueDate ??
                                DateTimeUtils.formatDate(
                                    widget.taskEntity.dueDate),
                          ),
                          isOverdueTask: true,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _selectedTaskDueDate =
                                DateTimeUtils.formatDate(pickedDate);
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          hintText: _selectedTaskDueDate ??
                              DateTimeUtils.formatDate(
                                  widget.taskEntity.dueDate),
                          isReadOnly: true,
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FieldItem(
                          label: 'Start Time',
                          widget: GestureDetector(
                            onTap: () async {
                              String initialTime = _selectedTaskStartTime ??
                                  DateTimeUtils.formatTime(
                                      widget.taskEntity.startTime);
                              String? pickedStartTime = await TaskDialogUtils
                                  .showCustomTimePickerDialog(
                                isStartTime: true,
                                context: context,
                                initialTime: initialTime,
                              );
                              if (pickedStartTime != null) {
                                setState(() {
                                  _selectedTaskStartTime = pickedStartTime;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                hintText: _selectedTaskStartTime ??
                                    DateTimeUtils.formatTime(
                                        widget.taskEntity.startTime),
                                isReadOnly: true,
                                suffixIcon:
                                    const Icon(Icons.access_time_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FieldItem(
                          label: 'End Time',
                          widget: GestureDetector(
                            onTap: () async {
                              String initialTime = _selectedTaskEndTime ??
                                  DateTimeUtils.formatTime(
                                      widget.taskEntity.endTime);
                              String? pickedEndTime = await TaskDialogUtils
                                  .showCustomTimePickerDialog(
                                isStartTime: false,
                                context: context,
                                initialTime: initialTime,
                              );
                              if (pickedEndTime != null) {
                                setState(() {
                                  _selectedTaskEndTime = pickedEndTime;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                hintText: _selectedTaskEndTime ??
                                    DateTimeUtils.formatTime(
                                        widget.taskEntity.endTime),
                                isReadOnly: true,
                                suffixIcon:
                                    const Icon(Icons.access_time_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Reschedule Task',
                    onPressed: () async {
                      if (_taskFormKey.currentState!.validate()) {
                        await context.read<TaskCubit>().updateTask(
                              userId: widget.taskEntity.userId,
                              data: {
                                'due_date': _selectedTaskDueDate ??
                                    widget.taskEntity.dueDate,
                                'start_time': _selectedTaskStartTime ??
                                    widget.taskEntity.startTime,
                                'end_time': _selectedTaskEndTime ??
                                    widget.taskEntity.endTime,
                                'status': TaskStatus.inProgress.label,
                              },
                              taskId: widget.taskEntity.id,
                            );

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } else {
                        _taskAutoValidateMode = AutovalidateMode.always;
                      }
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteTask(
    BuildContext context,
    List<String> dataPaths,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text('Delete Task Permanently'),
        content: const Text(
            'Are you sure you want to delete this task permanently?'),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.primaryLightColor),
            ),
            onPressed: () async {
              await context
                  .read<AttachmentCubit>()
                  .deleteAttachmentsFromStorage(
                    taskId: widget.taskEntity.id,
                    dataPaths: dataPaths,
                  );
              if (!context.mounted) return;
              await context.read<TaskCubit>().deleteSingleTask(
                    userId: widget.taskEntity.userId,
                    taskId: widget.taskEntity.id,
                  );
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateTimeUtils.formatDate(widget.taskEntity.dueDate);
    final Map<String, dynamic> uncategorizedCategory = {
      'name': 'Uncategorized',
      'icon': Icons.help_outline,
      'color': AppColors.greyColor,
    };

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
                    TaskUIHelper.buildStatusTag(widget.taskEntity.status),
                    CustomPopupMenuButton(
                      taskEntity: widget.taskEntity,
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                      items: [
                        if (widget.taskEntity.status != TaskStatus.completed &&
                            widget.taskEntity.status != TaskStatus.trash)
                          PopupMenuItem(
                            value: 0,
                            onTap: () async {
                              await context.read<TaskCubit>().updateTask(
                                    userId: widget.taskEntity.userId,
                                    data: {
                                      'status': TaskStatus.completed.label,
                                    },
                                    taskId: widget.taskEntity.id,
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
                        if (widget.taskEntity.status != TaskStatus.trash)
                          PopupMenuItem(
                            value: 1,
                            onTap: () {
                              pushScreenWithoutNavBar(
                                context,
                                Provider.value(
                                  value: widget.taskEntity,
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
                                Text('Edit'),
                              ],
                            ),
                          ),
                        if (widget.taskEntity.status == TaskStatus.overdue)
                          PopupMenuItem(
                            value: 5,
                            onTap: () async {
                              await _rescheduleTask(context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.arrowRotateRight,
                                  color: Colors.blueAccent,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('Reschedule'),
                              ],
                            ),
                          ),
                        if (widget.taskEntity.status != TaskStatus.trash)
                          PopupMenuItem(
                            value: 2,
                            onTap: () async {
                              await context.read<TaskCubit>().updateTask(
                                    userId: widget.taskEntity.userId,
                                    data: {
                                      'status': TaskStatus.trash.label,
                                    },
                                    taskId: widget.taskEntity.id,
                                  );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: AppColors.greyColor,
                                ),
                                const SizedBox(width: 8),
                                Text('Move to Trash'),
                              ],
                            ),
                          ),
                        if (widget.taskEntity.status == TaskStatus.trash)
                          PopupMenuItem(
                            value: 3,
                            onTap: () async {
                              await context.read<TaskCubit>().updateTask(
                                    userId: widget.taskEntity.userId,
                                    data: {
                                      'status': TaskStatus.inProgress.label,
                                    },
                                    taskId: widget.taskEntity.id,
                                  );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.restore,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text('Restore'),
                              ],
                            ),
                          ),
                        PopupMenuItem(
                          value: 4,
                          onTap: () async {
                            final attachments =
                                context.watch<AttachmentCubit>().attachments;
                            List<String> attachmentPaths = attachments
                                .where((attachment) =>
                                    attachment.taskId == widget.taskEntity.id)
                                .map((attachment) => attachment.filePath)
                                .toList();
                            await _deleteTask(
                              context,
                              attachmentPaths,
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
                Wrap(
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
                              bool isValidCategory = _customCategories
                                      .any((c) => c.name == category.name) ||
                                  predefinedCategories
                                      .any((c) => c['name'] == category.name);

                              if (!isValidCategory) {
                                if (_customCategories.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CustomTagContainer(
                                      iconColor: uncategorizedCategory['color'],
                                      iconCodePoint:
                                          uncategorizedCategory['icon']
                                              .codePoint,
                                      title: uncategorizedCategory['name'],
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
                          iconCodePoint: Icons.attachment_outlined.codePoint,
                          title: widget.taskEntity.attachmentsCount.toString(),
                        ),
                        CustomTagContainer(
                          iconColor: AppColors.bodyTextColor,
                          iconCodePoint: Icons.assignment_outlined.codePoint,
                          title: widget.taskEntity.subtaskCount.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
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
