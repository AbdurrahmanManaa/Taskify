import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/extensions/task_enum_extensions.dart';
import 'package:taskify/core/functions/delete_custom_task_categories.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_search_text_field.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/task/task_category_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/views/task_details_view.dart';
import 'package:taskify/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:taskify/features/home/presentation/widgets/task_card.dart';
import 'package:taskify/generated/l10n.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late TextEditingController _searchController;
  List<TaskStatus> _selectedStatuses = [];
  List<TaskPriority> _selectedPriorities = [];
  List<TaskCategoryEntity> _selectedCategories = [];
  List<String> _selectedDueDates = [];
  bool _isDateAscending = true;
  bool _isPriorityAscending = true;
  bool _isAlphabetAscending = true;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    getUserData();
    getTasks();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> getUserData() async {
    await context
        .read<UserCubit>()
        .getUserData(userId: widget.supabase.auth.currentUser!.id);
  }

  Future<void> getTasks() async {
    await context
        .read<TaskCubit>()
        .getTasks(userId: widget.supabase.auth.currentUser!.id);
  }

  Future<void> _showFiltersAndSort(
    BuildContext context,
    List<Map<String, dynamic>> categories,
    String selectedSortField,
    String ascendingLabel,
    String descendingLabel,
    String ascendingLowToHigh,
    String descendingHighToLow,
  ) async {
    List<TaskStatus> tempStatuses = List<TaskStatus>.from(_selectedStatuses);
    List<TaskCategoryEntity> tempCategories =
        List<TaskCategoryEntity>.from(_selectedCategories);
    List<String> tempDueDates = List<String>.from(_selectedDueDates);
    List<TaskPriority> tempPriorities =
        List<TaskPriority>.from(_selectedPriorities);
    String tempSortField = selectedSortField;
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
                      S.of(context).filters,
                      style: AppTextStyles.medium24,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).categoriesFilter,
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
                        ValueListenableBuilder<List<TaskCategoryEntity>>(
                            valueListenable: HiveService.categoriesNotifier,
                            builder: (context, customCategories, _) {
                              return Wrap(
                                spacing: 8,
                                children: customCategories.map(
                                  (category) {
                                    bool isSelected = tempCategories
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
                                            if (selected) {
                                              tempCategories.add(category);
                                            } else {
                                              tempCategories.removeWhere((c) =>
                                                  c.name == category.name);
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ).toList(),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).dueDateFilter,
                      style: AppTextStyles.regular16,
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      children: [
                        S.of(context).todayFilter,
                        S.of(context).tomorrowFilter,
                        S.of(context).thisWeekFilter,
                        S.of(context).thisMonthFilter,
                        S.of(context).thisYearFilter,
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
                      S.of(context).statusFilter,
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
                        final label = status.label(context);

                        return FilterChip(
                          showCheckmark: false,
                          label: Text(label),
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
                      S.of(context).priorityFilter,
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
                        final priorityDetails =
                            TaskUIHelper.getPriorityDetails(priority);
                        final label = priority.label(context);

                        return FilterChip(
                          showCheckmark: false,
                          label: Text(label),
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
                      S.of(context).sortBy,
                      style: AppTextStyles.medium24,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => tempSortField =
                              S.of(context).tempSortFieldDueDate),
                          child: _buildSortOption(
                            label: S.of(context).sortByLabel1,
                            ascendingLabel: ascendingLabel,
                            descendingLabel: descendingLabel,
                            icon: FontAwesomeIcons.arrowUpWideShort,
                            isAscending: tempIsDateAscending,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsDateAscending = asc;
                                tempSortField =
                                    S.of(context).tempSortFieldDueDate;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => tempSortField =
                              S.of(context).tempSortFieldPriority),
                          child: _buildSortOption(
                            label: S.of(context).sortByLabel2,
                            icon: FontAwesomeIcons.triangleExclamation,
                            isAscending: tempIsPriorityAscending,
                            ascendingLabel: ascendingLowToHigh,
                            descendingLabel: descendingHighToLow,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsPriorityAscending = asc;
                                tempSortField =
                                    S.of(context).tempSortFieldPriority;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => tempSortField =
                              S.of(context).tempSortFieldAlphabet),
                          child: _buildSortOption(
                            label: S.of(context).sortByLabel3,
                            ascendingLabel: ascendingLabel,
                            descendingLabel: descendingLabel,
                            icon: FontAwesomeIcons.arrowUpAZ,
                            isAscending: tempIsAlphabetAscending,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsAlphabetAscending = asc;
                                tempSortField =
                                    S.of(context).tempSortFieldAlphabet;
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
                          child: Text(
                            S.of(context).cancelModalSheetButton,
                            style:
                                TextStyle(color: AppColors.primaryLightColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _resetFiltersAndSort(
                              setState,
                              context,
                              selectedSortField,
                            );
                          },
                          child: Text(
                            S.of(context).resetModalSheetButton,
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
                              selectedSortField = tempSortField;
                              _isDateAscending = tempIsDateAscending;
                              _isPriorityAscending = tempIsPriorityAscending;
                              _isAlphabetAscending = tempIsAlphabetAscending;
                            });

                            _applyFiltersAndSort(
                              context,
                              selectedSortField,
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            S.of(context).okModalBottomSheet,
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
      case 'dueDate':
        return _isDateAscending;
      case 'priority':
        return _isPriorityAscending;
      case 'alphabet':
        return _isAlphabetAscending;
      default:
        return true;
    }
  }

  void _resetFiltersAndSort(
    StateSetter setState,
    BuildContext context,
    String selectedSortField,
  ) {
    setState(() {
      _searchController.clear();
      _selectedStatuses.clear();
      _selectedPriorities.clear();
      _selectedCategories.clear();
      _selectedDueDates.clear();
      selectedSortField = S.of(context).selectedSortField;
      _isDateAscending = true;
      _isPriorityAscending = true;
      _isAlphabetAscending = true;
    });

    Navigator.pop(context);

    final bool isAscending = _getSortOrderForField(selectedSortField);

    context.read<TaskCubit>().applyFiltersAndSort(
          query: _searchController.text,
          statuses: _selectedStatuses,
          priorities: _selectedPriorities,
          categories: _selectedCategories.map((c) => c.name).toList(),
          dueDates: _selectedDueDates,
          sortBy: selectedSortField,
          ascending: isAscending,
        );
  }

  void _applyFiltersAndSort(BuildContext context, String selectedSortField) {
    final bool isAscending = _getSortOrderForField(selectedSortField);

    context.read<TaskCubit>().applyFiltersAndSort(
          query: _searchController.text,
          statuses: _selectedStatuses,
          priorities: _selectedPriorities,
          categories: _selectedCategories.map((c) => c.name).toList(),
          dueDates: _selectedDueDates,
          sortBy: selectedSortField,
          ascending: isAscending,
        );
  }

  Widget _buildSortOption({
    required String label,
    required IconData icon,
    required ValueChanged<bool> onOrderChanged,
    required bool isAscending,
    required String ascendingLabel,
    required String descendingLabel,
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

  Column _emptyTasksPlaceholder() {
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

  BlocConsumer<TaskCubit, TaskState> _buildTasks(
      {required List<TaskEntity> tasks}) {
    return BlocConsumer<TaskCubit, TaskState>(
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
              style:
                  AppTextStyles.regular16.copyWith(color: AppColors.greyColor),
            ),
          );
        } else {
          if (tasks.isEmpty) {
            return _emptyTasksPlaceholder();
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: tasks.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  pushScreenWithoutNavBar(
                    context,
                    Provider.value(
                      value: tasks[index],
                      child: const TaskDetailsView(),
                    ),
                  );
                },
                child: TaskCard(
                  taskEntity: tasks[index],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> _tabViews(
    List<TaskEntity> tasks,
    List<TaskEntity> todayTasks,
    List<TaskEntity> tomorrowTasks,
    List<TaskEntity> upcomingTasks,
    List<TaskEntity> completedTasks,
    List<TaskEntity> overdueTasks,
  ) {
    return [
      _buildTasks(
        tasks: tasks,
      ),
      _buildTasks(
        tasks: todayTasks,
      ),
      _buildTasks(
        tasks: tomorrowTasks,
      ),
      _buildTasks(
        tasks: upcomingTasks,
      ),
      _buildTasks(
        tasks: completedTasks,
      ),
      _buildTasks(
        tasks: overdueTasks,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tasks = context
        .watch<TaskCubit>()
        .filteredTasks
        .where((task) => task.status != TaskStatus.trash)
        .toList();
    final todayTasks = filterTasks(tasks, 'today');
    final tomorrowTasks = filterTasks(tasks, 'tomorrow');
    final upcomingTasks = filterTasks(tasks, 'upcoming');
    final completedTasks = filterTasks(tasks, 'completed');
    final overdueTasks = filterTasks(tasks, 'overdue');
    final scrollController = Provider.of<ScrollController>(context);
    final predefinedCategories = predefinedTaskCategories(context);
    final String selectedSortField = S.of(context).selectedSortField;
    final String ascendingLabel = S.of(context).ascendingLabel;
    final String descendingLabel = S.of(context).descendingLabel;
    final String ascendingLowToHigh = S.of(context).ascendingLowToHigh;
    final String descendingHighToLow = S.of(context).descendingHighToLow;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomHomeAppBar(
              supabase: widget.supabase,
            ),
            const SizedBox(height: 30),
            CustomTabBar(
              selectedTabIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              titleCount: 5,
            ),
            const SizedBox(height: 20),
            CustomSearchTextField(
              controller: _searchController,
              onChanged: (value) {
                _applyFiltersAndSort(
                  context,
                  selectedSortField,
                );
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
                    selectedSortField,
                    ascendingLabel,
                    descendingLabel,
                    ascendingLowToHigh,
                    descendingHighToLow,
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
            IndexedStack(
              index: _selectedTabIndex,
              children: _tabViews(
                tasks,
                todayTasks,
                tomorrowTasks,
                upcomingTasks,
                completedTasks,
                overdueTasks,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
