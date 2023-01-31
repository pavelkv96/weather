import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get today => DateTime(year, month, day);

  String toStringFormat({String pattern = 'dd.MM.yyyy', String locale = 'en_US'}) {
    return DateFormat(pattern, locale).format(this);
  }
}
