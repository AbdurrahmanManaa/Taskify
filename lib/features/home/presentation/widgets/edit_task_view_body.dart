import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/functions/handle_category_selection.dart';
import 'package:taskify/core/functions/delete_custom_task_categories.dart';
import 'package:taskify/core/functions/show_priority_selection_modal_bottom_sheet.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/schedule_parser.dart';
import 'package:taskify/core/utils/task_dialog_utils.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/views/task_reminder_view.dart';
import 'package:taskify/features/home/presentation/views/task_repeat_view.dart';
import 'package:taskify/generated/l10n.dart';

class EditTaskViewBody extends StatefulWidget {
  const EditTaskViewBody({super.key});

  @override
  State<EditTaskViewBody> createState() => _EditTaskViewBodyState();
}

class _EditTaskViewBodyState extends State<EditTaskViewBody> {
  late final TaskEntity taskEntity;
  late final TextEditingController _taskTitleController;
  late final TextEditingController _taskDescriptionController;
  late final TextEditingController _taskRepeatIntervalController;
  late final TextEditingController _taskRepeatCountController;
  final GlobalKey<FormState> _taskFormKey = GlobalKey();
  AutovalidateMode _taskAutoValidateMode = AutovalidateMode.disabled;
  late TaskReminderEntity _reminderEntity;
  late TaskRepeatEntity _repeatEntity;
  late TaskPriority? _selectedTaskPriority;
  late List<TaskCategoryEntity> _selectedTaskCategories;
  late String? _selectedTaskDueDate;
  late String? _selectedTaskStartTime;
  late String? _selectedTaskEndTime;
  late String? _selectedTaskReminder;
  late String? _selectedTaskRepeat;

  @override
  void initState() {
    super.initState();
    taskEntity = context.read<TaskEntity>();
    _loadTaskDetails();
  }

  void _loadTaskDetails() {
    _taskTitleController = TextEditingController(text: taskEntity.title);
    _taskDescriptionController =
        TextEditingController(text: taskEntity.description);
    _taskRepeatIntervalController = TextEditingController(
      text: '1',
    );
    _taskRepeatCountController = TextEditingController(
      text: '10',
    );
    _reminderEntity = taskEntity.reminder;
    _repeatEntity = taskEntity.repeat;
    _selectedTaskPriority = taskEntity.priority;
    _selectedTaskCategories = taskEntity.categories;
    _selectedTaskDueDate = DateTimeUtils.formatDate(taskEntity.dueDate);
    _selectedTaskStartTime = DateTimeUtils.formatTime(taskEntity.startTime);
    _selectedTaskEndTime = DateTimeUtils.formatTime(taskEntity.endTime);
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    _taskRepeatIntervalController.dispose();
    _taskRepeatCountController.dispose();
    super.dispose();
  }

