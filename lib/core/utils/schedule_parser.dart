import 'dart:developer';

import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';
import 'package:taskify/generated/l10n.dart';

class ScheduleParser {
  static TaskRepeatEntity parseRepeatToEntity(
    String repeatString,
    BuildContext context,
  ) {
    String lower = repeatString.toLowerCase();
    final weekDays = ScheduleParser.getWeekDays(context);
    final repeatOptions = ScheduleParser.getRepeatOptions(context);
    final shortDays = ScheduleParser.getShortDays(context);

    int interval = 1;
    int count = 10;
    List<String> daysOfWeek = weekDays
        .where((day) => day.isSelected == true)
        .map((day) => day.dayKey)
        .toList();
    DateTime untilDate = DateTime.now();
    String duration = S.of(context).repeatDuration1;
    String option = S.of(context).repeatOption1;

    for (final opt in repeatOptions) {
      final optLower = opt.toLowerCase();
      if (lower.startsWith(optLower)) {
        option = opt;
        final intervalRegex = RegExp(r'Every (\d+)');
        final match = intervalRegex.firstMatch(repeatString);
        if (match != null) {
          interval = int.tryParse(match.group(1)!) ?? 1;
        }
        break;
      }
    }

    final countRegex = RegExp(r'\((\d+)\s+times\)');
    final countMatch = countRegex.firstMatch(repeatString);
    if (countMatch != null) {
      count = int.tryParse(countMatch.group(1)!) ?? 0;
    }

    final untilDateRegex = RegExp(r'Until (\w{3}, \w{3} \d{1,2}, \d{4})');
    final untilMatch = untilDateRegex.firstMatch(repeatString);
    if (untilMatch != null) {
      try {
        untilDate = DateFormat("EEE, MMM d, y").parse(untilMatch.group(1)!);
      } catch (e) {
        log("ERROR: Failed to parse untilDate -> ${untilMatch.group(1)}");
      }
    }

    if (untilMatch != null) {
      duration = S.of(context).repeatDuration3;
    } else if (count > 0) {
      duration = S.of(context).repeatDuration2;
    } else {
      duration = S.of(context).repeatDuration1;
    }

    for (final day in shortDays) {
      if (RegExp(r'\b' + day.toLowerCase() + r'\b').hasMatch(lower)) {
        daysOfWeek.add(day);
      }
    }

    return TaskRepeatEntity(
      interval: interval,
      option: option,
      duration: duration,
      count: count,
      weekDays: daysOfWeek,
      untilDate: untilDate,
    );
  }

  static String formatUnit(BuildContext context, int count, String unit) {
    if (count == 1) {
      if (unit == "day") return S.of(context).day;
      if (unit == "month") return S.of(context).month;
      if (unit == "year") return S.of(context).year;
    } else {
      if (unit == "day") return S.of(context).days;
      if (unit == "month") return S.of(context).months;
      if (unit == "year") return S.of(context).years;
    }

    return '';
  }

  static String getRepeatUnit(BuildContext context, String value) {
    switch (value) {
      case "Everyday":
        return S.of(context).day;
      case "Every week":
        return S.of(context).week;
      case "Every month":
        return S.of(context).month;
      case "Every year":
        return S.of(context).year;
      default:
        return S.of(context).day;
    }
  }

  static String getDaySuffix(BuildContext context, int day) {
    if (day >= 11 && day <= 13) return S.of(context).aboveThressShort;
    switch (day % 10) {
      case 1:
        return S.of(context).firstShort;
      case 2:
        return S.of(context).secondShort;
      case 3:
        return S.of(context).thirdShort;
      default:
        return S.of(context).aboveThressShort;
    }
  }

  static String formatRepeat(BuildContext context, TaskRepeatEntity repeat) {
    if (repeat.option == S.of(context).repeatOption1) {
      return S.of(context).repeatOption1;
    }

    String option = repeat.option;
    int interval = repeat.interval;
    String duration = repeat.duration;
    int count = repeat.count;
    List<String> weekDays = repeat.weekDays
        .where((day) => !day.contains(S.of(context).repeatDuration3))
        .toList();
    DateTime? untilDate = repeat.untilDate;

    String unit = ScheduleParser.getRepeatUnit(
      context,
      option,
    );
    String formattedUnit = formatUnit(context, interval, unit);
    String repeatString = (interval == 1)
        ? S.of(context).everySingle(unit)
        : S.of(context).everyString(
              interval,
              formattedUnit,
            );

    if (option == S.of(context).repeatOption3) {
      List<String> weekOrder = [
        S.of(context).sundayShort,
        S.of(context).mondayShort,
        S.of(context).thursdayShort,
        S.of(context).wednesdayShort,
        S.of(context).thursdayShort,
        S.of(context).fridayShort,
        S.of(context).saturdayShort,
      ];
      weekDays
          .sort((a, b) => weekOrder.indexOf(a).compareTo(weekOrder.indexOf(b)));

      if (weekDays.isNotEmpty) {
        repeatString += (interval > 1)
            ? S.of(context).everyWeekOn(weekDays.join(', '))
            : S.of(context).everyOtherWeekOn(
                  interval,
                  weekDays.join(', '),
                );
      }
    }

    if (option == S.of(context).repeatOption4 ||
        option == S.of(context).repeatOption5) {
      DateTime now = DateTime.now();
      int day = now.day;
      String suffix = getDaySuffix(context, day);
      String monthName = DateFormat("MMM").format(now);
      String onString = S.of(context).onString(day, suffix, monthName);

      repeatString = interval == 1
          ? option == S.of(context).repeatOption5
              ? S.of(context).everyYearOn(onString)
              : S.of(context).everyMonthOn(onString)
          : option == S.of(context).repeatOption5
              ? S.of(context).everyOtherYearOn(interval, onString)
              : S.of(context).everyOtherMonthOn(interval, onString);
    }

    if (duration == S.of(context).repeatDuration2) {
      repeatString +=
          (count == 1) ? S.of(context).once : S.of(context).times(count);
    }

    if (duration.contains(S.of(context).repeatDuration3)) {
      try {
        String formattedDate = DateFormat("EEE, MMM d, y").format(
          untilDate ?? DateTime.now(),
        );
        repeatString += S.of(context).until(formattedDate);
      } catch (e) {
        log("ERROR: Invalid untilDate format -> $untilDate");
      }
    }

    return repeatString;
  }

