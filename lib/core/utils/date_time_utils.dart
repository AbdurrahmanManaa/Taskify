import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTimeTo12Hour(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  static DateTime parseDate(String formattedDate) {
    return DateFormat('yyyy-MM-dd').parse(formattedDate);
  }

  static DateTime parseTime(String formattedTime) {
    return DateFormat('hh:mm a').parse(formattedTime);
  }

  static String formatTimeTo24HourWithSeconds(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  static DateTime parseTimeFrom24HourWithSeconds(String timeString) {
    return DateFormat('HH:mm:ss').parse(timeString);
  }

  static DateTime parseIsoDateTime(String isoString) {
    return DateTime.parse(isoString);
  }

  static String formatIsoDateTime(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static Duration extractTime(DateTime dateTime) {
    return Duration(hours: dateTime.hour, minutes: dateTime.minute);
  }

  static DateTime mergeDateAndTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
