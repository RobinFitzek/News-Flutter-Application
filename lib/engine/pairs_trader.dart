import 'dart:math';

import '../data/datasources/remote/yahoo_finance_client.dart';
import 'math/statistics.dart';

/// Pairs trading with spread z-score — simplified port of pairs_trader.py (no statsmodels).
class PairsTrader {
  PairsTrader({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const minHistoryDays = 60;
  static const zEntry = 2.0;
  static const zExit = 0.5;

  static const defaultPairs = [
    ('KO', 'PEP', 'Consumer Staples'),
    ('JPM', 'BAC', 'Big Banks'),
    ('XOM', 'CVX', 'Oil Majors'),
    ('HD', 'LOW', 'Home Improvement'),
    ('PFE', 'MRK', 'Pharma'),
    ('MA', 'V', 'Payments'),
    ('CAT', 'DE', 'Industrial'),
    ('NEE', 'DUK', 'Utilities'),
  ];

  Future<List<Map<String, dynamic>>> scanDefaultPairs() async {
    final results = <Map<String, dynamic>>[];
    for (final pair in defaultPairs) {
      try {
        final analysis = await analyzePair(pair.$1, pair.$2);
        analysis['sector'] = pair.$3;
        results.add(analysis);
      } catch (_) {}
    }
    results.sort((a, b) =>
        ((b['current_zscore'] as num?)?.abs() ?? 0)
            .compareTo((a['current_zscore'] as num?)?.abs() ?? 0));
    return results;
  }

  Future<Map<String, dynamic>> analyzePair(String tickerA, String tickerB) async {
    final a = tickerA.toUpperCase();
    final b = tickerB.toUpperCase();

    final barsA = await _yahoo.getOhlcvHistory(a, range: '6mo');
    final barsB = await _yahoo.getOhlcvHistory(b, range: '6mo');

    final aligned = _alignSeries(barsA, barsB);
    if (aligned.a.length < minHistoryDays) {
      return {
        'ticker_a': a,
        'ticker_b': b,
        'error': 'Insufficient history',
        'cointegrated': false,
      };
    }

    final hedgeRatio = _olsHedgeRatio(aligned.a, aligned.b);
    final spread = List<double>.generate(
      aligned.a.length,
      (i) => aligned.a[i] - hedgeRatio * aligned.b[i],
    );

    final spreadMean = Statistics.mean(spread);
    final spreadStd = Statistics.stdDev(spread);
    final zScore = spreadStd > 0
        ? (spread.last - spreadMean) / spreadStd
        : 0.0;

    final corr = _correlation(aligned.a, aligned.b);
    final cointegrated = corr.abs() >= 0.75;

    return {
      'ticker_a': a,
      'ticker_b': b,
      'hedge_ratio': double.parse(hedgeRatio.toStringAsFixed(4)),
      'spread_mean': double.parse(spreadMean.toStringAsFixed(4)),
      'spread_std': double.parse(spreadStd.toStringAsFixed(4)),
      'current_zscore': double.parse(zScore.toStringAsFixed(3)),
      'correlation': double.parse(corr.toStringAsFixed(3)),
      'cointegrated': cointegrated,
      'signal': _signal(zScore, cointegrated),
      'price_a': aligned.a.last,
      'price_b': aligned.b.last,
      'tested_at': DateTime.now().toIso8601String(),
    };
  }

  String _signal(double z, bool cointegrated) {
    if (!cointegrated) return 'hold';
    if (z >= zEntry) return 'short_spread';
    if (z <= -zEntry) return 'long_spread';
    if (z.abs() <= zExit) return 'exit';
    return 'hold';
  }

  double _olsHedgeRatio(List<double> a, List<double> b) {
    final meanA = Statistics.mean(a);
    final meanB = Statistics.mean(b);
    var cov = 0.0;
    var varB = 0.0;
    for (var i = 0; i < a.length; i++) {
      cov += (a[i] - meanA) * (b[i] - meanB);
      varB += pow(b[i] - meanB, 2);
    }
    return varB > 0 ? cov / varB : 1.0;
  }

  double _correlation(List<double> a, List<double> b) {
    if (a.length != b.length || a.isEmpty) return 0;
    final meanA = Statistics.mean(a);
    final meanB = Statistics.mean(b);
    var num = 0.0;
    var denA = 0.0;
    var denB = 0.0;
    for (var i = 0; i < a.length; i++) {
      final da = a[i] - meanA;
      final db = b[i] - meanB;
      num += da * db;
      denA += da * da;
      denB += db * db;
    }
    final den = sqrt(denA * denB);
    return den > 0 ? num / den : 0;
  }

  _Aligned _alignSeries(
    List<Map<String, dynamic>> barsA,
    List<Map<String, dynamic>> barsB,
  ) {
    final mapB = <String, double>{};
    for (final bar in barsB) {
      final ts = bar['timestamp']?.toString();
      if (ts != null) mapB[ts] = (bar['close'] as num).toDouble();
    }

    final a = <double>[];
    final b = <double>[];
    for (final bar in barsA) {
      final ts = bar['timestamp']?.toString();
      if (ts == null || !mapB.containsKey(ts)) continue;
      a.add((bar['close'] as num).toDouble());
      b.add(mapB[ts]!);
    }
    return _Aligned(a, b);
  }
}

class _Aligned {
  const _Aligned(this.a, this.b);
  final List<double> a;
  final List<double> b;
}