  static String formatReminder(
      BuildContext context, TaskReminderEntity reminder) {
    if (reminder.value == 0) {
      return S.of(context).reminderOption1;
    }

    String formattedUnit =
        formatUnit(context, reminder.value, reminder.unit.toLowerCase());

    return S.of(context).selectedTaskReminder(reminder.value, formattedUnit);
  }

  static int convertReminderToMinutes(TaskReminderEntity reminder) {
    switch (reminder.unit) {
      case 'Minutes':
        return reminder.value;
      case 'Hours':
        return reminder.value * 60;
      case 'Days':
        return reminder.value * 1440;
      case 'Weeks':
        return reminder.value * 10080;
      default:
        return reminder.value;
    }
  }

  static TaskReminderEntity parseReminder(BuildContext context, String input) {
    switch (input) {
      case 'At time of event':
        return TaskReminderEntity(
          option: input,
          value: 0,
          unit: S.of(context).reminderUnit1,
        );
      case '10 mins before':
        return TaskReminderEntity(
          option: input,
          value: 10,
          unit: S.of(context).reminderUnit1,
        );
      case '1 hour before':
        return TaskReminderEntity(
          option: input,
          value: 1,
          unit: S.of(context).reminderUnit2,
        );
      case '1 day before':
        return TaskReminderEntity(
          option: input,
          value: 1,
          unit: S.of(context).reminderUnit3,
        );
      default:
        return TaskReminderEntity(
          option: 'Custom',
          value: 10,
          unit: S.of(context).reminderUnit1,
        );
    }
  }

  static List<String> getRepeatOptions(BuildContext context) {
    return [
      S.of(context).repeatOption1,
      S.of(context).repeatOption2,
      S.of(context).repeatOption3,
      S.of(context).repeatOption4,
      S.of(context).repeatOption5,
    ];
  }

  static List<String> getRepeatDurations(BuildContext context) {
    return [
      S.of(context).repeatDuration1,
      S.of(context).repeatDuration2,
      S.of(context).repeatDuration3,
    ];
  }

  static List<String> getRepeatDays(BuildContext context) {
    return [
      S.of(context).saturday,
      S.of(context).sunday,
      S.of(context).monday,
      S.of(context).tuesday,
      S.of(context).wednesday,
      S.of(context).thursday,
      S.of(context).friday,
    ];
  }

  static List<DayInWeek> getWeekDays(BuildContext context) {
    return [
      DayInWeek(S.of(context).sunday, dayKey: S.of(context).sundayShort),
      DayInWeek(
        S.of(context).monday,
        dayKey: S.of(context).mondayShort,
      ),
      DayInWeek(
        S.of(context).tuesday,
        dayKey: S.of(context).tuesdayShort,
      ),
      DayInWeek(S.of(context).wednesday,
          dayKey: S.of(context).wednesdayShort, isSelected: true),
      DayInWeek(
        S.of(context).thursday,
        dayKey: S.of(context).thursdayShort,
      ),
      DayInWeek(
        S.of(context).friday,
        dayKey: S.of(context).fridayShort,
      ),
      DayInWeek(
        S.of(context).saturday,
        dayKey: S.of(context).saturdayShort,
      ),
    ];
  }

  static Map<String, int> getRepeatMaxValues(BuildContext context) {
    return {
      S.of(context).repeatOption2: 365,
      S.of(context).repeatOption3: 52,
      S.of(context).repeatOption4: 12,
      S.of(context).repeatOption5: 10,
      S.of(context).repeatDuration2: 100,
    };
  }

  static List<String> getShortDays(BuildContext context) {
    return [
      S.of(context).sundayShort,
      S.of(context).mondayShort,
      S.of(context).tuesdayShort,
      S.of(context).wednesdayShort,
      S.of(context).thursdayShort,
      S.of(context).fridayShort,
      S.of(context).saturdayShort,
    ];
  }
}
