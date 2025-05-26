import 'package:intl/intl.dart';

String convertTimeTo12HourFormat(String time) {
  DateTime dateTime = DateFormat('HH:mm').parse(time);
  return DateFormat('hh:mm a').format(dateTime);
}
