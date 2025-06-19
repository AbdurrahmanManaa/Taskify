import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/functions/custom_task_actions.dart';
import 'package:taskify/core/functions/delete_task.dart';
import 'package:taskify/core/functions/reschedule_task.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/attachments_tab.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:taskify/features/home/presentation/widgets/subtasks_tab.dart';
import 'package:taskify/features/home/presentation/widgets/task_basic_info.dart';
import 'package:taskify/features/home/presentation/widgets/task_timeline_info.dart';
import 'package:taskify/generated/l10n.dart';

class TaskDetailsViewBody extends StatefulWidget {
  const TaskDetailsViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<TaskDetailsViewBody> createState() => _TaskDetailsViewBodyState();
}

class _TaskDetailsViewBodyState extends State<TaskDetailsViewBody> {
  late final TaskEntity taskEntity;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    taskEntity = context.read<TaskEntity>();
    getTasks();
    getSubtasks();
    getAttachments();
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskFailure) {
          return Center(
            child: Text(
              'Failed to load task',
              style:
                  AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
            ),
          );
        } else {
          String selectedTaskStartTime =
              DateTimeUtils.formatTimeTo12Hour(taskEntity.startTime);
          String selectedTaskEndTime =
              DateTimeUtils.formatTimeTo12Hour(taskEntity.endTime);
          String formattedDate = DateTimeUtils.formatDate(taskEntity.dueDate);

          final attachments = context.watch<AttachmentCubit>().attachments;
          List<String> attachmentPaths = attachments
              .where((attachment) => attachment.taskId == taskEntity.id)
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
                    title: S.of(context).taskDetails,
                    actions: [
                      customTaskActions(
                        context,
                        taskEntity,
                        () async {
                          await rescheduleTask(
                            context,
                            formattedDate,
                            taskEntity,
                            {
                              'due_date': formattedDate,
                              'start_time': selectedTaskStartTime,
                              'end_time': selectedTaskEndTime,
                              'status': TaskStatus.inProgress.labelDB,
                            },
                            selectedTaskStartTime,
                            selectedTaskEndTime,
                            (pickedDate) {
                              setState(() {
                                formattedDate = pickedDate;
                              });
                            },
                            (pickedStartTime) {
                              setState(() {
                                selectedTaskStartTime = pickedStartTime;
                              });
                            },
                            (pickedEndTime) {
                              setState(() {
                                selectedTaskEndTime = pickedEndTime;
                              });
                            },
                          );
                        },
                        () async {
                          await deleteTask(
                            context,
                            taskEntity.userId,
                            taskEntity.id,
                            attachmentPaths,
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TaskBasicInfo(taskDetails: taskEntity),
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
                      SubtasksTab(taskDetails: taskEntity),
                      AttachmentsTab(taskDetails: taskEntity),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TaskTimelineInfo(taskDetails: taskEntity),
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
