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
import 'package:taskify/generated/l10n.dart';

class TaskRepeatViewBody extends StatefulWidget {
  const TaskRepeatViewBody({super.key});

  @override
  State<TaskRepeatViewBody> createState() => _TaskRepeatViewBodyState();
}

class _TaskRepeatViewBodyState extends State<TaskRepeatViewBody> {
  late final TextEditingController _intervalController;
  late final TextEditingController _countController;
  late String _selectedOption;
  late String _selectedDuration;
  late List<String> _selectedWeekDays;
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
        _selectedOption = S.of(context).custom;
      }
    });
  }

  void toggleDurationContent() {
    setState(() {
      _isDurationSelected = !_isDurationSelected;
      if (_isDurationSelected) {
        _selectedDuration = S.of(context).custom;
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

  SelectWeekDays _buildWeekDaysWidget(BuildContext context) {
    final weekDays = ScheduleParser.getWeekDays(context);

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

  Text _formatUnit(BuildContext context) {
    if (_intervalController.text.isEmpty) {
      return Text('');
    }
    final count = int.tryParse(_intervalController.text) ?? 0;
    final repeatOption = _selectedOption;
    final repeatUnit = ScheduleParser.getRepeatUnit(context, repeatOption);
    final unit = ScheduleParser.formatUnit(context, count, repeatUnit);
    return Text(
      ' $unit',
      style: AppTextStyles.medium16.copyWith(color: Colors.black),
    );
  }

  String _formatRepeatText(BuildContext context) {
    List<String> selectedDays = _selectedWeekDays;

    if (_selectedOption == S.of(context).repeatOption1) {
      return S.of(context).repeatDescriptionDontRepeat;
    } else if (_selectedOption == S.of(context).repeatOption2) {
      return _selectedInterval == 0
          ? S.of(context).repeatDescriptionEveryday
          : S
              .of(context)
              .repeatDescriptionEveryOtherDay(_selectedInterval.toString());
    } else if (_selectedOption == S.of(context).repeatOption3) {
      return _selectedInterval == 0
          ? S.of(context).repeatDescriptionEveryWeek(selectedDays.join(', '))
          : S.of(context).repeatDescriptionEveryOtherWeek(
              _selectedInterval.toString(), selectedDays.join(', '));
    } else if (_selectedOption == S.of(context).repeatOption4) {
      return _selectedInterval == 0
          ? S.of(context).repeatDescriptionEveryMonth
          : S
              .of(context)
              .repeatDescriptionEveryOtherMonth(_selectedInterval.toString());
    } else if (_selectedOption == S.of(context).repeatOption5) {
      return _selectedInterval == 0
          ? S.of(context).repeatDescriptionEveryYear
          : S
              .of(context)
              .repeatDescriptionEveryOtherYear(_selectedInterval.toString());
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    _selectedOption = S.of(context).repeatOption1;
    _selectedDuration = S.of(context).repeatDuration1;
    final repeatMaxValues = ScheduleParser.getRepeatMaxValues(context);
    _selectedWeekDays = ScheduleParser.getWeekDays(context)
        .where((day) => day.isSelected == true)
        .map((day) => day.dayKey)
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomAppbar(
              title: S.of(context).repeatAppBar,
              result: TaskRepeatEntity(
                interval: _selectedInterval,
                option: _selectedOption,
                duration: _selectedDuration,
                count: _selectedCount,
                weekDays: _selectedWeekDays,
                untilDate: _selectedDate,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _formatRepeatText(context),
              style: AppTextStyles.medium18,
            ),
            const SizedBox(height: 20),
            CustomWrapperContainer(
              child: Column(
                children: [
                  OptionItem(
                    leading: Radio(
                      value: S.of(context).repeatOption1,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      S.of(context).repeatOption1,
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == S.of(context).repeatOption2
                        ? OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption2,
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
                                  S.of(context).every,
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
                                _formatUnit(context),
                              ],
                            ),
                          )
                        : OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption2,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              S.of(context).repeatOption2,
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == S.of(context).repeatOption3
                        ? Column(
                            children: [
                              OptionItem(
                                leading: Radio(
                                  value: S.of(context).repeatOption3,
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
                                      S.of(context).every,
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
                                    _formatUnit(context),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              _buildWeekDaysWidget(context),
                            ],
                          )
                        : OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption3,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              S.of(context).repeatOption3,
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == S.of(context).repeatOption4
                        ? OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption4,
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
                                  S.of(context).every,
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
                                _formatUnit(context),
                              ],
                            ),
                          )
                        : OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption4,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              S.of(context).repeatOption4,
                              style: AppTextStyles.medium18
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  Divider(),
                  CustomAnimatedSwitcher(
                    child: _selectedOption == S.of(context).repeatOption5
                        ? OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption5,
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
                                  S.of(context).every,
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
                                _formatUnit(context),
                              ],
                            ),
                          )
                        : OptionItem(
                            leading: Radio(
                              value: S.of(context).repeatOption5,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  _isSelected = false;
                                });
                              },
                            ),
                            title: Text(
                              S.of(context).repeatOption5,
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
              visible: _selectedOption != S.of(context).repeatOption1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).duration,
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
                                value: S.of(context).repeatDuration1,
                                groupValue: _selectedDuration,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDuration = value!;
                                    _isDurationSelected = false;
                                  });
                                },
                              ),
                              title: Text(
                                S.of(context).repeatDuration1,
                                style: AppTextStyles.medium18
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Divider(),
                            CustomAnimatedSwitcher(
                                child: _selectedDuration ==
                                        S.of(context).repeatDuration2
                                    ? OptionItem(
                                        leading: Radio(
                                          value: S.of(context).repeatDuration2,
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
                                                    int maxValue =
                                                        repeatMaxValues[S
                                                            .of(context)
                                                            .repeatDuration2]!;
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
                                                          .isEmpty ||
                                                      _selectedCount == 1
                                                  ? S.of(context).timeTotal
                                                  : S.of(context).timesTotal,
                                              style: AppTextStyles.medium16
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    : OptionItem(
                                        leading: Radio(
                                          value: S.of(context).repeatDuration2,
                                          groupValue: _selectedDuration,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedDuration = value!;
                                              _isDurationSelected = false;
                                            });
                                          },
                                        ),
                                        title: Text(
                                          S.of(context).repeatDuration2,
                                          style: AppTextStyles.medium18
                                              .copyWith(color: Colors.black),
                                        ),
                                      )),
                            Divider(),
                            CustomAnimatedSwitcher(
                              child: _selectedDuration ==
                                      S.of(context).repeatDuration3
                                  ? Column(
                                      children: [
                                        OptionItem(
                                          leading: Radio(
                                            value:
                                                S.of(context).repeatDuration3,
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
                                                S.of(context).repeatDuration3,
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
                                        value: S.of(context).repeatDuration3,
                                        groupValue: _selectedDuration,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedDuration = value!;
                                            _isDurationSelected = false;
                                          });
                                        },
                                      ),
                                      title: Text(
                                        S.of(context).repeatDuration3,
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
