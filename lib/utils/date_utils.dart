import 'package:intl/intl.dart';

class DateUtilsLogic {
  static DateTime getStartOfWeek(DateTime date) {
    var newDate = DateTime(date.year, date.month, date.day);
    while (newDate.weekday != 1) {
      newDate = newDate.add(const Duration(days: -1));
    }
    return newDate;
  }

  static DateTime getEndOfWeek(DateTime startOfWeek) {
    return startOfWeek.add(const Duration(days: 6));
  }

  static DateTime getNextWeek(DateTime startOfWeek) {
    return startOfWeek.add(const Duration(days: 7));
  }

  static DateTime getPreviousWeek(DateTime startOfWeek) {
    return startOfWeek.add(const Duration(days: -7));
  }

  static String dateFormatYYYYMMDD(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String dateFormatMMMMYYYY(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getSubTitle(DateTime date, int index) {
    DateTime dateOutput = date.add(Duration(days: index));
    final String formatted =
        "${DateUtilsLogic.getDayOfWeek(dateOutput.weekday)}";
    return formatted;
  }

  static String addDate(DateTime date, int index) {
    DateTime dateOutput = date.add(Duration(days: index));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateOutput);
    return formatted;
  }
    static String getYYYYMMDDFormat(DateTime date,) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String convertDate({
    required String sourceDateStr,
     String from = "yyyy-MM-ddTHH:mm:ss.SSS",
     String to = "yyyy-MM-dd",
    bool? convert = false,
  }) {
    if (sourceDateStr.isNotEmpty) {
      var fromDateFormat = DateFormat(from);
      var toDateFormat = DateFormat(to);
      var tempDate = fromDateFormat.parse(sourceDateStr);

      if (convert == true) {
        var offset = DateTime.now().timeZoneOffset;
        var localDate = tempDate.add(offset);

        return toDateFormat.format(localDate);
      } else {
        return toDateFormat.format(tempDate);
      }
    } else {
      return '';
    }
  }
  static String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

      default:
        return "Mon";
    }
  }
}
