import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_animated_switcher.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_wrapper_container.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/home/domain/entities/task_reminder_entity.dart';

class TaskReminderViewBody extends StatefulWidget {
  const TaskReminderViewBody({super.key});

  @override
  State<TaskReminderViewBody> createState() => _TaskReminderViewBodyState();
}

class _TaskReminderViewBodyState extends State<TaskReminderViewBody>
    with TickerProviderStateMixin {
  String _selectedOption = '10 mins before';
  int _selectedValue = 5;
  String _selectedUnit = 'Minutes';
  bool _isSelected = false;

  void toggleContent() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        _selectedOption = 'Custom';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAppbar(
              title: 'Task Reminder',
              result: TaskReminderEntity(
                option: _selectedOption,
                value: _selectedValue,
                unit: _selectedUnit,
              ),
            ),
            const SizedBox(height: 30),
            CustomWrapperContainer(
              child: Column(
                children: [
                  OptionItem(
                    leading: Radio(
                      value: 'At time of event',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      'At time of event',
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  OptionItem(
                    leading: Radio(
                      value: '10 mins before',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      '10 mins before',
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  OptionItem(
                    leading: Radio(
                      value: '1 hour before',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      '1 hour before',
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  OptionItem(
                    leading: Radio(
                      value: '1 day before',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      '1 day before',
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomWrapperContainer(
              child: GestureDetector(
                onTap: toggleContent,
                child: CustomAnimatedSwitcher(
                  child: _selectedOption == 'Custom'
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 'Custom',
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value!;
                                      _isSelected = false;
                                    });
                                  },
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _selectedValue == 0
                                      ? 'At time of event'
                                      : '$_selectedValue ${_selectedUnit.substring(0, _selectedUnit.length - 1)} before',
                                  style: AppTextStyles.regular18,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CupertinoPicker(
                                      looping: true,
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: _selectedValue),
                                      itemExtent: 40,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          _selectedValue = index;
                                          _selectedOption = 'Custom';
                                        });
                                      },
                                      children: List.generate(
                                          reminderMaxValues[_selectedUnit]! + 1,
                                          (index) {
                                        return Center(
                                          child: Text(
                                            "$index",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Expanded(
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                        initialItem: reminderUnits
                                            .indexOf(_selectedUnit),
                                      ),
                                      itemExtent: 40,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          _selectedUnit = reminderUnits[index];
                                          _selectedOption = 'Custom';
                                        });
                                      },
                                      children: reminderUnits.map((unit) {
                                        return Center(
                                          child: Text(
                                            _selectedValue == 1
                                                ? unit.substring(
                                                    0, unit.length - 1)
                                                : unit,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : OptionItem(
                          leading: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          title: Text(
                            'Custom',
                            style: AppTextStyles.medium18
                                .copyWith(color: Colors.black),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
