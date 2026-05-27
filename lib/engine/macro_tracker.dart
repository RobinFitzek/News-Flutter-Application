import '../data/datasources/remote/yahoo_finance_client.dart';

/// Macro event tracker — mirrors News/engine/macro_tracker.py.
class MacroTracker {
  MacroTracker({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const fomc2026 = [
    '2026-01-28',
    '2026-03-18',
    '2026-05-06',
    '2026-06-17',
    '2026-07-29',
    '2026-09-16',
    '2026-10-28',
    '2026-12-09',
  ];

  static const ecb2026 = [
    '2026-01-30',
    '2026-03-05',
    '2026-04-16',
    '2026-06-04',
    '2026-07-23',
    '2026-09-10',
    '2026-10-22',
    '2026-12-03',
  ];

  static const rateSensitiveKeywords = [
    'bank',
    'reit',
    'mortgage',
    'insurance',
    'utility',
    'bond',
    'finance',
  ];

  List<Map<String, dynamic>> getUpcomingEvents({int daysAhead = 7}) {
    final today = DateTime.now();
    final cutoff = today.add(Duration(days: daysAhead));
    final events = <Map<String, dynamic>>[];

    for (final d in fomc2026) {
      final dt = DateTime.parse(d);
      if (!dt.isBefore(today) && !dt.isAfter(cutoff)) {
        events.add({
          'type': 'FOMC',
          'date': d,
          'days_until': dt.difference(today).inDays,
          'description': 'Federal Reserve rate decision',
        });
      }
    }
    for (final d in ecb2026) {
      final dt = DateTime.parse(d);
      if (!dt.isBefore(today) && !dt.isAfter(cutoff)) {
        events.add({
          'type': 'ECB',
          'date': d,
          'days_until': dt.difference(today).inDays,
          'description': 'ECB Governing Council rate decision',
        });
      }
    }
    events.sort((a, b) => (a['date'] as String).compareTo(b['date'] as String));
    return events;
  }

  Map<String, dynamic>? getNextEvent() {
    final events = getUpcomingEvents(daysAhead: 90);
    return events.isEmpty ? null : events.first;
  }

  String buildMacroContextBlock() {
    final events = getUpcomingEvents(daysAhead: 14);
    if (events.isEmpty) return '';
    final lines = ['UPCOMING CENTRAL BANK EVENTS:'];
    for (final e in events) {
      lines.add(
        '  - ${e['type']} rate decision: ${e['date']} (in ${e['days_until']} days)',
      );
    }
    lines.add(
      'Consider rate sensitivity. Tighten confidence for rate-sensitive sectors if event within 48h.',
    );
    return lines.join('\n');
  }

  bool isRateSensitive(String ticker, {String name = ''}) {
    final text = '${ticker.toUpperCase()} $name'.toLowerCase();
    return rateSensitiveKeywords.any(text.contains);
  }

  Future<Map<String, dynamic>> fetchSnapshot() async {
    const tickers = {
      'SPY': 'equities',
      'TLT': 'bonds',
      'GLD': 'gold',
      'UUP': 'usd',
      'HYG': 'credit',
    };

    final snapshot = <String, dynamic>{
      'date': DateTime.now().toIso8601String().substring(0, 10),
      'assets': <String, dynamic>{},
    };

    for (final entry in tickers.entries) {
      try {
        final bars = await _yahoo.getOhlcvHistory(entry.key, range: '5d');
        if (bars.length >= 2) {
          final prev = (bars[bars.length - 2]['close'] as num).toDouble();
          final last = (bars.last['close'] as num).toDouble();
          snapshot['assets'][entry.value] = {
            'symbol': entry.key,
            'price': last,
            'change_pct': prev > 0
                ? double.parse(
                    (((last - prev) / prev) * 100).toStringAsFixed(2))
                : 0.0,
          };
        }
      } catch (_) {}
    }

    return snapshot;
  }
}