  Future<void> _updateTask(BuildContext context) async {
    await context.read<TaskCubit>().updateTask(
          userId: taskEntity.userId,
          data: {
            'title': _taskTitleController.text.isEmpty
                ? taskEntity.title
                : _taskTitleController.text,
            'description': _taskDescriptionController.text.isEmpty
                ? taskEntity.description
                : _taskDescriptionController.text,
            'due_date': _selectedTaskDueDate ?? taskEntity.dueDate,
            'start_time': _selectedTaskStartTime ?? taskEntity.startTime,
            'end_time': _selectedTaskEndTime ?? taskEntity.endTime,
            'priority': _selectedTaskPriority!.labelDB,
            'reminder': _reminderEntity,
            'repeat': _repeatEntity,
            'categories': _selectedTaskCategories,
          },
          taskId: taskEntity.id,
        );
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _selectedTaskReminder = ScheduleParser.formatReminder(
      context,
      taskEntity.reminder,
    );
    _selectedTaskRepeat = ScheduleParser.formatRepeat(
      context,
      taskEntity.repeat,
    );
    String selectedTaskPriorityLabel = _selectedTaskPriority!.label(context);
    String taskEntityPriorityLabel = taskEntity.priority.label(context);
    final predefinedCategories = predefinedTaskCategories(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: Form(
        key: _taskFormKey,
        autovalidateMode: _taskAutoValidateMode,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomAppbar(title: S.of(context).editTaskAppBar),
              const SizedBox(height: 20),
              FieldItem(
                label: S.of(context).titleTextField,
                widget: CustomTextFormField(
                  hintText: S.of(context).titleTextFieldHint,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLength: 100,
                  controller: _taskTitleController,
                ),
              ),
              FieldItem(
                label: S.of(context).descriptionTextField,
                widget: CustomTextFormField(
                  hintText: S.of(context).descriptionTextFieldHint,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: _taskDescriptionController,
                  maxLength: 1000,
                  maxLines: 5,
                ),
              ),
              FieldItem(
                label: S.of(context).dueDateTextField,
                widget: GestureDetector(
                  onTap: () async {
                    bool isOverdueTask =
                        taskEntity.status == TaskStatus.overdue;
                    DateTime? pickedDate =
                        await TaskDialogUtils.showCustomDatePickerDialog(
                      context: context,
                      initialDate: DateTime.parse(
                        _selectedTaskDueDate ??
                            DateTimeUtils.formatDate(taskEntity.dueDate),
                      ),
                      isOverdueTask: isOverdueTask,
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
                          DateTimeUtils.formatDate(taskEntity.dueDate),
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FieldItem(
                      label: S.of(context).startTimeTextField,
                      widget: GestureDetector(
                        onTap: () async {
                          String initialTime = _selectedTaskStartTime ??
                              DateTimeUtils.formatTime(taskEntity.startTime);
                          String? pickedStartTime =
                              await TaskDialogUtils.showCustomTimePickerDialog(
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
                                DateTimeUtils.formatTime(taskEntity.startTime),
                            suffixIcon: const Icon(Icons.access_time_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FieldItem(
                      label: S.of(context).endTimeTextField,
                      widget: GestureDetector(
                        onTap: () async {
                          String initialTime = _selectedTaskEndTime ??
                              DateTimeUtils.formatTime(taskEntity.endTime);
                          String? pickedEndTime =
                              await TaskDialogUtils.showCustomTimePickerDialog(
                            isStartTime: false,
                            context: context,
                            initialTime: initialTime,
                            compareWithTime: _selectedTaskStartTime,
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
                                DateTimeUtils.formatTime(taskEntity.endTime),
                            suffixIcon: const Icon(Icons.access_time_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FieldItem(
                label: S.of(context).reminderTextField,
                widget: GestureDetector(
                  onTap: () async {
                    final result = await pushScreenWithoutNavBar(
                      context,
                      TaskReminderView(),
                    );
                    if (result is TaskReminderEntity) {
                      setState(() {
                        _reminderEntity = result;

                        if (result.option == S.of(context).custom) {
                          if (result.value == 0) {
                            _selectedTaskReminder =
                                S.of(context).reminderOption1;
                          } else {
                            _selectedTaskReminder = S
                                .of(context)
                                .selectedTaskReminder(result.value.toString(),
                                    result.unit.toLowerCase());
                          }
                        } else {
                          _selectedTaskReminder = result.option;
                        }
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: _selectedTaskReminder ??
                          ScheduleParser.formatReminder(
                            context,
                            taskEntity.reminder,
                          ),
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              FieldItem(
                label: S.of(context).repeatTextField,
                widget: GestureDetector(
                  onTap: () async {
                    final result = await pushScreenWithoutNavBar(
                      context,
                      TaskRepeatView(),
                    );
                    if (result is TaskRepeatEntity) {
                      setState(() {
                        _repeatEntity = result;
                        _selectedTaskRepeat = ScheduleParser.formatRepeat(
                          context,
                          result,
                        );
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: _selectedTaskRepeat ??
                          ScheduleParser.formatRepeat(
                            context,
                            taskEntity.repeat,
                          ),
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              FieldItem(
                label: S.of(context).priorityTextField,
                widget: GestureDetector(
                  onTap: () async {
                    final selected = await showPrioritySelectionModalSheet(
                      context,
                      _selectedTaskPriority ?? taskEntity.priority,
                    );
                    if (selected != null) {
                      setState(() {
                        _selectedTaskPriority = selected;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: _selectedTaskPriority != null
                          ? selectedTaskPriorityLabel
                          : taskEntityPriorityLabel,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
              ),
              FieldItem(
                label: S.of(context).categoriesLength(
                    _selectedTaskCategories.length.toString()),
                widget: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        ...predefinedCategories.map(
                          (categoryMap) {
                            TaskCategoryEntity category = TaskCategoryEntity(
                              name: categoryMap['name'],
                              icon: categoryMap['icon'],
                              color: categoryMap['color'],
                            );
                            bool isSelected = _selectedTaskCategories
                                .any((c) => c.name == category.name);
                            return FilterChip(
                              showCheckmark: false,
                              backgroundColor:
                                  AppColors.scaffoldLightBackgroundColor,
                              label: Text(category.name),
                              avatar: Icon(
                                category.icon,
                                color: category.color,
                              ),
                              selectedColor: category.color.withAlpha(51),
                              selected: isSelected,
                              onSelected: (bool selected) {
                                setState(() {
                                  handleCategorySelection(
                                    selected: selected,
                                    context: context,
                                    category: category,
                                    selectedCategories: _selectedTaskCategories,
                                  );
                                });
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder<List<TaskCategoryEntity>>(
                          valueListenable: HiveService.categoriesNotifier,
                          builder: (context, customCategories, _) {
                            return Wrap(
                              spacing: 8,
                              children: customCategories.map(
                                (category) {
                                  bool isSelected = _selectedTaskCategories
                                      .any((c) => c.name == category.name);
                                  return GestureDetector(
                                    onLongPress: () async {
                                      await deleteCustomTaskCategory(
                                        context,
                                        category,
                                      );
                                    },
                                    child: FilterChip(
                                      showCheckmark: false,
                                      backgroundColor: AppColors
                                          .scaffoldLightBackgroundColor,
                                      label: Text(category.name),
                                      avatar: Icon(
                                        IconData(
                                          category.icon.codePoint,
                                          fontFamilyFallback: ['MaterialIcons'],
                                        ),
                                        color: Color(
                                          category.color.toARGB32(),
                                        ),
                                      ),
                                      selectedColor:
                                          category.color.withAlpha(51),
                                      selected: isSelected,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          handleCategorySelection(
                                            selected: selected,
                                            context: context,
                                            category: category,
                                            selectedCategories:
                                                _selectedTaskCategories,
                                          );
                                        });
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                        ChoiceChip(
                          backgroundColor:
                              AppColors.scaffoldLightBackgroundColor,
                          label: Text(S.of(context).addCategoryLabel),
                          avatar: const Icon(Icons.add, color: Colors.grey),
                          selected: false,
                          onSelected: (_) async {
                            if (_selectedTaskCategories.length >= 3) {
                              buildSnackbar(
                                context,
                                message:
                                    'You can select up to 3 categories only',
                              );
                              return;
                            }
                            TaskCategoryEntity? newCategory =
                                await TaskDialogUtils.showCustomCategoryDialog(
                                    context);
                            if (newCategory != null) {
                              await HiveService()
                                  .addCustomCategory(newCategory);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.regular14
                              .copyWith(color: AppColors.bodyTextColor),
                          children: [
                            TextSpan(
                              text: S.of(context).maximumCategoryLimit,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '3.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              BlocListener<TaskCubit, TaskState>(
                listener: (context, state) {
                  if (state is TaskAdded) {
                    buildSnackbar(context,
                        message: 'Task updated successfully!');
                  } else if (state is TaskFailure) {
                    buildSnackbar(context, message: 'Failed to update task!');
                  }
                },
                child: CustomButton(
                  title: S.of(context).editTaskAppBar,
                  onPressed: () async {
                    if (_taskFormKey.currentState!.validate()) {
                      await _updateTask(context);
                    } else {
                      _taskAutoValidateMode = AutovalidateMode.always;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
