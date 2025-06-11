import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
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
  late List<TaskCategoryEntity> _customCategories = [];

  @override
  void initState() {
    super.initState();
    taskEntity = context.read<TaskEntity>();
    _loadTaskDetails();
    _loadCustomCategoriesFromHive();
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
    _selectedTaskReminder = ScheduleParser.formatReminder(taskEntity.reminder);
    _selectedTaskRepeat = ScheduleParser.formatRepeat(taskEntity.repeat);
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
            'priority': (_selectedTaskPriority ?? taskEntity.priority).label,
            'reminder': _reminderEntity,
            'repeat': _repeatEntity,
            'categories': _selectedTaskCategories,
          },
          taskId: taskEntity.id,
        );

    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future _prioritySelection(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Priority',
                style: AppTextStyles.medium24.copyWith(
                  color: AppColors.primaryLightColor,
                ),
              ),
              Divider(),
              ...List.generate(TaskPriority.values.length, (index) {
                final e = TaskPriority.values[index];
                final isLast = index == TaskPriority.values.length - 1;
                final isSelected = e == _selectedTaskPriority;

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        e.label,
                        style: AppTextStyles.medium18,
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check,
                              color: AppColors.primaryLightColor)
                          : null,
                      onTap: () {
                        Navigator.pop(context, e);
                      },
                    ),
                    if (!isLast) Divider(),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Future<void> _loadCustomCategoriesFromHive() async {
    var categoriesBox = await Hive.openBox(AppConstants.categoriesBox);
    List<TaskCategoryEntity> categories =
        List<TaskCategoryEntity>.from(categoriesBox.values);
    setState(() {
      _customCategories = categories;
    });
  }

  void _handleAddCustomCategory(TaskCategoryEntity category) async {
    bool alreadyExists = _customCategories.any(
      (c) =>
          c.name == category.name &&
          c.icon.codePoint == category.icon.codePoint,
    );
    if (alreadyExists) {
      return;
    }

    setState(() {
      _customCategories.add(category);
      if (!_selectedTaskCategories.contains(category)) {
        _selectedTaskCategories.add(category);
      }
    });

    await HiveService().addCustomCategory(category);
  }

  void _predefinedCategoriesActions(
      bool selected, BuildContext context, TaskCategoryEntity category) {
    setState(
      () {
        if (selected) {
          if (_selectedTaskCategories.length >= 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You can select up to 3 categories only.'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
          if (!_selectedTaskCategories.any((c) => c.name == category.name)) {
            _selectedTaskCategories.add(category);
          }
        } else {
          _selectedTaskCategories.removeWhere((c) => c.name == category.name);
        }
      },
    );
  }

  Future<void> _deleteCustomTaskCategory(
      BuildContext context, TaskCategoryEntity category) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldLightBackgroundColor,
        title: const Text('Delete Category Permanently'),
        content: const Text(
            'Are you sure you want to delete this Category permanently?'),
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
              await HiveService().deleteCategory(category.name);
              setState(() {
                _customCategories.remove(category);
                _selectedTaskCategories
                    .removeWhere((c) => c.name == category.name);
              });

              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _customCategoriesActions(
      bool selected, BuildContext context, TaskCategoryEntity category) {
    setState(
      () {
        if (selected) {
          if (_selectedTaskCategories.length >= 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You can select up to 3 categories only.'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
          if (!_selectedTaskCategories.any((c) => c.name == category.name)) {
            _selectedTaskCategories.add(category);
          }
        } else {
          _selectedTaskCategories.removeWhere((c) => c.name == category.name);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: Form(
        key: _taskFormKey,
        autovalidateMode: _taskAutoValidateMode,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomAppbar(title: 'Edit Task'),
              const SizedBox(height: 20),
              FieldItem(
                label: 'Title',
                widget: CustomTextFormField(
                  hintText: 'Enter title',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLength: 100,
                  controller: _taskTitleController,
                ),
              ),
              FieldItem(
                label: 'Description',
                widget: CustomTextFormField(
                  hintText: 'Enter Description ',
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: _taskDescriptionController,
                  maxLength: 1000,
                  maxLines: 5,
                ),
              ),
              FieldItem(
                label: 'Due Date',
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
                      label: 'Start Time',
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
                      label: 'End Time',
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
                label: 'Reminder',
                widget: GestureDetector(
                  onTap: () async {
                    final result = await pushScreenWithoutNavBar(
                      context,
                      TaskReminderView(),
                    );
                    if (result is TaskReminderEntity) {
                      setState(() {
                        _reminderEntity = result;

                        if (result.option == 'Custom') {
                          if (result.value == 0) {
                            _selectedTaskReminder = 'At time of event';
                          } else {
                            _selectedTaskReminder =
                                '${result.value} ${result.unit.toLowerCase()} before';
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
                          ScheduleParser.formatReminder(taskEntity.reminder),
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              FieldItem(
                label: 'Repeat',
                widget: GestureDetector(
                  onTap: () async {
                    final result = await pushScreenWithoutNavBar(
                      context,
                      TaskRepeatView(),
                    );
                    if (result is TaskRepeatEntity) {
                      setState(() {
                        _repeatEntity = result;
                        _selectedTaskRepeat =
                            ScheduleParser.formatRepeat(result);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: _selectedTaskRepeat ??
                          ScheduleParser.formatRepeat(taskEntity.repeat),
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              FieldItem(
                label: 'Priority',
                widget: GestureDetector(
                  onTap: () async {
                    final selected = await _prioritySelection(context);
                    if (selected != null) {
                      setState(() {
                        _selectedTaskPriority = selected;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      hintText: _selectedTaskPriority != null
                          ? _selectedTaskPriority!.label
                          : taskEntity.priority.label,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
              ),
              FieldItem(
                label: 'Categories (${_selectedTaskCategories.length})',
                widget: Column(
                  children: [
                    Wrap(
                      spacing: 8.0,
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
                                _predefinedCategoriesActions(
                                  selected,
                                  context,
                                  category,
                                );
                              },
                            );
                          },
                        ),
                        ..._customCategories.map(
                          (category) {
                            bool isSelected = _selectedTaskCategories
                                .any((c) => c.name == category.name);
                            return GestureDetector(
                              onLongPress: () async {
                                await _deleteCustomTaskCategory(
                                  context,
                                  category,
                                );
                              },
                              child: FilterChip(
                                showCheckmark: false,
                                backgroundColor:
                                    AppColors.scaffoldLightBackgroundColor,
                                label: Text(
                                  category.name,
                                ),
                                avatar: Icon(
                                  IconData(
                                    category.icon.codePoint,
                                    fontFamilyFallback: [
                                      'MaterialIcons',
                                      'CupertinoIcons'
                                    ],
                                  ),
                                  color: Color(category.color.toARGB32()),
                                ),
                                selectedColor: category.color.withAlpha(51),
                                selected: isSelected,
                                onSelected: (bool selected) {
                                  _customCategoriesActions(
                                    selected,
                                    context,
                                    category,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ChoiceChip(
                          backgroundColor:
                              AppColors.scaffoldLightBackgroundColor,
                          label: const Text('Add Category'),
                          avatar: const Icon(Icons.add, color: Colors.grey),
                          selected: false,
                          onSelected: (_) async {
                            if (_selectedTaskCategories.length >= 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'You can select up to 3 categories only.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }
                            TaskCategoryEntity? newCategory =
                                await TaskDialogUtils.showCustomCategoryDialog(
                                    context);
                            if (newCategory != null) {
                              _handleAddCustomCategory(newCategory);
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
                              text: 'Maximum category limit: ',
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
                  title: 'Edit Task',
                  onPressed: () async {
                    if (_taskFormKey.currentState!.validate()) {
                      await _updateTask(context);
                    } else {
                      _taskAutoValidateMode = AutovalidateMode.always;
                    }
                  },
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
