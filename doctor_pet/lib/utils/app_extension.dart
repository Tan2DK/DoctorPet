import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String formatDateTime(String format) {
    return DateFormat(format).format(this);
  }

  DateTime get dateOnly => copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        microsecond: 0,
        millisecond: 0,
      );
}

extension StringX on String {
  DateTime parseDateTime(String parser) {
    return DateFormat(parser).parse(this);
  }
}
