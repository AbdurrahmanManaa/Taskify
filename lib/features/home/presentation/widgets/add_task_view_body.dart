import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/file_manager.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/schedule_parser.dart';
import 'package:taskify/core/utils/task_dialog_utils.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_progress_hud.dart';
import 'package:taskify/core/widgets/custom_text_form_field.dart';
import 'package:taskify/core/widgets/field_item.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/category_entity.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task_repeat_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:path/path.dart' as p;
import 'package:taskify/features/home/presentation/widgets/attachment_item.dart';
import 'package:taskify/features/home/presentation/widgets/subtask_item.dart';
import 'package:uuid/uuid.dart';

class AddTaskViewBody extends StatefulWidget {
  const AddTaskViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<AddTaskViewBody> createState() => _AddTaskViewBodyState();
}

class _AddTaskViewBodyState extends State<AddTaskViewBody> {
  String _selectedTaskDate = DateFormat('yyyy-MM-dd').format(
    DateTime.now(),
  );
  String _selectedTaskStartTime = DateFormat('hh:mm a').format(
    DateTime.now(),
  );
  String _selectedTaskEndTime = '9:30 AM';
  String _selectedTaskReminder = '10 mins before';
  String _selectedTaskRepeat = 'Don\'t repeat';
  String _selectedTaskPriority = 'Medium';
  TaskReminderEntity _reminderEntity = TaskReminderEntity(
    option: '10 mins before',
    value: 0,
    unit: 'Minutes',
  );
  TaskRepeatEntity _repeatEntity = TaskRepeatEntity(
    interval: 1,
    option: 'Don\'t repeat',
    duration: 'Forever',
    count: 0,
    weekDays: [],
    untilDate: null,
  );
  late final TextEditingController _taskTitleController;
  late final TextEditingController _taskDescriptionController;
  late final TextEditingController _subtaskTitleController;
  late final TextEditingController _subtaskNoteController;
  late final TextEditingController _taskRepeatIntervalController;
  late final TextEditingController _taskRepeatCountController;
  List<CategoryEntity> _selectedTaskCategories = [
    CategoryEntity.defaultCategory(),
  ];
  final List<SubtaskEntity> _subtasks = [];
  final List<AttachmentEntity> _attachments = [];
  final List<File> _pickedFiles = [];
  final GlobalKey<FormState> _taskFormKey = GlobalKey();
  final GlobalKey<FormState> _subtaskFormKey = GlobalKey();
  AutovalidateMode _taskAutoValidateMode = AutovalidateMode.disabled;
  AutovalidateMode _subtaskAutoValidateMode = AutovalidateMode.disabled;
  final uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _taskTitleController = TextEditingController();
    _taskDescriptionController = TextEditingController();
    _subtaskTitleController = TextEditingController();
    _subtaskNoteController = TextEditingController();
    _taskRepeatIntervalController = TextEditingController(
      text: '1',
    );
    _taskRepeatCountController = TextEditingController(
      text: '10',
    );
    _initializeCategories();
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    _subtaskTitleController.dispose();
    _subtaskNoteController.dispose();
    _taskRepeatIntervalController.dispose();
    _taskRepeatCountController.dispose();
    super.dispose();
  }

  void _updateAttachments(List<File> pickedFiles) async {
    for (var file in pickedFiles) {
      final stat = await file.stat();
      final fileName = p.basename(file.path);
      final fileType = FileUtils.getFileType(fileName);

      final attachment = AttachmentEntity(
        id: '',
        taskId: '',
        fileName: fileName,
        fileType: fileType,
        fileSize: stat.size,
        filePath: file.path,
      );

      setState(() {
        _pickedFiles.add(file);
        _attachments.add(attachment);
      });
    }
  }

  _prioritySelection(BuildContext context) {
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
              ...List.generate(priorities.length, (index) {
                final e = priorities[index];
                final isLast = index == priorities.length - 1;
                final isSelected = e == _selectedTaskPriority;

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        e.toString(),
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

  Future<void> _initializeCategories() async {
    await HiveService.initializeCategories();
    setState(() {});
  }

  void _predefinedCategoriesActions(
      bool selected, BuildContext context, CategoryEntity category) {
    setState(() {
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
        _selectedTaskCategories.removeWhere((c) => c.name == 'Uncategorized');
      } else {
        _selectedTaskCategories.removeWhere((c) => c.name == category.name);
      }
      if (_selectedTaskCategories.isEmpty) {
        _selectedTaskCategories.add(CategoryEntity.defaultCategory());
      }
    });
  }

  Future<void> _deleteCustomTaskCategory(
      BuildContext context, CategoryEntity category) async {
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _customCategoriesActions(
      bool selected, BuildContext context, CategoryEntity category) {
    setState(() {
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
        _selectedTaskCategories.removeWhere((c) => c.name == 'Uncategorized');
      } else {
        _selectedTaskCategories.removeWhere((c) => c.name == category.name);
      }
      if (_selectedTaskCategories.isEmpty) {
        _selectedTaskCategories.add(CategoryEntity.defaultCategory());
      }
    });
  }

  Future<void> _createSubtask(BuildContext context) async {
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
            key: _subtaskFormKey,
            autovalidateMode: _subtaskAutoValidateMode,
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
                      controller: _subtaskTitleController,
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
                      controller: _subtaskNoteController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_subtaskFormKey.currentState!.validate()) {
                        var subtask = SubtaskEntity(
                          id: '',
                          taskId: '',
                          title: _subtaskTitleController.text,
                          note: _subtaskNoteController.text,
                        );
                        setState(() {
                          _subtasks.add(subtask);
                        });
                        _subtaskTitleController.clear();
                        _subtaskNoteController.clear();
                        Navigator.pop(context);
                      } else {
                        _subtaskAutoValidateMode = AutovalidateMode.always;
                      }
                    },
                    child: Text(
                      'Create Subtask',
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

  Future<void> _updateSubtask(BuildContext context, int index) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        _subtaskTitleController.text = _subtasks[index].title;
        _subtaskNoteController.text = _subtasks[index].note ?? '';
        return Padding(
          padding: EdgeInsets.only(
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Form(
            key: _subtaskFormKey,
            autovalidateMode: _subtaskAutoValidateMode,
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
                      controller: _subtaskTitleController,
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
                      controller: _subtaskNoteController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_subtaskFormKey.currentState!.validate()) {
                        setState(() {
                          _subtasks[index] = _subtasks[index].copyWith(
                            title: _subtaskTitleController.text,
                            note: _subtaskNoteController.text.isNotEmpty
                                ? _subtaskNoteController.text
                                : null,
                          );
                        });
                        Navigator.pop(context);
                      } else {
                        _subtaskAutoValidateMode = AutovalidateMode.always;
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

  Future<void> _addTask(
      BuildContext context, String taskId, String userId) async {
    await context.read<TaskCubit>().addTask(
          taskEntity: TaskEntity(
            id: taskId,
            userId: userId,
            title: _taskTitleController.text,
            description: _taskDescriptionController.text,
            dueDate: DateFormat('yyyy-MM-dd').parse(_selectedTaskDate),
            startTime: _selectedTaskStartTime,
            endTime: _selectedTaskEndTime,
            priority: _selectedTaskPriority,
            reminder: _reminderEntity,
            repeat: _repeatEntity,
            categories: _selectedTaskCategories,
          ),
        );
  }

  Future<void> _addSubtask(
      String subtaskId, String taskId, BuildContext context) async {
    if (_subtasks.isNotEmpty) {
      final updatedSubtasks = _subtasks.map((subTask) {
        return subTask.copyWith(
          id: subtaskId,
          taskId: taskId,
        );
      }).toList();
      await context.read<SubtaskCubit>().addSubTask(
            subtaskEntities: updatedSubtasks,
            taskId: taskId,
          );
    }
  }

  Future<void> _addAttachments(
      BuildContext context, String taskId, String userId) async {
    if (_attachments.isNotEmpty) {
      await context.read<AttachmentCubit>().addAttachment(
            files: _pickedFiles,
            baseEntities: _attachments,
            taskId: taskId,
            userId: userId,
          );
    }
  }

  void _resetFields() {
    return setState(() {
      _taskTitleController.clear();
      _taskDescriptionController.clear();
      _taskRepeatIntervalController.clear();
      _selectedTaskDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _selectedTaskStartTime = DateFormat('hh:mm a').format(DateTime.now());
      _selectedTaskEndTime = '9:30 AM';
      _selectedTaskReminder = '10 mins before';
      _selectedTaskRepeat = 'Don\'t repeat';
      _selectedTaskPriority = 'Medium';
      _selectedTaskCategories = [CategoryEntity.defaultCategory()];
      _attachments.clear();
      _subtasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollController>(context);

    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskAdded) {
          buildSnackbar(context, message: 'Task added successfully!');
        } else if (state is TaskFailure) {
          buildSnackbar(context, message: 'Failed to add task!');
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is TaskLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: Form(
              key: _taskFormKey,
              autovalidateMode: _taskAutoValidateMode,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomAppbar(
                      title: 'Add Task',
                      showBackButton: false,
                    ),
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
                          DateTime? pickedDate =
                              await TaskDialogUtils.showCustomDatePickerDialog(
                                  context: context);
                          if (pickedDate != null) {
                            setState(() {
                              _selectedTaskDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            hintText: _selectedTaskDate,
                            suffixIcon:
                                const Icon(Icons.calendar_today_outlined),
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
                                  initialTime: DateFormat('hh:mm a').format(
                                    DateTime.now(),
                                  ),
                                );
                                if (pickedStartTime != null) {
                                  setState(() {
                                    _selectedTaskStartTime = pickedStartTime;
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: CustomTextFormField(
                                  hintText: _selectedTaskStartTime,
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
                                  initialTime: _selectedTaskEndTime,
                                );
                                if (pickedEndTime != null) {
                                  setState(() {
                                    _selectedTaskEndTime = pickedEndTime;
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: CustomTextFormField(
                                  hintText: _selectedTaskEndTime,
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
                    FieldItem(
                      label: 'Reminder',
                      widget: GestureDetector(
                        onTap: () async {
                          final result =
                              await Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                            AppRoutes.taskReminder,
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
                            hintText: _selectedTaskReminder,
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
                          final result =
                              await Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                            AppRoutes.taskRepeat,
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
                            hintText: _selectedTaskRepeat,
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
                            hintText: _selectedTaskPriority,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FieldItem(
                      label: 'Categories (${_selectedTaskCategories.length})',
                      widget: Column(
                        children: [
                          Wrap(
                            spacing: 8.0,
                            children: [
                              ...predefinedCategories.map(
                                (categoryMap) {
                                  CategoryEntity category = CategoryEntity(
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
                                    selectedColor:
                                        category.color.withOpacity(0.2),
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
                              ValueListenableBuilder<List<CategoryEntity>>(
                                valueListenable: HiveService.categoriesNotifier,
                                builder: (context, customCategories, child) {
                                  return Wrap(
                                    spacing: 8.0,
                                    children: customCategories.map(
                                      (category) {
                                        bool isSelected =
                                            _selectedTaskCategories.any(
                                                (c) => c.name == category.name);
                                        return GestureDetector(
                                          onLongPress: () async {
                                            await _deleteCustomTaskCategory(
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
                                                fontFamilyFallback: [
                                                  'MaterialIcons',
                                                  'CupertinoIcons'
                                                ],
                                              ),
                                              color: Color(
                                                category.color.toARGB32(),
                                              ),
                                            ),
                                            selectedColor:
                                                category.color.withOpacity(0.2),
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
                                    ).toList(),
                                  );
                                },
                              ),
                              ChoiceChip(
                                backgroundColor:
                                    AppColors.scaffoldLightBackgroundColor,
                                label: const Text('Add Category'),
                                avatar: const Icon(Icons.add,
                                    color: AppColors.greyColor),
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
                                  CategoryEntity? newCategory =
                                      await TaskDialogUtils
                                          .showCustomCategoryDialog(context);
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
                                    text: 'Maximum category limit: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                    const SizedBox(height: 20),
                    FieldItem(
                      label: 'Attachments (${_attachments.length})',
                      widget: GestureDetector(
                        onTap: () async {
                          await pickFilesAndValidate(
                            context,
                            (pickedFiles) => _updateAttachments(pickedFiles),
                            fileType: FileType.custom,
                            allowedFileExtensions: allAllowedExtensions,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xfff8f9fb),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                ),
                              ),
                              child: const Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      size: 40,
                                      color: AppColors.greyColor,
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'Upload Files',
                                      style: AppTextStyles.regular18,
                                    ),
                                  ],
                                ),
                              ),
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
                                      text: 'Upload file size limit: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: '50MB.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _attachments.isNotEmpty
                        ? ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _attachments.length,
                            itemBuilder: (context, index) {
                              var attachment = _attachments[index];
                              var fileExtension =
                                  p.extension(attachment.fileName);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: AttachmentItem(
                                  fileName: attachment.fileName,
                                  fileExtension: fileExtension,
                                  fileSize: FileUtils.formatFileSize(
                                      attachment.fileSize),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _attachments.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    FieldItem(
                      label: 'Subtasks (${_subtasks.length})',
                      widget: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xfff8f9fb),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: AppColors.borderColor,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await _createSubtask(context);
                              },
                              child: Center(
                                child: Text(
                                  'Add Subtask',
                                  style: AppTextStyles.regular14
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          _subtasks.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _subtasks.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: SubtaskItem(
                                        subtaskEntity: _subtasks[index],
                                        trailing: CustomPopupMenuButton(
                                          subtaskEntity: _subtasks[index],
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.black,
                                          ),
                                          items: [
                                            PopupMenuItem(
                                              value: 0,
                                              onTap: () async {
                                                await _updateSubtask(
                                                  context,
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
                                              onTap: () {
                                                setState(() {
                                                  _subtasks.removeAt(index);
                                                });
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
                                      ),
                                      // child: SubtaskItem(),
                                    );
                                  },
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      title: 'Create Task',
                      onPressed: () async {
                        if (_taskFormKey.currentState!.validate()) {
                          if (widget.supabase.auth.currentUser != null) {
                            final userId = widget.supabase.auth.currentUser!.id;
                            final taskId = uuid.v4();
                            final subtaskId = uuid.v4();

                            try {
                              await _addTask(
                                context,
                                taskId,
                                userId,
                              );

                              await _addAttachments(
                                context,
                                taskId,
                                userId,
                              );

                              await _addSubtask(
                                subtaskId,
                                taskId,
                                context,
                              );

                              _resetFields();
                            } catch (e) {
                              log(
                                e.toString(),
                              );
                            }
                          }
                        } else {
                          _taskAutoValidateMode = AutovalidateMode.always;
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
