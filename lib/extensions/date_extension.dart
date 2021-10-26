extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime dt) {
    return year == dt.year && month == dt.month && day == dt.day;
  }

  bool isBetweenDate(DateTime from, DateTime end) {
    return isAfter(from) && isBefore(end);
  }
}
