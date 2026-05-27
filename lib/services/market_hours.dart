/// US market hours and holiday helpers — mirrors server active-hours gate.
class MarketHours {
  static const defaultActiveStartHour = 7;
  static const defaultActiveEndHour = 22;

  static bool isWeekday(DateTime dt) {
    return dt.weekday >= DateTime.monday && dt.weekday <= DateTime.friday;
  }

  static bool isWithinActiveHours({
    required DateTime now,
    int startHour = defaultActiveStartHour,
    int endHour = defaultActiveEndHour,
  }) {
    return now.hour >= startHour && now.hour < endHour;
  }

  /// Simplified US market holiday list (NYSE observed dates).
  static bool isUsMarketHoliday(DateTime dt) {
    final d = DateTime(dt.year, dt.month, dt.day);
    final holidays = _holidaysForYear(dt.year);
    return holidays.any((h) =>
        h.year == d.year && h.month == d.month && h.day == d.day);
  }

  static bool shouldRunMarketJob(DateTime now, {int? startHour, int? endHour}) {
    if (!isWeekday(now)) return false;
    if (isUsMarketHoliday(now)) return false;
    return isWithinActiveHours(
      now: now,
      startHour: startHour ?? defaultActiveStartHour,
      endHour: endHour ?? defaultActiveEndHour,
    );
  }

  static List<DateTime> _holidaysForYear(int year) {
    return [
      DateTime(year, 1, 1),
      _nthWeekday(year, 1, DateTime.monday, 3),
      _lastWeekday(year, 5, DateTime.monday),
      DateTime(year, 6, 19),
      DateTime(year, 7, 4),
      _nthWeekday(year, 9, DateTime.monday, 1),
      _nthWeekday(year, 11, DateTime.thursday, 4),
      DateTime(year, 12, 25),
    ];
  }

  static DateTime _nthWeekday(int year, int month, int weekday, int n) {
    var count = 0;
    for (var day = 1; day <= 31; day++) {
      final dt = DateTime(year, month, day);
      if (dt.month != month) break;
      if (dt.weekday == weekday) {
        count++;
        if (count == n) return dt;
      }
    }
    return DateTime(year, month, 1);
  }

  static DateTime _lastWeekday(int year, int month, int weekday) {
    for (var day = 31; day >= 1; day--) {
      final dt = DateTime(year, month, day);
      if (dt.month != month) continue;
      if (dt.weekday == weekday) return dt;
    }
    return DateTime(year, month, 1);
  }
}
