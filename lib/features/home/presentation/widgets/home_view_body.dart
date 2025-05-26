import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/functions/filter_tasks.dart';
import 'package:taskify/core/services/get_it_service.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/build_snackbar.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/task_ui_helper.dart';
import 'package:taskify/core/widgets/custom_pop_up_menu_button.dart';
import 'package:taskify/core/widgets/custom_search_text_field.dart';
import 'package:taskify/features/home/domain/entities/category_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:taskify/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:taskify/features/home/presentation/widgets/task_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final supabase = getIt<SupabaseClient>();
  late TextEditingController _searchController;
  List<String> _selectedStatuses = [];
  List<String> _selectedPriorities = [];
  List<CategoryEntity> _selectedCategories = [];
  List<String> _selectedDueDates = [];
  List<CategoryEntity> _customCategories = [];
  String _selectedSortField = 'dueDate';
  bool _isDateAscending = true;
  bool _isPriorityAscending = true;
  bool _isAlphabetAscending = true;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    getTasks();
    _loadCustomCategoriesFromHive();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> getTasks() async {
    await context
        .read<TaskCubit>()
        .getTasks(userId: supabase.auth.currentUser!.id);
  }

  Future<void> _loadCustomCategoriesFromHive() async {
    var categoriesBox = await Hive.openBox(AppConstants.categoriesBox);
    List<CategoryEntity> categories =
        List<CategoryEntity>.from(categoriesBox.values);
    setState(() {
      _customCategories = categories;
    });
  }

  Future<void> _showFiltersAndSort(BuildContext context) async {
    List<String> tempStatuses = List<String>.from(_selectedStatuses);
    List<CategoryEntity> tempCategories =
        List<CategoryEntity>.from(_selectedCategories);
    List<String> tempDueDates = List<String>.from(_selectedDueDates);
    List<String> tempPriorities = List<String>.from(_selectedPriorities);
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
                        ...predefinedCategories.map(
                          (categoryMap) {
                            final category = CategoryEntity(
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
                              selectedColor: category.color.withOpacity(0.2),
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
                                      fontFamilyFallback: [
                                        'MaterialIcons',
                                        'CupertinoIcons'
                                      ],
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
                            selectedColor: category.color.withOpacity(0.2),
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
                              AppColors.primaryLightColor.withOpacity(0.2),
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
                      children: ['In Progress', 'Completed', 'Overdue', 'Trash']
                          .map((status) {
                        bool isSelected = tempStatuses.contains(status);
                        final statusDetails =
                            TaskUIHelper.getStatusDetails(status);

                        return FilterChip(
                          showCheckmark: false,
                          label: Text(status),
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
                              AppColors.primaryLightColor.withOpacity(0.2),
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
                      children: ['High', 'Medium', 'Low'].map((priority) {
                        bool isSelected = tempPriorities.contains(priority);
                        var priorityDetails =
                            TaskUIHelper.getPriorityDetails(priority);
                        return FilterChip(
                          showCheckmark: false,
                          label: Text(priority),
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
                              AppColors.primaryLightColor.withOpacity(0.2),
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
                          onTap: () =>
                              setState(() => tempSortField = 'dueDate'),
                          child: _buildSortOption(
                            label: 'dueDate',
                            icon: FontAwesomeIcons.arrowUpWideShort,
                            isAscending: tempIsDateAscending,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsDateAscending = asc;
                                tempSortField = 'dueDate';
                              });
                            },
                          ),
                        ),
                        // Priority
                        GestureDetector(
                          onTap: () =>
                              setState(() => tempSortField = 'priority'),
                          child: _buildSortOption(
                            label: 'priority',
                            icon: FontAwesomeIcons.triangleExclamation,
                            isAscending: tempIsPriorityAscending,
                            ascendingLabel: 'High to Low',
                            descendingLabel: 'Low to High',
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsPriorityAscending = asc;
                                tempSortField = 'priority';
                              });
                            },
                          ),
                        ),
                        // Alphabet
                        GestureDetector(
                          onTap: () =>
                              setState(() => tempSortField = 'alphabet'),
                          child: _buildSortOption(
                            label: 'alphabet',
                            icon: FontAwesomeIcons.arrowUpAZ,
                            isAscending: tempIsAlphabetAscending,
                            onOrderChanged: (asc) {
                              setState(() {
                                tempIsAlphabetAscending = asc;
                                tempSortField = 'alphabet';
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
          sortBy: _selectedSortField,
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
          sortBy: _selectedSortField,
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
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    AppRoutes.taskDetails,
                    arguments: tasks[index],
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

  List<String> get _tabs {
    return [
      'All',
      'Today',
      'Tomorrow',
      'Upcoming',
      'Completed',
      'Overdue',
    ];
  }

  List<Widget> _tabViews(
      List<TaskEntity> tasks,
      List<TaskEntity> todayTasks,
      List<TaskEntity> tomorrowTasks,
      List<TaskEntity> upcomingTasks,
      List<TaskEntity> completedTasks,
      List<TaskEntity> overdueTasks) {
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
        .where((task) => task.status != 'Trash')
        .toList();
    final todayTasks = filterTasks(tasks, 'today');
    final tomorrowTasks = filterTasks(tasks, 'tomorrow');
    final upcomingTasks = filterTasks(tasks, 'upcoming');
    final completedTasks = filterTasks(tasks, 'completed');
    final overdueTasks = filterTasks(tasks, 'overdue');
    final scrollController = Provider.of<ScrollController>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomHomeAppBar(),
            const SizedBox(height: 30),
            CustomTabBar(
              selectedTabIndex: _selectedTabIndex,
              titles: _tabs,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
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
                  await _showFiltersAndSort(context);
                },
                child: Icon(
                  Icons.filter_alt,
                  color: AppColors.primaryLightColor,
                  size: 30,
                ),
              ),
              hintText: 'What are you looking for?',
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
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
