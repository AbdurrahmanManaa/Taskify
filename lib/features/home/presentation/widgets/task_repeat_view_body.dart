import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/utils/schedule_parser.dart';
import 'package:taskify/core/widgets/custom_animated_switcher.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_wrapper_container.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskRepeatViewBody extends StatefulWidget {
  const TaskRepeatViewBody({super.key});

  @override
  State<TaskRepeatViewBody> createState() => _TaskRepeatViewBodyState();
}

class _TaskRepeatViewBodyState extends State<TaskRepeatViewBody> {
  late final TextEditingController _intervalController;
  late final TextEditingController _countController;
  String _selectedOption = 'Don\'t repeat';
  String _selectedDuration = 'Forever';
  List<String> _selectedWeekDays = weekDays
      .where((day) => day.isSelected == true)
      .map((day) => day.dayKey)
      .toList();
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month + 1,
    5,
  );
  int _selectedInterval = 1;
  int _selectedCount = 10;
  bool _isSelected = false;
  bool _isDurationSelected = false;
  DateTime _focusedDate = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _focusedDate = focusedDay;
    });
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

  TableCalendar<dynamic> _buildTableCalender() {
    return TableCalendar(
      headerVisible: false,
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
      calendarFormat: CalendarFormat.month,
      focusedDay: _focusedDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      enabledDayPredicate: (day) => day.month == _focusedDate.month,
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDate = focusedDay;
        });
      },
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(
        const Duration(days: 730),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) => _buildDow(day),
        defaultBuilder: (context, day, focusedDay) => _buildDefault(day),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _intervalController = TextEditingController(
      text: '1',
    );
    _countController = TextEditingController(
      text: '10',
    );
  }

  @override
  void dispose() {
    _intervalController.dispose();
    _countController.dispose();
    super.dispose();
  }

  void toggleContent() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        _selectedOption = 'Custom';
      }
    });
  }

  void toggleDurationContent() {
    setState(() {
      _isDurationSelected = !_isDurationSelected;
      if (_isDurationSelected) {
        _selectedDuration = 'Custom';
      }
    });
  }

  SizedBox _buildNumberTextField({
    required TextEditingController controller,
    required int maxLength,
    required Function(PointerDownEvent)? onTapOutside,
    required Function(String)? onChanged,
    bool isAutoFocus = false,
  }) {
    return SizedBox(
      width: 40,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onTapOutside: onTapOutside,
        autofocus: isAutoFocus,
        textAlign: TextAlign.center,
        style: AppTextStyles.medium16.copyWith(color: Colors.black),
        maxLength: maxLength,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          counterText: '',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
        ),
        onChanged: onChanged,
      ),
    );
  }

  SelectWeekDays _buildWeekDaysWidget() {
    return SelectWeekDays(
      onSelect: (days) => setState(() {
        _selectedWeekDays = days;
      }),
      days: weekDays.map((day) {
        return DayInWeek(
          day.dayName.substring(0, 1),
          dayKey: day.dayKey,
          isSelected: _selectedWeekDays.contains(day.dayKey),
        );
      }).toList(),
      fontWeight: FontWeight.w500,
      backgroundColor: AppColors.inputDecorationLightFillColor,
      elevation: 0,
      selectedDayTextColor: Colors.white,
      selectedDaysBorderColor: AppColors.primaryLightColor,
      selectedDaysFillColor: AppColors.primaryLightColor,
      unSelectedDayTextColor: AppColors.primaryLightColor,
      unselectedDaysBorderColor: Colors.transparent,
    );
  }

  Text _formatUnit({required String unit}) {
    return Text(
      _intervalController.text.isEmpty
          ? unit
          : ' ${ScheduleParser.formatUnit(
              _selectedInterval,
              ScheduleParser.getRepeatUnit(_selectedOption),
              '${ScheduleParser.getRepeatUnit(_selectedOption)}s',
            )}',
      style: AppTextStyles.medium16.copyWith(color: Colors.black),
    );
  }

  String _formatRepeatText() {
    if (_selectedOption == 'Don\'t repeat') {
      return 'This event doesn\'t repeat';
    } else if (_selectedOption == 'Everyday') {
      return _selectedInterval == 0
          ? 'This event will repeat every day'
          : 'This event will repeat every $_selectedInterval day${_selectedInterval > 1 ? 's' : ''}';
    } else if (_selectedOption == 'Every week') {
      List<String> selectedDays = _selectedWeekDays;
      return _selectedInterval == 0
          ? 'This event will repeat every week on ${selectedDays.join(', ')}'
          : 'This event will repeat every $_selectedInterval week${_selectedInterval > 1 ? 's' : ''} on ${selectedDays.join(', ')}';
    } else if (_selectedOption == 'Every month') {
      return _selectedInterval == 0
          ? 'This event will repeat every month'
          : 'This event will repeat every $_selectedInterval month${_selectedInterval > 1 ? 's' : ''}';
    } else if (_selectedOption == 'Every year') {
      return _selectedInterval == 0
          ? 'This event will repeat every year'
          : 'This event will repeat every $_selectedInterval year${_selectedInterval > 1 ? 's' : ''}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomAppbar(
              title: 'Task Repeat',
              result: TaskRepeatEntity(
                interval: _selectedInterval,
                option: _selectedOption,
                duration: _selectedDuration,
                count: _selectedCount,
                weekDays: _selectedWeekDays,
                untilDate: _selectedDate,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _formatRepeatText(),
              style: AppTextStyles.medium18,
            ),
            const SizedBox(height: 20),
            CustomWrapperContainer(
              child: Column(
                children: [
                  OptionItem(
                    leading: Radio(
                      value: 'Don\'t repeat',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      'Don\'t repeat',
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == 'Everyday'
                        ? OptionItem(
                            leading: Radio(
                              value: 'Everyday',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Every ',
                                  style: AppTextStyles.medium16
                                      .copyWith(color: Colors.black),
                                ),
                                _buildNumberTextField(
                                  controller: _intervalController,
                                  maxLength: 4,
                                  onTapOutside: (_) {
                                    if (_intervalController.text
                                        .trim()
                                        .isEmpty) {
                                      setState(() {
                                        _intervalController.text = '1';
                                        _selectedInterval = 1;
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      int? newInterval = int.tryParse(newValue);
                                      int maxValue =
                                          repeatMaxValues[_selectedOption]!;
                                      if (newInterval != null) {
                                        newInterval =
                                            newInterval.clamp(1, maxValue);
                                        _intervalController.text =
                                            newInterval.toString();
                                        _intervalController.selection =
                                            TextSelection.collapsed(
                                                offset: _intervalController
                                                    .text.length);
                                        _selectedInterval = newInterval;
                                      } else {
                                        _selectedInterval = 0;
                                      }
                                    });
                                  },
                                ),
                                _formatUnit(unit: 'day'),
                              ],
                            ),
                          )
                        : OptionItem(
                            leading: Radio(
                              value: 'Everyday',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              'Everyday',
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == 'Every week'
                        ? Column(
                            children: [
                              OptionItem(
                                leading: Radio(
                                  value: 'Every week',
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value!;
                                      _isSelected = false;
                                    });
                                  },
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Every ',
                                      style: AppTextStyles.medium16
                                          .copyWith(color: Colors.black),
                                    ),
                                    _buildNumberTextField(
                                      controller: _intervalController,
                                      maxLength: 4,
                                      onTapOutside: (_) {
                                        if (_intervalController.text
                                            .trim()
                                            .isEmpty) {
                                          setState(() {
                                            _intervalController.text = '1';
                                            _selectedInterval = 1;
                                          });
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      onChanged: (newValue) {
                                        setState(() {
                                          int? newInterval =
                                              int.tryParse(newValue);
                                          int maxValue =
                                              repeatMaxValues[_selectedOption]!;
                                          if (newInterval != null) {
                                            newInterval =
                                                newInterval.clamp(1, maxValue);
                                            _intervalController.text =
                                                newInterval.toString();
                                            _intervalController.selection =
                                                TextSelection.collapsed(
                                                    offset: _intervalController
                                                        .text.length);
                                            _selectedInterval = newInterval;
                                          } else {
                                            _selectedInterval = 0;
                                          }
                                        });
                                      },
                                    ),
                                    _formatUnit(unit: 'week'),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              _buildWeekDaysWidget(),
                            ],
                          )
                        : OptionItem(
                            leading: Radio(
                              value: 'Every week',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              'Every week',
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == 'Every month'
                        ? OptionItem(
                            leading: Radio(
                              value: 'Every month',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Every ',
                                  style: AppTextStyles.medium16
                                      .copyWith(color: Colors.black),
                                ),
                                _buildNumberTextField(
                                  controller: _intervalController,
                                  maxLength: 4,
                                  onTapOutside: (_) {
                                    if (_intervalController.text
                                        .trim()
                                        .isEmpty) {
                                      setState(() {
                                        _intervalController.text = '1';
                                        _selectedInterval = 1;
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      int? newInterval = int.tryParse(newValue);
                                      int maxValue =
                                          repeatMaxValues[_selectedOption]!;
                                      if (newInterval != null) {
                                        newInterval =
                                            newInterval.clamp(1, maxValue);
                                        _intervalController.text =
                                            newInterval.toString();
                                        _intervalController.selection =
                                            TextSelection.collapsed(
                                                offset: _intervalController
                                                    .text.length);
                                        _selectedInterval = newInterval;
                                      } else {
                                        _selectedInterval = 0;
                                      }
                                    });
                                  },
                                ),
                                _formatUnit(unit: 'month'),
                              ],
                            ),
                          )
                        : OptionItem(
                            leading: Radio(
                              value: 'Every month',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              'Every month',
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == 'Every year'
                        ? OptionItem(
                            leading: Radio(
                              value: 'Every year',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Every ',
                                  style: AppTextStyles.medium16
                                      .copyWith(color: Colors.black),
                                ),
                                _buildNumberTextField(
                                  controller: _intervalController,
                                  maxLength: 4,
                                  onTapOutside: (_) {
                                    if (_intervalController.text
                                        .trim()
                                        .isEmpty) {
                                      setState(() {
                                        _intervalController.text = '1';
                                        _selectedInterval = 1;
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      int? newInterval = int.tryParse(newValue);
                                      int maxValue =
                                          repeatMaxValues[_selectedOption]!;
                                      if (newInterval != null) {
                                        newInterval =
                                            newInterval.clamp(1, maxValue);
                                        _intervalController.text =
                                            newInterval.toString();
                                        _intervalController.selection =
                                            TextSelection.collapsed(
                                                offset: _intervalController
                                                    .text.length);
                                        _selectedInterval = newInterval;
                                      } else {
                                        _selectedInterval = 0;
                                      }
                                    });
                                  },
                                ),
                                _formatUnit(unit: 'year'),
                              ],
                            ),
                          )
                        : OptionItem(
                            leading: Radio(
                              value: 'Every year',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              'Every year',
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: _selectedOption != 'Don\'t repeat',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration',
                    style: AppTextStyles.medium18,
                  ),
                  const SizedBox(height: 10),
                  CustomWrapperContainer(
                    child: GestureDetector(
                      onTap: toggleDurationContent,
                      child: CustomAnimatedSwitcher(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OptionItem(
                              leading: Radio(
                                value: 'Forever',
                                groupValue: _selectedDuration,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDuration = value!;
                                    _isDurationSelected = false;
                                  });
                                },
                              ),
                              title: Text(
                                'Forever',
                                style: AppTextStyles.medium18
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Divider(),
                            CustomAnimatedSwitcher(
                                child: _selectedDuration ==
                                        'Specific number of times'
                                    ? OptionItem(
                                        leading: Radio(
                                          value: 'Specific number of times',
                                          groupValue: _selectedDuration,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedDuration = value!;
                                              _isDurationSelected = false;
                                            });
                                          },
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            _buildNumberTextField(
                                              controller: _countController,
                                              maxLength: 3,
                                              onTapOutside: (_) {
                                                if (_countController.text
                                                    .trim()
                                                    .isEmpty) {
                                                  setState(() {
                                                    _countController.text =
                                                        '10';
                                                    _selectedCount = 10;
                                                  });
                                                }
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              onChanged: (newValue) {
                                                setState(
                                                  () {
                                                    int? newCount =
                                                        int.tryParse(newValue);
                                                    int maxValue = repeatMaxValues[
                                                        'Specific number of times']!;
                                                    if (newCount != null) {
                                                      newCount = newCount.clamp(
                                                          1, maxValue);
                                                      _countController.text =
                                                          newCount.toString();
                                                      _countController
                                                              .selection =
                                                          TextSelection.collapsed(
                                                              offset:
                                                                  _countController
                                                                      .text
                                                                      .length);
                                                      _selectedCount = newCount;
                                                    } else {
                                                      _selectedCount = 0;
                                                    }
                                                  },
                                                );
                                              },
                                              isAutoFocus: true,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              _countController.text
                                                      .trim()
                                                      .isEmpty
                                                  ? 'time total'
                                                  : (_selectedCount == 1
                                                      ? 'time total'
                                                      : 'times total'),
                                              style: AppTextStyles.medium16
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    : OptionItem(
                                        leading: Radio(
                                          value: 'Specific number of times',
                                          groupValue: _selectedDuration,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedDuration = value!;
                                              _isDurationSelected = false;
                                            });
                                          },
                                        ),
                                        title: Text(
                                          'Specific number of times',
                                          style: AppTextStyles.medium18
                                              .copyWith(color: Colors.black),
                                        ),
                                      )),
                            Divider(),
                            CustomAnimatedSwitcher(
                              child: _selectedDuration == 'Until'
                                  ? Column(
                                      children: [
                                        OptionItem(
                                          leading: Radio(
                                            value: 'Until',
                                            groupValue: _selectedDuration,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedDuration = value!;
                                                _isDurationSelected = false;
                                              });
                                            },
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Until ',
                                                style: AppTextStyles.medium16
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                              Text(
                                                DateFormat('EEE, MMM dd, yyyy')
                                                    .format(_selectedDate),
                                                style: AppTextStyles.medium16
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        _buildTableCalender(),
                                      ],
                                    )
                                  : OptionItem(
                                      leading: Radio(
                                        value: 'Until',
                                        groupValue: _selectedDuration,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedDuration = value!;
                                            _isDurationSelected = false;
                                          });
                                        },
                                      ),
                                      title: Text(
                                        'Until',
                                        style: AppTextStyles.medium18
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
