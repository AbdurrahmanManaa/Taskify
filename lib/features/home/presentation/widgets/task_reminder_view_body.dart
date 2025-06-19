import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/utils/app_text_styles.dart';
import 'package:taskify/core/widgets/custom_animated_switcher.dart';
import 'package:taskify/core/widgets/custom_appbar.dart';
import 'package:taskify/core/widgets/custom_wrapper_container.dart';
import 'package:taskify/core/widgets/option_item.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/generated/l10n.dart';

class TaskReminderViewBody extends StatefulWidget {
  const TaskReminderViewBody({super.key});

  @override
  State<TaskReminderViewBody> createState() => _TaskReminderViewBodyState();
}

class _TaskReminderViewBodyState extends State<TaskReminderViewBody>
    with TickerProviderStateMixin {
  late String _selectedOption;
  int _selectedValue = 5;
  late String _selectedUnit;
  bool _isSelected = false;

  void toggleContent() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        _selectedOption = S.of(context).custom;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedOption = S.of(context).reminderOption2;
    _selectedUnit = S.of(context).reminderUnit1;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAppbar(
              title: S.of(context).reminderAppBar,
              result: TaskReminderEntity(
                option: _selectedOption,
                value: _selectedValue,
                unit: _selectedUnit,
              ),
            ),
            const SizedBox(height: 20),
            CustomWrapperContainer(
              child: Column(
                children: [
                  OptionItem(
                    leading: Radio(
                      value: S.of(context).reminderOption1,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      S.of(context).reminderOption1,
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  OptionItem(
                    leading: Radio(
                      value: S.of(context).reminderOption2,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      S.of(context).reminderOption2,
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  OptionItem(
                    leading: Radio(
                      value: S.of(context).reminderOption3,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      S.of(context).reminderOption3,
                      style:
                          AppTextStyles.medium18.copyWith(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  OptionItem(
                    leading: Radio(
                      value: S.of(context).reminderOption4,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          _isSelected = false;
                        });
                      },
                    ),
                    title: Text(
                      S.of(context).reminderOption4,
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
                  child: _selectedOption == S.of(context).custom
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: S.of(context).custom,
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
                                      ? S.of(context).reminderOption1
                                      : S.of(context).selectedTaskReminder(
                                          _selectedValue.toString(),
                                          _selectedUnit.substring(
                                              0, _selectedUnit.length - 1)),
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
                                          _selectedOption =
                                              S.of(context).custom;
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
                                          _selectedOption =
                                              S.of(context).custom;
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
                            S.of(context).custom,
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
