import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/core/extensions/subtask_status_extension.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/auth/presentation/widgets/custom_check.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/subtask_item.dart';
import 'package:taskify/features/home/presentation/widgets/subtasks_completion_progress.dart';
import 'package:uuid/uuid.dart';

class SubtasksTab extends StatefulWidget {
  const SubtasksTab({super.key, required this.taskDetails});
  final TaskEntity taskDetails;

  @override
  State<SubtasksTab> createState() => _SubtasksTabState();
}

class _SubtasksTabState extends State<SubtasksTab> {
  final uuid = Uuid();
  late final TextEditingController _titleController;
  late final TextEditingController _noteController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  GestureDetector _addNewSubtask(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
          backgroundColor: AppColors.scaffoldLightBackgroundColor,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                left: 23,
                right: 23,
                bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FieldItem(
                        label: 'Title',
                        widget: CustomTextFormField(
                          hintText: 'Enter title',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 100,
                          controller: _titleController,
                        ),
                      ),
                      FieldItem(
                        label: 'Note',
                        widget: CustomTextFormField(
                          hintText: 'Enter note',
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          maxLength: 500,
                          maxLines: 5,
                          controller: _noteController,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final newSubtask = SubtaskEntity(
                              id: uuid.v4(),
                              taskId: widget.taskDetails.id,
                              title: _titleController.text,
                              note: _noteController.text,
                              status: SubtaskStatus.inProgress,
                            );

                            await context.read<SubtaskCubit>().addNewSubtask(
                              taskId: widget.taskDetails.id,
                              subtaskEntities: [newSubtask],
                            );

                            _titleController.clear();
                            _noteController.clear();

                            if (!context.mounted) return;
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              _autoValidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        child: Text(
                          'Create Subtask',
                          style: AppTextStyles.medium20
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xfff8f9fb),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: AppColors.borderColor,
          ),
        ),
        child: Center(
          child: Text(
            'Add Subtask',
            style:
                AppTextStyles.regular14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Future<void> _markAsCompleted(BuildContext context, bool value,
      List<SubtaskEntity> taskSubtasks, int index) async {
    await context.read<SubtaskCubit>().updateSubtask(
      taskId: widget.taskDetails.id,
      subtaskId: taskSubtasks[index].id,
      data: {
        'status': value
            ? SubtaskStatus.completed.label
            : SubtaskStatus.inProgress.label,
      },
    );
  }

  Future<void> _editSubtask(
      BuildContext context, List<SubtaskEntity> taskSubtasks, int index) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        _titleController.text = taskSubtasks[index].title;
        _noteController.text = taskSubtasks[index].note ?? '';
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FieldItem(
                    label: 'Title',
                    widget: CustomTextFormField(
                      hintText: 'Enter title',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLength: 100,
                      controller: _titleController,
                    ),
                  ),
                  FieldItem(
                    label: 'Note',
                    widget: CustomTextFormField(
                      hintText: 'Enter note',
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      maxLength: 500,
                      maxLines: 5,
                      controller: _noteController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<SubtaskCubit>().updateSubtask(
                          taskId: widget.taskDetails.id,
                          subtaskId: taskSubtasks[index].id,
                          data: {
                            'title': _titleController.text,
                            'note': _noteController.text,
                          },
                        );
                        _titleController.clear();
                        _noteController.clear();

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _autoValidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    child: Text(
                      'Update Subtask',
                      style:
                          AppTextStyles.medium20.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteSubtask(
      BuildContext context, List<SubtaskEntity> taskSubtasks, int index) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text('Delete Subtask'),
        content: const Text('Are you sure you want to delete this subtask?'),
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
              await context.read<SubtaskCubit>().deleteSingleSubtask(
                    subtaskId: taskSubtasks[index].id,
                    taskId: taskSubtasks[index].taskId,
                  );

              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Skeletonizer _subtasksPlaceholder() {
    return Skeletonizer(
      enabled: true,
      containersColor: AppColors.inputDecorationLightFillColor,
      child: FieldItem(
        label: 'Todo List',
        widget: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SubtaskItem(
                subtaskEntity: SubtaskEntity(
                  id: '',
                  taskId: '',
                  title: '',
                  status: SubtaskStatus.inProgress,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskCubit, SubtaskState>(
      builder: (context, state) {
        if (state is SubtaskLoading) {
          return _subtasksPlaceholder();
        } else if (state is SubtaskFailure) {
          return Center(
            child: Text(
              'Failed to load subtasks',
              style:
                  AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
            ),
          );
        } else {
          var subtasks = context.watch<SubtaskCubit>().subtasks;
          var taskSubtasks = subtasks
              .where((subtask) => subtask.taskId == widget.taskDetails.id)
              .toList();
          var completedSubtasks = taskSubtasks
              .where((subtask) => subtask.status == SubtaskStatus.completed)
              .toList();
          if (taskSubtasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _addNewSubtask(context),
            );
          }
          return Column(
            children: [
              const SizedBox(height: 10),
              SubtasksCompletionProgress(
                subtasks: taskSubtasks,
                completedSubtasks: completedSubtasks,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: taskSubtasks.length + 1,
                itemBuilder: (context, index) {
                  if (index == taskSubtasks.length) {
                    return _addNewSubtask(context);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SubtaskItem(
                      leading: CustomCheck(
                        isChecked: taskSubtasks[index].status ==
                            SubtaskStatus.completed,
                        onChecked: (value) async {
                          await _markAsCompleted(
                            context,
                            value,
                            taskSubtasks,
                            index,
                          );
                        },
                      ),
                      trailing: CustomPopupMenuButton(
                        subtaskEntity: taskSubtasks[index],
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                        items: [
                          PopupMenuItem(
                            value: 0,
                            onTap: () async {
                              await _editSubtask(
                                context,
                                taskSubtasks,
                                index,
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
                            value: 1,
                            onTap: () async {
                              await _deleteSubtask(
                                context,
                                taskSubtasks,
                                index,
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
                      subtaskEntity: SubtaskEntity(
                        id: taskSubtasks[index].id,
                        taskId: taskSubtasks[index].taskId,
                        title: taskSubtasks[index].title,
                        note: taskSubtasks[index].note,
                        status: taskSubtasks[index].status,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
