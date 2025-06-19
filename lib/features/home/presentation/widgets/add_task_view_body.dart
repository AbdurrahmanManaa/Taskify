import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/functions/delete_custom_task_categories.dart';
import 'package:taskify/core/functions/handle_category_selection.dart';
import 'package:taskify/core/functions/show_priority_selection_modal_bottom_sheet.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
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
import 'package:taskify/features/home/domain/entities/attachment/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/attachment/attachment_status.dart';
import 'package:taskify/features/home/domain/entities/preferences/app_language.dart';
import 'package:taskify/features/home/domain/entities/subtask/subtask_status.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/subtask/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:path/path.dart' as p;
import 'package:taskify/features/home/presentation/views/task_reminder_view.dart';
import 'package:taskify/features/home/presentation/views/task_repeat_view.dart';
import 'package:taskify/features/home/presentation/widgets/attachment_item.dart';
import 'package:taskify/features/home/presentation/widgets/subtask_item.dart';
import 'package:taskify/generated/l10n.dart';
import 'package:uuid/uuid.dart';

class AddTaskViewBody extends StatefulWidget {
  const AddTaskViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<AddTaskViewBody> createState() => _AddTaskViewBodyState();
}

class _AddTaskViewBodyState extends State<AddTaskViewBody> {
  String _selectedTaskDate = DateTimeUtils.formatDate(DateTime.now());
  String _selectedTaskStartTime = DateTimeUtils.formatTime(DateTime.now());
  String _selectedTaskEndTime =
      DateTimeUtils.formatTime(DateTime.now().add(Duration(minutes: 30)));
  late String _selectedTaskReminder;
  late String _selectedTaskRepeat;
  TaskPriority _selectedTaskPriority = TaskPriority.medium;
  late TaskReminderEntity _reminderEntity;
  late TaskRepeatEntity _repeatEntity;
  late final TextEditingController _taskTitleController;
  late final TextEditingController _taskDescriptionController;
  late final TextEditingController _subtaskTitleController;
  late final TextEditingController _subtaskNoteController;
  late final TextEditingController _taskRepeatIntervalController;
  late final TextEditingController _taskRepeatCountController;
  List<TaskCategoryEntity> _selectedTaskCategories = [];
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
        status: AttachmentStatus.pending,
      );

      setState(() {
        _pickedFiles.add(file);
        _attachments.add(attachment);
      });
    }
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
                    label: S.of(context).titleTextField,
                    widget: CustomTextFormField(
                      hintText: S.of(context).titleTextFieldHint,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLength: 100,
                      controller: _subtaskTitleController,
                    ),
                  ),
                  FieldItem(
                    label: S.of(context).noteTextField,
                    widget: CustomTextFormField(
                      hintText: S.of(context).noteTextFieldHint,
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
                          status: SubtaskStatus.inProgress,
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
                      S.of(context).createSubtaskButton,
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
                    label: S.of(context).titleTextField,
                    widget: CustomTextFormField(
                      hintText: S.of(context).titleTextFieldHint,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLength: 100,
                      controller: _subtaskTitleController,
                    ),
                  ),
                  FieldItem(
                    label: S.of(context).noteTextField,
                    widget: CustomTextFormField(
                      hintText: S.of(context).noteTextFieldHint,
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
                      S.of(context).updateSubtaskButton,
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
    DateTime baseDate = DateTimeUtils.parseDate(_selectedTaskDate);
    DateTime parsedStartTime = DateTimeUtils.parseTime(_selectedTaskStartTime);
    DateTime parsedEndTime = DateTimeUtils.parseTime(_selectedTaskEndTime);
    final startDateTime =
        DateTimeUtils.mergeDateAndTime(baseDate, parsedStartTime);
    final endDateTime = DateTimeUtils.mergeDateAndTime(baseDate, parsedEndTime);

    await context.read<TaskCubit>().addTask(
          taskEntity: TaskEntity(
            id: taskId,
            userId: userId,
            title: _taskTitleController.text,
            description: _taskDescriptionController.text,
            dueDate: baseDate,
            startTime: startDateTime,
            endTime: endDateTime,
            status: TaskStatus.inProgress,
            priority: _selectedTaskPriority,
            reminder: _reminderEntity,
            repeat: _repeatEntity,
            categories: _selectedTaskCategories,
            attachmentsCount: _attachments.length,
            subtaskCount: _subtasks.length,
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
      _taskRepeatCountController.clear();
      _selectedTaskDate =
          DateTimeUtils.formatDate(DateTime.now().add(Duration(days: 1)));
      _selectedTaskStartTime =
          DateTimeUtils.formatTime(DateTime.now().add(Duration(hours: 1)));
      _selectedTaskEndTime = DateTimeUtils.formatTime(
          DateTime.now().add(Duration(hours: 1, minutes: 30)));
      _selectedTaskReminder = S.of(context).reminderOption2;
      _selectedTaskRepeat = S.of(context).repeatOption1;
      _selectedTaskPriority = TaskPriority.medium;
      _selectedTaskCategories = [];
      _attachments.clear();
      _subtasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedTaskReminder = S.of(context).reminderOption2;
    _selectedTaskRepeat = S.of(context).repeatOption1;
    _repeatEntity = TaskRepeatEntity(
      interval: 1,
      option: S.of(context).repeatOption1,
      duration: S.of(context).repeatDuration1,
      count: 0,
      weekDays: [],
      untilDate: null,
    );
    _reminderEntity = TaskReminderEntity(
      option: S.of(context).reminderOption2,
      value: 0,
      unit: S.of(context).reminderUnit1,
    );
    final scrollController = Provider.of<ScrollController>(context);
    final prefs = HiveService.preferencesNotifier.value;
    final language = prefs.appLanguage;
    final priorityLabel = _selectedTaskPriority.label(context);
    final predefinedCategories = predefinedTaskCategories(context);

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
                      title: S.of(context).addTaskAppBar,
                      showBackButton: false,
                    ),
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
                          DateTime? pickedDate =
                              await TaskDialogUtils.showCustomDatePickerDialog(
                                  context: context);
                          if (pickedDate != null) {
                            setState(() {
                              _selectedTaskDate =
                                  DateTimeUtils.formatDate(pickedDate);
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
                            label: S.of(context).startTimeTextField,
                            widget: GestureDetector(
                              onTap: () async {
                                String initialTime = _selectedTaskStartTime;
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
                            label: S.of(context).endTimeTextField,
                            widget: GestureDetector(
                              onTap: () async {
                                String initialTime = _selectedTaskEndTime;
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
                                      .selectedTaskReminder(
                                          result.value.toString(),
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
                      label: S.of(context).priorityTextField,
                      widget: GestureDetector(
                        onTap: () async {
                          final selected =
                              await showPrioritySelectionModalSheet(
                            context,
                            _selectedTaskPriority,
                          );
                          if (selected != null) {
                            setState(() {
                              _selectedTaskPriority = selected;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            hintText: priorityLabel,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                  TaskCategoryEntity category =
                                      TaskCategoryEntity(
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
                                          selectedCategories:
                                              _selectedTaskCategories,
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
                                        bool isSelected =
                                            _selectedTaskCategories.any(
                                                (c) => c.name == category.name);
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
                                                fontFamilyFallback: [
                                                  'MaterialIcons'
                                                ],
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
                                avatar: const Icon(Icons.add,
                                    color: AppColors.greyColor),
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
                            alignment: language == AppLanguage.english
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.regular14
                                    .copyWith(color: AppColors.bodyTextColor),
                                children: [
                                  TextSpan(
                                    text: S.of(context).maximumCategoryLimit,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '3',
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
                      label: S
                          .of(context)
                          .attachmentsLength(_attachments.length.toString()),
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
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      size: 40,
                                      color: AppColors.greyColor,
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      S.of(context).uploadFilesContainer,
                                      style: AppTextStyles.regular18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: language == AppLanguage.english
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.regular14
                                      .copyWith(color: AppColors.bodyTextColor),
                                  children: [
                                    TextSpan(
                                      text: S.of(context).uploadFileSizeLimit,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: S.of(context).fiftyMB,
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
                      label: S
                          .of(context)
                          .subtasksLength(_subtasks.length.toString()),
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
                                  S.of(context).addSubtaskButton,
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
                                                  Text(S
                                                      .of(context)
                                                      .editSubtaskAction),
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
                                                  Text(S
                                                      .of(context)
                                                      .deleteSubtaskAction),
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
                      title: S.of(context).createTaskButton,
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
                              if (!context.mounted) return;
                              await _addAttachments(
                                context,
                                taskId,
                                userId,
                              );
                              if (!context.mounted) return;
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
