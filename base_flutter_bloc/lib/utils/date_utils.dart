import 'package:intl/intl.dart';

const String PATTERN_1 = "dd/MM/yyyy";
const String PATTERN_2 = "dd/MM";
const String PATTERN_3 = "yyyy-MM-dd'T'HH:mm:ss";
const String PATTERN_4 = "h:mm a dd/MM";
const String PATTERN_5 = "yyyy-MM-dd HH:mm:ss";
const String PATTERN_6 = "dd/MM/yyyy HH:mm";
const String PATTERN_7 = "HH:mm dd/MM/yyyy";
const String PATTERN_DEFAULT = "yyyy-MM-dd";

String convertDateToString(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime);
}

DateTime convertStringToDate(String dateTime) {
  return DateTime.parse(dateTime);
}

String convertDateToStringDefault(DateTime dateTime) {
  return DateFormat(PATTERN_DEFAULT).format(dateTime);
}

String changeDateString(String date, {String pattern = PATTERN_1}) {
  date = date.replaceAll('/', '');
  date = DateFormat(pattern).format(DateTime.parse(date));
  return date;
}

// List<String> getDateFromChip(String date) {
//   List<String> listDate = [];
//   if (date == AppStr.toDay) {
//     listDate.add(DateFormat(PATTERN_1).format(DateTime.now()));
//   } else if (date == AppStr.thisWeek) {
//     listDate.add(_getFirstDay(Time.thisWeek));
//     listDate.add(_getLastDay(Time.thisWeek));
//   } else if (date == AppStr.lastWeek) {
//     listDate.add(_getFirstDay(Time.lastWeek));
//     listDate.add(_getLastDay(Time.lastWeek));
//   } else if (date == AppStr.thisMonth) {
//     listDate.add(_getFirstDay(Time.thisMonth));
//     listDate.add(_getLastDay(Time.thisMonth));
//   } else {
//     listDate.add(_getFirstDay(Time.lastMonth));
//     listDate.add(_getLastDay(Time.lastMonth));
//   }
//   return listDate;
// }

String _getFirstDay(Time time) {
  int dayOfWeek = 1; // dùng để lấy ngày đầu tiên trong tuần hiện tại
  DateTime date = DateTime.now();
  if (time == Time.lastWeek) {
    dayOfWeek = -6; // dùng để lấy ngày đầu tiên trong tuần trước đó
  }
  // lấy ngày đầu tiên trong tháng
  if (time == Time.thisMonth || time == Time.lastMonth) {
    var firstDayOfMonth;
    time == Time.lastMonth
        ? firstDayOfMonth = DateTime(
            date.year, date.month - 1, 1) // lấy ngày đầu tiên tháng trước đó
        : firstDayOfMonth = DateTime(
            date.year, date.month, 1); // lấy ngày đầu tiên tháng hiện tại
    return DateFormat(PATTERN_1).format(firstDayOfMonth);
  }
  var monday = date.subtract(Duration(days: date.weekday - dayOfWeek));
  return DateFormat(PATTERN_1).format(monday);
}

String _getLastDay(Time time) {
  DateTime date = DateTime.now();
  int dayOfWeek = 7; // dùng để lấy ngày cuối cùng trong tuần hiện tại
  if (time == Time.lastWeek) {
    dayOfWeek = 0; // dùng để lấy ngày cuối cùng trong tuần trước
  }
  if (time == Time.thisMonth || time == Time.lastMonth) {
    var lastDayOfMonth;
    // lấy ngày cuối cùng tháng hiện tại
    if (time == Time.thisMonth) {
      var beginningNextMonth = (date.month < 12)
          ? DateTime(date.year, date.month + 1, 1)
          : DateTime(date.year + 1, 1, 1);
      int lastDay = beginningNextMonth.subtract(Duration(days: 1)).day;
      lastDayOfMonth = DateTime(date.year, date.month, lastDay);
    } else {
      // lấy ngày cuối cùng tháng trước đó
      var beginningNextMonth = (date.month < 12)
          ? DateTime(date.year, date.month, 1)
          : DateTime(date.year + 1, 0, 1);
      int lastDay = beginningNextMonth.subtract(Duration(days: 1)).day;
      lastDayOfMonth = DateTime(date.year, date.month - 1, lastDay);
    }

    return DateFormat(PATTERN_1).format(lastDayOfMonth);
  }
  var sunday = date.subtract(Duration(days: date.weekday - dayOfWeek));
  return DateFormat(PATTERN_1).format(sunday);
}

enum Time { thisWeek, lastWeek, thisMonth, lastMonth }
