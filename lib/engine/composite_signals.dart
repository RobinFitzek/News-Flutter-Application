import '../data/datasources/remote/yahoo_finance_client.dart';

/// Cross-asset composite macro signals — mirrors News/engine/composite_signals.py.
class CompositeSignals {
  CompositeSignals({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const patterns = [
    {
      'name': 'Flight to Safety',
      'description':
          'Gold rising, VIX spiking, equities selling off — risk-off regime.',
      'conditions': [
        {'series': 'GLD', 'direction': 'up', 'threshold': 0.5},
        {'series': '^VIX', 'direction': 'up', 'threshold': 5.0},
        {'series': 'SPY', 'direction': 'down', 'threshold': 0.5},
      ],
      'min_match': 3,
    },
    {
      'name': 'Risk-On Surge',
      'description':
          'Equities rallying, VIX falling, credit tightening — risk-on.',
      'conditions': [
        {'series': 'SPY', 'direction': 'up', 'threshold': 0.5},
        {'series': '^VIX', 'direction': 'down', 'threshold': 5.0},
        {'series': 'HYG', 'direction': 'up', 'threshold': 0.3},
      ],
      'min_match': 3,
    },
    {
      'name': 'Inflation Spike',
      'description': 'Gold up, bonds down, USD weak — inflation surprise.',
      'conditions': [
        {'series': 'GLD', 'direction': 'up', 'threshold': 0.7},
        {'series': 'TLT', 'direction': 'down', 'threshold': 0.5},
        {'series': 'UUP', 'direction': 'down', 'threshold': 0.3},
      ],
      'min_match': 2,
    },
  ];

  Future<List<Map<String, dynamic>>> evaluatePatterns() async {
    final triggered = <Map<String, dynamic>>[];

    for (final pattern in patterns) {
      final conditions = pattern['conditions'] as List;
      final results = <Map<String, dynamic>>[];
      var matched = 0;

      for (final cond in conditions) {
        final series = cond['series'] as String;
        final direction = cond['direction'] as String;
        final threshold = (cond['threshold'] as num).toDouble();
        final ret = await _dailyReturn(series);
        final hit = direction == 'up' ? ret >= threshold : ret <= -threshold;
        if (hit) matched++;
        results.add({
          'series': series,
          'return_pct': ret,
          'matched': hit,
        });
      }

      if (matched >= (pattern['min_match'] as int)) {
        triggered.add({
          'pattern_name': pattern['name'],
          'description': pattern['description'],
          'conditions_matched': matched,
          'conditions_total': conditions.length,
          'details': results,
          'triggered_at': DateTime.now().toIso8601String(),
        });
      }
    }
    return triggered;
  }

  Future<double> _dailyReturn(String symbol) async {
    try {
      final bars = await _yahoo.getOhlcvHistory(symbol, range: '5d');
      if (bars.length < 2) return 0;
      final prev = (bars[bars.length - 2]['close'] as num).toDouble();
      final last = (bars.last['close'] as num).toDouble();
      if (prev <= 0) return 0;
      return ((last - prev) / prev) * 100;
    } catch (_) {
      return 0;
    }
  }
}
