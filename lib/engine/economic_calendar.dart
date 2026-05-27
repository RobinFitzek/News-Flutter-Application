import '../data/datasources/remote/yahoo_finance_client.dart';

/// Upcoming macro + earnings events — mirrors economic_calendar.py.
class EconomicCalendar {
  EconomicCalendar({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  List<Map<String, dynamic>>? _cache;
  DateTime? _cacheTime;
  static const _cacheDuration = Duration(hours: 4);

  static const _fomcDates = [
    '2025-01-29', '2025-03-19', '2025-05-07', '2025-06-18',
    '2025-07-30', '2025-09-17', '2025-11-05', '2025-12-17',
    '2026-01-28', '2026-03-18', '2026-04-29', '2026-06-17',
    '2026-07-29', '2026-09-16', '2026-11-04', '2026-12-16',
  ];

  Future<List<Map<String, dynamic>>> getUpcomingEvents({
    int daysAhead = 14,
    List<String> watchlistSymbols = const [],
  }) async {
    if (_cache != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheDuration) {
      return _cache!;
    }

    final events = <Map<String, dynamic>>[];
    final today = DateTime.now();
    final end = today.add(Duration(days: daysAhead));

    for (final dateStr in _fomcDates) {
      final d = DateTime.parse(dateStr);
      if (d.isAfter(today.subtract(const Duration(days: 1))) && d.isBefore(end)) {
        events.add({
          'date': d,
          'type': 'FOMC',
          'name': 'FOMC Meeting',
          'impact': 'high',
          'symbol': 'MACRO',
        });
      }
    }

    for (var i = 0; i <= 2; i++) {
      final month = DateTime(today.year, today.month + i, 1);
      final cpiDay = DateTime(month.year, month.month, 13);
      if (cpiDay.isAfter(today.subtract(const Duration(days: 1))) &&
          cpiDay.isBefore(end)) {
        events.add({
          'date': cpiDay,
          'type': 'CPI',
          'name': 'CPI Report',
          'impact': 'high',
          'symbol': 'MACRO',
        });
      }

      final jobsDate = _firstFriday(month.year, month.month);
      if (jobsDate.isAfter(today.subtract(const Duration(days: 1))) &&
          jobsDate.isBefore(end)) {
        events.add({
          'date': jobsDate,
          'type': 'Jobs',
          'name': 'Non-Farm Payrolls',
          'impact': 'high',
          'symbol': 'MACRO',
        });
      }
    }

    final symbols = watchlistSymbols.isEmpty
        ? ['AAPL', 'MSFT', 'SPY']
        : watchlistSymbols;

    for (final sym in symbols.take(8)) {
      try {
        final earnings = await _yahoo.getEarningsHistory(sym);
        for (final e in earnings) {
          final date = DateTime.parse(e['reportDate'] as String);
          if (date.isAfter(today.subtract(const Duration(days: 1))) &&
              date.isBefore(end)) {
            events.add({
              'date': date,
              'type': 'earnings',
              'name': '${e['period'] ?? 'Q'} Earnings',
              'impact': 'medium',
              'symbol': sym.toUpperCase(),
              'estimated_eps': e['estimatedEps'],
            });
          }
        }
      } catch (_) {}
    }

    events.sort((a, b) =>
        (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    _cache = events;
    _cacheTime = DateTime.now();
    return events;
  }

  DateTime _firstFriday(int year, int month) {
    var d = DateTime(year, month, 1);
    while (d.weekday != DateTime.friday) {
      d = d.add(const Duration(days: 1));
    }
    return d;
  }
}
