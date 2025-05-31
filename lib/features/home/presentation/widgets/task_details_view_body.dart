import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/extensions/task_status_extension.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/task_dialog_utils.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/home/domain/entities/category_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/attachments_tab.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:taskify/features/home/presentation/widgets/subtasks_tab.dart';
import 'package:taskify/features/home/presentation/widgets/task_basic_info.dart';
import 'package:taskify/features/home/presentation/widgets/task_timeline_info.dart';

class TaskDetailsViewBody extends StatefulWidget {
  const TaskDetailsViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<TaskDetailsViewBody> createState() => _TaskDetailsViewBodyState();
}

class _TaskDetailsViewBodyState extends State<TaskDetailsViewBody> {
  late final TaskEntity taskEntity;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  late List<CategoryEntity> _customCategories;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    taskEntity = context.read<TaskEntity>();
    getTasks();
    getSubtasks();
    getAttachments();
    _loadCustomCategoriesFromHive();
  }

  Future<void> getTasks() async {
    await context
        .read<TaskCubit>()
        .getTasks(userId: widget.supabase.auth.currentUser!.id);
  }

  Future<void> getSubtasks() async {
    await context.read<SubtaskCubit>().getSubtasks(taskId: taskEntity.id);
  }

  Future<void> getAttachments() async {
    await context.read<AttachmentCubit>().getAttachments(taskId: taskEntity.id);
  }

  Future<void> _loadCustomCategoriesFromHive() async {
    var categoriesBox = await Hive.openBox(AppConstants.categoriesBox);
    List<CategoryEntity> categories =
        List<CategoryEntity>.from(categoriesBox.values);
    setState(() {
      _customCategories = categories;
    });
  }

  Future<void> _rescheduleTask(
      BuildContext context,
      String formattedDate,
      TaskEntity taskDetails,
      String selectedTaskStartTime,
      String selectedTaskEndTime) async {
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
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FieldItem(
                    label: 'Due Date',
                    widget: GestureDetector(
                      onTap: () async {
                        bool isOverdueTask =
                            taskDetails.status == TaskStatus.overdue;
                        DateTime? pickedDate =
                            await TaskDialogUtils.showCustomDatePickerDialog(
                          context: context,
                          initialDate: DateTime.parse(
                            formattedDate,
                          ),
                          isOverdueTask: isOverdueTask,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            formattedDate =
                                DateTimeUtils.formatDate(pickedDate);
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          hintText: formattedDate,
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
                              String? pickedStartTime = await TaskDialogUtils
                                  .showCustomTimePickerDialog(
                                isStartTime: true,
                                context: context,
                                initialTime: selectedTaskStartTime,
                              );
                              if (pickedStartTime != null) {
                                setState(() {
                                  selectedTaskStartTime = pickedStartTime;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                hintText: selectedTaskStartTime,
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
                              String? pickedEndTime = await TaskDialogUtils
                                  .showCustomTimePickerDialog(
                                isStartTime: false,
                                context: context,
                                initialTime: selectedTaskEndTime,
                              );
                              if (pickedEndTime != null) {
                                setState(() {
                                  selectedTaskEndTime = pickedEndTime;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                hintText: selectedTaskEndTime,
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
                      if (_formKey.currentState!.validate()) {
                        await context.read<TaskCubit>().updateTask(
                              userId: taskDetails.userId,
                              data: {
                                'due_date': formattedDate,
                                'start_time': selectedTaskStartTime,
                                'end_time': selectedTaskEndTime,
                                'status': TaskStatus.inProgress.label,
                              },
                              taskId: taskEntity.id,
                            );

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } else {
                        _autoValidateMode = AutovalidateMode.always;
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
    TaskEntity taskDetails,
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
                    taskId: taskEntity.id,
                    dataPaths: dataPaths,
                  );
              if (!context.mounted) return;
              await context.read<TaskCubit>().deleteSingleTask(
                    userId: taskDetails.userId,
                    taskId: taskEntity.id,
                  );
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.main,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _customAppbarActions(
    TaskEntity taskDetails,
    BuildContext context,
    String formattedDate,
    String selectedTaskStartTime,
    String selectedTaskEndTime,
    List<String> attachmentPaths,
  ) {
    return [
      CustomPopupMenuButton(
        taskEntity: taskDetails,
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        items: [
          if (taskDetails.status != TaskStatus.completed &&
              taskDetails.status != TaskStatus.trash)
            PopupMenuItem(
              value: 0,
              onTap: () async {
                await context.read<TaskCubit>().updateTask(
                      userId: taskDetails.userId,
                      data: {
                        'status': TaskStatus.completed.label,
                      },
                      taskId: taskDetails.id,
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
          if (taskDetails.status != TaskStatus.trash)
            PopupMenuItem(
              value: 1,
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  'editTask',
                  arguments: taskDetails,
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
          if (taskDetails.status == TaskStatus.overdue)
            PopupMenuItem(
              value: 5,
              onTap: () async {
                await _rescheduleTask(
                  context,
                  formattedDate,
                  taskDetails,
                  selectedTaskStartTime,
                  selectedTaskEndTime,
                );
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
          if (taskDetails.status != TaskStatus.trash)
            PopupMenuItem(
              value: 2,
              onTap: () async {
                await context.read<TaskCubit>().updateTask(
                      userId: taskDetails.userId,
                      data: {
                        'status': TaskStatus.trash.label,
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
                  Text('Move to Trash'),
                ],
              ),
            ),
          if (taskDetails.status == TaskStatus.trash)
            PopupMenuItem(
              value: 3,
              onTap: () async {
                await context.read<TaskCubit>().updateTask(
                      userId: taskDetails.userId,
                      data: {
                        'status': TaskStatus.inProgress.label,
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
                  Text('Restore'),
                ],
              ),
            ),
          PopupMenuItem(
            value: 4,
            onTap: () async {
              await _deleteTask(
                context,
                taskDetails,
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: const CircularProgressIndicator(
                color: AppColors.primaryLightColor),
          );
        } else if (state is TaskFailure) {
          return Center(
            child: Text(
              'Failed to load task',
              style:
                  AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
            ),
          );
        } else {
          var tasks = context.watch<TaskCubit>().tasks;
          var taskDetails =
              tasks.firstWhere((task) => task.id == taskEntity.id);

          String selectedTaskStartTime =
              DateTimeUtils.formatTimeTo12Hour(taskDetails.startTime);
          String selectedTaskEndTime =
              DateTimeUtils.formatTimeTo12Hour(taskDetails.endTime);
          String formattedDate = DateTimeUtils.formatDate(taskDetails.dueDate);

          final attachments = context.watch<AttachmentCubit>().attachments;
          List<String> attachmentPaths = attachments
              .where((attachment) => attachment.taskId == taskDetails.id)
              .map((attachment) => attachment.filePath)
              .toList();

          return Padding(
            padding: EdgeInsets.only(
              left: 23,
              right: 23,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomAppbar(
                    title: 'Task Details',
                    actions: _customAppbarActions(
                      taskDetails,
                      context,
                      formattedDate,
                      selectedTaskStartTime,
                      selectedTaskEndTime,
                      attachmentPaths,
                      // attachmentPaths,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TaskBasicInfo(
                    taskDetails: taskDetails,
                    customCategories: _customCategories,
                  ),
                  const SizedBox(height: 20),
                  CustomTabBar(
                    selectedTabIndex: _selectedTabIndex,
                    onTabSelected: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  IndexedStack(
                    index: _selectedTabIndex,
                    alignment: Alignment.center,
                    children: [
                      SubtasksTab(taskDetails: taskDetails),
                      AttachmentsTab(taskDetails: taskDetails),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TaskTimelineInfo(taskDetails: taskDetails),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
