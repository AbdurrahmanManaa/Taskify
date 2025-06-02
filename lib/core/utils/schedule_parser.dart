import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:taskify/features/home/domain/entities/task/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task/task_repeat_entity.dart';

class ScheduleParser {
  static TaskRepeatEntity parseRepeatToEntity(String repeatString) {
    String lower = repeatString.toLowerCase();

    int interval = 1;
    int count = 10;
    List<String> daysOfWeek = weekDays
        .where((day) => day.isSelected == true)
        .map((day) => day.dayKey)
        .toList();
    DateTime untilDate = DateTime.now();
    String duration = 'Forever';
    String option = 'Don\'t repeat';

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
      duration = 'Until';
    } else if (count > 0) {
      duration = 'Specific number of times';
    } else {
      duration = 'Forever';
    }

    const allWeekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    for (final day in allWeekDays) {
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

  static String formatUnit(
    int count,
    String singular,
    String plural,
  ) {
    return count == 1 ? singular : plural;
  }

  static String getRepeatUnit(String value) {
    switch (value) {
      case "Everyday":
        return "day";
      case "Every week":
        return "week";
      case "Every month":
        return "month";
      case "Every year":
        return "year";
      default:
        return "day";
    }
  }

  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return "th";
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  static String formatRepeat(TaskRepeatEntity repeat) {
    if (repeat.option == "Don't repeat") return "Don't repeat";

    String option = repeat.option;
    int interval = repeat.interval;
    String duration = repeat.duration;
    int count = repeat.count;
    List<String> weekDays =
        repeat.weekDays.where((day) => !day.contains("Until")).toList();
    DateTime? untilDate = repeat.untilDate;

    String unit = ScheduleParser.getRepeatUnit(option);
    String formattedUnit = (interval == 1) ? unit : '${unit}s';
    String repeatString =
        (interval == 1) ? "Every $unit" : "Every $interval $formattedUnit";

    if (option == "Every week") {
      List<String> weekOrder = [
        'Sun',
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat'
      ];
      weekDays
          .sort((a, b) => weekOrder.indexOf(a).compareTo(weekOrder.indexOf(b)));

      if (weekDays.isNotEmpty) {
        repeatString += (interval > 1)
            ? " on ${weekDays.join(', ')}"
            : " (${weekDays.join(', ')})";
      }
    }

    if (option == "Every month" || option == "Every year") {
      DateTime now = DateTime.now();
      int day = now.day;
      String monthName = DateFormat("MMM").format(now);

      String onString = option == "Every year"
          ? "On the $day${getDaySuffix(day)} of $monthName"
          : "On the $day${getDaySuffix(day)}";

      repeatString = interval == 1
          ? option == "Every year"
              ? "Every year ($onString)"
              : "Every month ($onString)"
          : "Every $interval ${unit}s ($onString)";
    }

    if (duration == "Specific number of times") {
      repeatString += (count == 1) ? " (once)" : " ($count times)";
    }

    if (duration.contains("Until")) {
      try {
        String formattedDate = DateFormat("EEE, MMM d, y").format(
          untilDate ?? DateTime.now(),
        );
        repeatString += ", Until $formattedDate";
      } catch (e) {
        log("ERROR: Invalid untilDate format -> $untilDate");
      }
    }

    return repeatString;
  }

  static String formatReminder(TaskReminderEntity reminder) {
    if (reminder.value == 0) {
      return "At time of event";
    }

    String unit = formatUnit(reminder.value,
        reminder.unit.substring(0, reminder.unit.length - 1), reminder.unit);

    return '${reminder.value} $unit before';
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

  static TaskReminderEntity parseReminder(String input) {
    switch (input) {
      case 'At time of event':
        return TaskReminderEntity(
          option: input,
          value: 0,
          unit: 'Minutes',
        );
      case '10 mins before':
        return TaskReminderEntity(
          option: input,
          value: 10,
          unit: 'Minutes',
        );
      case '1 hour before':
        return TaskReminderEntity(
          option: input,
          value: 1,
          unit: 'Hours',
        );
      case '1 day before':
        return TaskReminderEntity(
          option: input,
          value: 1,
          unit: 'Days',
        );
      default:
        return TaskReminderEntity(
          option: 'Custom',
          value: 10,
          unit: 'Minutes',
        );
    }
  }
}
