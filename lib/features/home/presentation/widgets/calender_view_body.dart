import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskify/core/utils/app_assets.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/date_time_utils.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/features/home/domain/entities/task/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_priority.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_status.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';
import 'package:taskify/features/home/presentation/widgets/calender_item.dart';

class CalenderViewBody extends StatefulWidget {
  const CalenderViewBody({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<CalenderViewBody> createState() => _CalenderViewBodyState();
}

class _CalenderViewBodyState extends State<CalenderViewBody> {
  late TextEditingController _searchController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    getTasks;
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> getTasks() async {
    await context
        .read<TaskCubit>()
        .getTasks(userId: widget.supabase.auth.currentUser!.id);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  List<TaskEntity> _filterTasks(List<TaskEntity> tasks) {
    var filteredTasks =
        tasks.where((task) => task.status != TaskStatus.trash).toList();

    if (_rangeStart != null && _rangeEnd != null) {
      filteredTasks = filteredTasks.where((task) {
        return (task.dueDate.isAfter(_rangeStart!) ||
                isSameDay(task.dueDate, _rangeStart!)) &&
            (task.dueDate.isBefore(_rangeEnd!) ||
                isSameDay(task.dueDate, _rangeEnd!));
      }).toList();
    } else if (_selectedDay != null) {
      filteredTasks = filteredTasks
          .where((task) => isSameDay(task.dueDate, _selectedDay!))
          .toList();
    }

    filteredTasks.sort((a, b) {
      final aTime = DateTimeUtils.extractTime(a.endTime);
      final bTime = DateTimeUtils.extractTime(b.endTime);
      return aTime.compareTo(bTime);
    });

    return filteredTasks;
  }

  List<TaskEntity> _getEventsForDay(DateTime day, List<TaskEntity> tasks) {
    return tasks.where((task) => isSameDay(task.dueDate, day)).toList();
  }

  Row? _buildMarkers(List<Object?> events, DateTime day) {
    if (events.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: events.map((event) {
          return Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: isSameDay(day, _selectedDay)
                  ? AppColors.primaryLightColor
                  : AppColors.primaryLightColor.withAlpha(128),
              shape: BoxShape.circle,
            ),
          );
        }).toList(),
      );
    } else {
      return null;
    }
  }

  Center? _buildDow(DateTime day) {
    if (day.weekday == DateTime.saturday) {
      final text = DateFormat.E().format(day);
      return Center(
        child: Text(
          text,
          style: TextStyle(color: AppColors.errorColor),
        ),
      );
    } else if (day.weekday == DateTime.friday) {
      final text = DateFormat.E().format(day);
      return Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.blue),
        ),
      );
    }
    return null;
  }

  Center? _buildDefault(DateTime day) {
    if (day.weekday == DateTime.saturday) {
      return Center(
        child: Text(
          '${day.day}',
          style: TextStyle(color: AppColors.errorColor),
        ),
      );
    } else if (day.weekday == DateTime.friday) {
      return Center(
        child: Text(
          '${day.day}',
          style: TextStyle(color: Colors.blue),
        ),
      );
    }
    return null;
  }

  Skeletonizer _calenderTasksPlaceholder() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CalenderItem(
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

  Column _emptyCalenderPlaceholder() {
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

  @override
  Widget build(BuildContext context) {
    var tasks = context.watch<TaskCubit>().tasks;
    final scrollController = Provider.of<ScrollController>(context);

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: CustomAppbar(
              title: 'Calender',
              showBackButton: false,
            ),
          ),
          const SizedBox(height: 20),
          TableCalendar(
            headerStyle: const HeaderStyle(
              titleTextStyle: AppTextStyles.medium20,
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.primaryLightColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primaryLightColor.withAlpha(128),
                shape: BoxShape.circle,
              ),
            ),
            weekendDays: [DateTime.friday, DateTime.saturday],
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(
              const Duration(days: 730),
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            enabledDayPredicate: (day) => day.month == _focusedDay.month,
            eventLoader: (day) => _getEventsForDay(day, tasks),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) => _buildMarkers(
                events,
                day,
              ),
              dowBuilder: (context, day) => _buildDow(day),
              defaultBuilder: (context, day, focusedDay) => _buildDefault(day),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return _calenderTasksPlaceholder();
              } else if (state is TaskFailure) {
                return Center(
                  child: Text(
                    'Failed to load tasks',
                    style: AppTextStyles.regular16
                        .copyWith(color: AppColors.greyColor),
                  ),
                );
              } else {
                var filteredTasks = _filterTasks(tasks);
                if (filteredTasks.isEmpty) {
                  return _emptyCalenderPlaceholder();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CalenderItem(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            'taskDetails',
                            arguments: _filterTasks(filteredTasks)[index],
                          );
                        },
                        taskEntity: filteredTasks[index],
                      ),
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
