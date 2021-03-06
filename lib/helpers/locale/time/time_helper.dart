import 'package:flutter/material.dart';
import 'package:pengo/const/locale_const.dart';

class TimeHelper {
  factory TimeHelper() {
    return _instance;
  }

  TimeHelper._constructor();

  static final TimeHelper _instance = TimeHelper._constructor();

  /// ```
  /// final startTime = TimeOfDay(hour: 9, minute: 0);
  /// final endTime = TimeOfDay(hour: 22, minute: 0);
  /// final step = Duration(minutes: 30);
  /// ```
  ///
  /// Usage
  /// ```
  /// _getTimes(startTime, endTime, step)
  /// ```
  static Iterable<TimeOfDay> _getTimes(
    TimeOfDay startTime,
    TimeOfDay endTime,
    Duration step,
  ) sync* {
    int hour = startTime.hour;
    int minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);

      minute += step.inMinutes;
      debugPrint("min: $minute");

      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  /// Get a list of time slots
  ///
  /// Source: https://stackoverflow.com/a/60371617
  ///
  /// Usage:
  /// ```
  /// getTimeSlots(context, {
  ///   start: "2021-10-01T00:00:00.000+08:00",
  ///   end: "2021-12-31T23:59:59.000+08:00",
  ///   gap: 5,
  ///   units: TIME_GAP_UNITS.minutes
  /// })
  /// ```
  ///
  /// Result:
  /// ```
  /// return ["9:00", "9:30", "10:00", "10:30", ..., "23:30", "00:00"]
  /// ```
  static List<String> getTimeSlots(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    int gap = 5,
    TIME_GAP_UNITS units = TIME_GAP_UNITS.minutes,
  }) {
    final DateTime gmtStartDT = start.toLocal();
    final DateTime gmtEndDT = end.toLocal();

    final TimeOfDay startTime =
        TimeOfDay(hour: gmtStartDT.hour, minute: gmtStartDT.minute);
    final TimeOfDay endTime =
        TimeOfDay(hour: gmtEndDT.hour, minute: gmtEndDT.minute);

    final bool shouldGapByMin = units == TIME_GAP_UNITS.minutes;
    final bool shouldGapByHrs = units == TIME_GAP_UNITS.hours;

    final Duration step = Duration(
      minutes: shouldGapByMin ? gap : 0,
      hours: shouldGapByHrs ? gap : 0,
    );

    final List<String> times = _getTimes(startTime, endTime, step)
        .map((TimeOfDay tod) => tod.format(context))
        .toList();

    return times;
  }
}
