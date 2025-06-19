import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_search_text_field.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/views/task_details_view.dart';
import 'package:taskify/features/home/presentation/widgets/task_card.dart';
import 'package:taskify/generated/l10n.dart';

class TrashViewBody extends StatefulWidget {
  const TrashViewBody({super.key});

  @override
  State<TrashViewBody> createState() => _TrashViewBodyState();
}

class _TrashViewBodyState extends State<TrashViewBody> {
  late TextEditingController _searchController;
  List<TaskStatus> _selectedStatuses = [];
  List<TaskPriority> _selectedPriorities = [];
  List<TaskCategoryEntity> _selectedCategories = [];
  List<String> _selectedDueDates = [];
  final List<TaskCategoryEntity> _customCategories = [];
  String _selectedSortField = 'Date';
  bool _isDateAscending = true;
  bool _isPriorityAscending = true;
  bool _isAlphabetAscending = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Column _emptyTrashPlaceholder() {
    return Column(
      children: [
        Lottie.asset(
          AppAssets.animationsEmpty,
          filterQuality: FilterQuality.high,
          frameRate: FrameRate(120),
        ),
        Text(
          'It\'s empty here, add some tasks',
          style: AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }

  Skeletonizer _tasksPlaceholder() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TaskCard(
            taskEntity: TaskEntity(
              id: '',
              userId: '',
              title: 'Get Groceries for the week',
              description:
                  'Go to the grocery store and buy groceries for the week',
              dueDate: DateTime.now(),
              startTime: DateTime.now(),
              endTime: DateTime.now(),
              status: TaskStatus.inProgress,
              priority: TaskPriority.low,
              reminder: TaskReminderEntity(option: '', value: 0, unit: ''),
              repeat: TaskRepeatEntity(
                interval: 0,
                option: '',
                duration: '',
                count: 0,
                weekDays: [],
              ),
              categories: [],
              attachmentsCount: 0,
              subtaskCount: 0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showFiltersAndSort(
      BuildContext context, List<Map<String, dynamic>> categories) async {
    List<TaskStatus> tempStatuses = List<TaskStatus>.from(_selectedStatuses);
    List<TaskCategoryEntity> tempCategories =
        List<TaskCategoryEntity>.from(_selectedCategories);
    List<String> tempDueDates = List<String>.from(_selectedDueDates);
    List<TaskPriority> tempPriorities =
        List<TaskPriority>.from(_selectedPriorities);
    String tempSortField = _selectedSortField;
    bool tempIsDateAscending = _isDateAscending;
    bool tempIsPriorityAscending = _isPriorityAscending;
    bool tempIsAlphabetAscending = _isAlphabetAscending;

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.scaffoldLightBackgroundColor,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 23,
                right: 23,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      'Filters',
                      style: AppTextStyles.medium24,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Categories',
                      style: AppTextStyles.regular16,
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      children: [
                        ...categories.map(
                          (categoryMap) {
                            final category = TaskCategoryEntity(
                              name: categoryMap['name'],
                              icon: categoryMap['icon'],
                              color: categoryMap['color'],
                            );
                            final isSelected = tempCategories
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
                              selected: isSelected,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    tempCategories.add(category);
                                  } else {
                                    tempCategories.removeWhere(
                                        (c) => c.name == category.name);
                                  }
                                });
                              },
                              selectedColor: category.color.withAlpha(51),
                            );
                          },
                        ),
                        ..._customCategories.map((category) {
                          final isSelected = tempCategories
                              .any((c) => c.name == category.name);
                          return FilterChip(
                            showCheckmark: false,
                            label: Text(category.name),
                            avatar: Icon(
                              isSelected
                                  ? null
                                  : IconData(
                                      category.icon.codePoint,
                                      fontFamilyFallback: ['MaterialIcons'],
                                    ),
                              color: Color(
                                category.color.toARGB32(),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  tempCategories.add(category);
                                } else {
                                  tempCategories.removeWhere(
                                      (c) => c.name == category.name);
                                }
                              });
                            },
                            selectedColor: category.color.withAlpha(51),
                            backgroundColor:
                                AppColors.scaffoldLightBackgroundColor,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Due Date',
                      style: AppTextStyles.regular16,
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      children: [
                        'Today',
                        'Tomorrow',
                        'This Week',
                        'This Month',
                        'This Year',
                      ].map((dueDateOption) {
                        bool isSelected = tempDueDates.contains(dueDateOption);
                        return FilterChip(
                          showCheckmark: false,
                          label: Text(dueDateOption),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected &&
                                  !tempDueDates.contains(dueDateOption)) {
                                tempDueDates.add(dueDateOption);
                              } else if (!selected) {
                                tempDueDates.remove(dueDateOption);
                              }
                            });
                          },
                          selectedColor:
                              AppColors.primaryLightColor.withAlpha(51),
                          backgroundColor:
                              AppColors.scaffoldLightBackgroundColor,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Status',
                      style: AppTextStyles.regular16,
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      children: [
                        TaskStatus.inProgress,
                        TaskStatus.completed,
                        TaskStatus.overdue,
                        TaskStatus.trash
                      ].map((status) {
                        bool isSelected = tempStatuses.contains(status);
                        final statusDetails =
                            TaskUIHelper.getStatusDetails(status);

                        return FilterChip(
                          showCheckmark: false,
                          label: Text(status.name),
                          avatar: Icon(
                            statusDetails['icon'],
                            color: statusDetails['color'],
                          ),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(
                              () {
                                if (selected &&
                                    !tempStatuses.contains(status)) {
                                  tempStatuses.add(status);
                                } else if (!selected) {
                                  tempStatuses.remove(status);
                                }
                              },
                            );
                          },
                          selectedColor:
                              AppColors.primaryLightColor.withAlpha(51),
                          backgroundColor:
                              AppColors.scaffoldLightBackgroundColor,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Priority',
                      style: AppTextStyles.regular16,
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      children: [
                        TaskPriority.high,
                        TaskPriority.medium,
                        TaskPriority.low
                      ].map((priority) {
                        bool isSelected = tempPriorities.contains(priority);
                        var priorityDetails =
                            TaskUIHelper.getPriorityDetails(priority);
                        return FilterChip(
                          showCheckmark: false,
                          label: Text(priority.name),
                          avatar: Icon(
                            priorityDetails['icon'],
                            color: priorityDetails['color'],
                          ),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(
                              () {
                                if (selected &&
                                    !tempPriorities.contains(priority)) {
                                  tempPriorities.add(priority);
                                } else if (!selected) {
                                  tempPriorities.remove(priority);
                                }
                              },
                            );
                          },
                          selectedColor:
                              AppColors.primaryLightColor.withAlpha(51),
                          backgroundColor:
                              AppColors.scaffoldLightBackgroundColor,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Sort By',
                      style: AppTextStyles.medium24,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => tempSortField = 'Date'),
                          child: _buildSortOption(
                            label: 'Date',
                            icon: FontAwesomeIcons.arrowUpWideShort,
                            isAscending: tempIsDateAscending,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsDateAscending = asc;
                                tempSortField = 'Date';
                              });
                            },
                          ),
                        ),
                        // Priority
                        GestureDetector(
                          onTap: () =>
                              setState(() => tempSortField = 'Priority'),
                          child: _buildSortOption(
                            label: 'Priority',
                            icon: FontAwesomeIcons.triangleExclamation,
                            isAscending: tempIsPriorityAscending,
                            ascendingLabel: 'Low to High',
                            descendingLabel: 'High to Low',
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsPriorityAscending = asc;
                                tempSortField = 'Priority';
                              });
                            },
                          ),
                        ),
                        // Alphabet
                        GestureDetector(
                          onTap: () =>
                              setState(() => tempSortField = 'Alphabet'),
                          child: _buildSortOption(
                            label: 'Alphabet',
                            icon: FontAwesomeIcons.arrowUpAZ,
                            isAscending: tempIsAlphabetAscending,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsAlphabetAscending = asc;
                                tempSortField = 'Alphabet';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style:
                                TextStyle(color: AppColors.primaryLightColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _resetFiltersAndSort(
                              setState,
                              context,
                            );
                          },
                          child: Text(
                            'Reset',
                            style: AppTextStyles.regular16
                                .copyWith(color: AppColors.primaryLightColor),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryLightColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedStatuses = tempStatuses;
                              _selectedCategories = tempCategories;
                              _selectedDueDates = tempDueDates;
                              _selectedPriorities = tempPriorities;
                              _selectedSortField = tempSortField;
                              _isDateAscending = tempIsDateAscending;
                              _isPriorityAscending = tempIsPriorityAscending;
                              _isAlphabetAscending = tempIsAlphabetAscending;
                            });

                            _applyFiltersAndSort(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Ok',
                            style: AppTextStyles.regular16
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _getSortOrderForField(String field) {
    switch (field) {
      case 'Date':
        return _isDateAscending;
      case 'Priority':
        return _isPriorityAscending;
      case 'Alphabet':
        return _isAlphabetAscending;
      default:
        return true;
    }
  }

  void _resetFiltersAndSort(StateSetter setState, BuildContext context) {
    setState(() {
      _searchController.clear();
      _selectedStatuses.clear();
      _selectedPriorities.clear();
      _selectedCategories.clear();
      _selectedDueDates.clear();
      _selectedSortField = 'Date';
      _isDateAscending = true;
      _isPriorityAscending = true;
      _isAlphabetAscending = true;
    });

    Navigator.pop(context);

    final bool isAscending = _getSortOrderForField(_selectedSortField);

    context.read<TaskCubit>().applyFiltersAndSort(
          query: _searchController.text,
          statuses: _selectedStatuses,
          priorities: _selectedPriorities,
          categories: _selectedCategories.map((c) => c.name).toList(),
          dueDates: _selectedDueDates,
          sortBy: _selectedSortField.toLowerCase(),
          ascending: isAscending,
        );
  }

  void _applyFiltersAndSort(BuildContext context) {
    final bool isAscending = _getSortOrderForField(_selectedSortField);

    context.read<TaskCubit>().applyFiltersAndSort(
          query: _searchController.text,
          statuses: _selectedStatuses,
          priorities: _selectedPriorities,
          categories: _selectedCategories.map((c) => c.name).toList(),
          dueDates: _selectedDueDates,
          sortBy: _selectedSortField.toLowerCase(),
          ascending: isAscending,
        );
  }

  Widget _buildSortOption({
    required String label,
    required IconData icon,
    required ValueChanged<bool> onOrderChanged,
    required bool isAscending,
    String ascendingLabel = 'Ascending',
    String descendingLabel = 'Descending',
  }) {
    return CustomPopupMenuButton(
      onSelected: (int value) {
        onOrderChanged(value == 1);
      },
      icon: Icon(icon, color: AppColors.primaryLightColor),
      items: [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              if (isAscending)
                Icon(FontAwesomeIcons.check, color: AppColors.greyColor),
              const SizedBox(width: 10),
              Text(ascendingLabel),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              if (!isAscending)
                Icon(FontAwesomeIcons.check, color: AppColors.greyColor),
              const SizedBox(width: 10),
              Text(descendingLabel),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskCubit>().filteredTasks;
    final trashTasks = filterTasks(tasks, 'trash');
    final predefinedCategories = predefinedTaskCategories(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAppbar(title: S.of(context).trashAppBar),
            const SizedBox(height: 20),
            Text(
              S.of(context).trashBody,
              style:
                  AppTextStyles.regular18.copyWith(color: AppColors.greyColor),
            ),
            const SizedBox(height: 20),
            CustomSearchTextField(
              controller: _searchController,
              onChanged: (value) {
                _applyFiltersAndSort(context);
              },
              prefixIcon: Image.asset(
                AppAssets.imagesSearch,
                scale: 3,
              ),
              suffixIcon: GestureDetector(
                onTap: () async {
                  await _showFiltersAndSort(
                    context,
                    predefinedCategories,
                  );
                },
                child: Icon(
                  Icons.filter_alt,
                  color: AppColors.primaryLightColor,
                  size: 30,
                ),
              ),
              hintText: S.of(context).searchBarPlaceholder,
            ),
            const SizedBox(height: 20),
            BlocConsumer<TaskCubit, TaskState>(
              listener: (context, state) {
                if (state is TaskDeleted) {
                  buildSnackbar(context, message: 'Task deleted successfully!');
                }
              },
              builder: (context, state) {
                if (state is TaskLoading) {
                  return _tasksPlaceholder();
                } else if (state is TaskFailure) {
                  return Center(
                    child: Text(
                      'Failed to load tasks',
                      style: AppTextStyles.regular16
                          .copyWith(color: AppColors.greyColor),
                    ),
                  );
                } else {
                  if (trashTasks.isEmpty) {
                    return _emptyTrashPlaceholder();
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: trashTasks.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          pushScreenWithoutNavBar(
                            context,
                            Provider.value(
                              value: trashTasks[index],
                              child: const TaskDetailsView(),
                            ),
                          );
                        },
                        child: TaskCard(
                          taskEntity: trashTasks[index],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
