import 'dart:math' as math;

import '../data/datasources/remote/yahoo_finance_client.dart';

/// Economic moat scoring — mirrors moat_scorer.py (quantitative heuristics).
class MoatScorer {
  MoatScorer({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(hours: 24);

  Future<Map<String, dynamic>> moatScore(String ticker) async {
    final key = ticker.toUpperCase();
    final cached = _cache[key];
    if (cached != null &&
        DateTime.now().difference(cached.at) < _cacheDuration) {
      return cached.data;
    }

    final info = await _yahoo.getStockInfo(key);
    final bars = await _yahoo.getOhlcvHistory(key, range: '3y');
    final actions = await _yahoo.getCorporateActions(key);

    final pe = _scorePeStability(bars, info['eps'] as double?);
    final margin = _scoreMarginConsistency(
      info['grossMargins'] as double?,
      info['earningsGrowth'] as double?,
    );
    final fcf = _scoreFcfTrend(
      info['freeCashflow'] as double?,
      info['earningsGrowth'] as double?,
    );
    final div = _scoreDividendHistory(actions, info['dividendYield'] as double?);

    final composite = pe.$1 + margin.$1 + fcf.$1 + div.$1;
    final grade = moatGrade(composite);

    final result = {
      'ticker': key,
      'moat_score': double.parse(composite.toStringAsFixed(1)),
      'grade': grade,
      'factors': {
        'pe_stability': {'score': pe.$1, 'note': pe.$2},
        'margin_consistency': {'score': margin.$1, 'note': margin.$2},
        'fcf_trend': {'score': fcf.$1, 'note': fcf.$2},
        'dividend_history': {'score': div.$1, 'note': div.$2},
      },
      'scored_at': DateTime.now().toIso8601String(),
      'error': null,
    };

    _cache[key] = _CacheEntry(result, DateTime.now());
    return result;
  }

  Future<List<Map<String, dynamic>>> batchMoatScores(List<String> tickers) async {
    final results = <Map<String, dynamic>>[];
    for (final t in tickers) {
      try {
        results.add(await moatScore(t));
      } catch (e) {
        results.add({
          'ticker': t.toUpperCase(),
          'moat_score': 0.0,
          'grade': 'Unknown',
          'error': e.toString(),
        });
      }
    }
    results.sort(
      (a, b) => ((b['moat_score'] as num?) ?? 0)
          .compareTo((a['moat_score'] as num?) ?? 0),
    );
    return results;
  }

  static String moatGrade(double composite) {
    if (composite >= 70) return 'Strong';
    if (composite >= 45) return 'Moderate';
    if (composite >= 20) return 'Weak';
    return 'None';
  }

  (double, String) _scorePeStability(
    List<Map<String, dynamic>> bars,
    double? eps,
  ) {
    if (eps == null || eps <= 0 || bars.length < 60) {
      return (12.5, 'No EPS or price history');
    }

    final byYear = <int, double>{};
    for (final bar in bars) {
      final ts = bar['timestamp'];
      DateTime? dt;
      if (ts is DateTime) {
        dt = ts;
      } else if (ts is int) {
        dt = DateTime.fromMillisecondsSinceEpoch(ts);
      }
      if (dt == null) continue;
      byYear[dt.year] = (bar['close'] as num).toDouble();
    }

    if (byYear.length < 2) return (12.5, 'Insufficient price history');

    final peValues = byYear.values.map((p) => p / eps).toList();
    final mean = peValues.reduce((a, b) => a + b) / peValues.length;
    var variance = 0.0;
    for (final v in peValues) {
      variance += (v - mean) * (v - mean);
    }
    final peStd = math.sqrt(variance / peValues.length);

    final score = (25.0 - (peStd - 2.0) * (25.0 / 13.0)).clamp(0.0, 25.0);
    return (double.parse(score.toStringAsFixed(1)), 'P/E 3yr std=${peStd.toStringAsFixed(1)}');
  }

  (double, String) _scoreMarginConsistency(double? grossMargin, double? growth) {
    if (grossMargin == null) return (12.5, 'No margin data');

    final marginScore = (grossMargin * 31.25).clamp(0.0, 12.5);
    final growthStability = growth == null
        ? 6.25
        : (12.5 - growth.abs() * 25).clamp(0.0, 12.5);
    final score = marginScore + growthStability;
    return (
      double.parse(score.toStringAsFixed(1)),
      'Gross margin=${(grossMargin * 100).toStringAsFixed(1)}%',
    );
  }

  (double, String) _scoreFcfTrend(double? fcf, double? earningsGrowth) {
    if (fcf == null) return (12.5, 'No FCF data');

    var score = fcf > 0 ? 20.0 : 5.0;
    if ((earningsGrowth ?? 0) > 0) score += 5.0;
    return (
      double.parse(score.clamp(0.0, 25.0).toStringAsFixed(1)),
      'FCF ${fcf > 0 ? 'positive' : 'negative'}, trend=${(earningsGrowth ?? 0) > 0 ? 'up' : 'flat'}',
    );
  }

  (double, String) _scoreDividendHistory(
    List<Map<String, dynamic>> actions,
    double? dividendYield,
  ) {
    final cutoff = DateTime.now().subtract(const Duration(days: 5 * 365));
    final dividendYears = actions
        .where((a) => a['type'] == 'dividend')
        .map((a) => DateTime.parse(a['date'] as String).year)
        .where((y) {
          final d = DateTime(y);
          return d.isAfter(cutoff);
        })
        .toSet()
        .length;

    if (dividendYears == 0 && (dividendYield ?? 0) <= 0) {
      return (0.0, 'No dividends paid');
    }

    final years = dividendYears > 0 ? dividendYears : ((dividendYield ?? 0) > 0 ? 3 : 0);
    final score = (years * 5.0).clamp(0.0, 25.0);
    return (
      double.parse(score.toStringAsFixed(1)),
      'Dividends in $years/5 recent years',
    );
  }
}

class _CacheEntry {
  _CacheEntry(this.data, this.at);
  final Map<String, dynamic> data;
  final DateTime at;
}
