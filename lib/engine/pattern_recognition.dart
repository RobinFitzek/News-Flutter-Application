import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Chart pattern detection — mirrors News/engine/pattern_recognition.py (simplified).
class PatternRecognizer {
  PatternRecognizer({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(minutes: 30);

  Future<List<Map<String, dynamic>>> detectPatterns(String ticker) async {
    final key = ticker.toUpperCase();
    final cached = _cache[key];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheDuration) {
      return cached.data;
    }

    try {
      final bars = await _yahoo.getOhlcvHistory(key, range: '6mo');
      if (bars.length < 60) return [];

      final prices =
          bars.map((b) => (b['close'] as num).toDouble()).toList();
      final pivots = _findPivots(prices, window: 5);
      final patterns = <Map<String, dynamic>>[];

      final db = _detectDoubleBottom(pivots, prices);
      if (db != null && db['confidence'] >= 40) patterns.add(db);

      final tri = _detectAscendingTriangle(pivots, prices);
      if (tri != null && tri['confidence'] >= 40) patterns.add(tri);

      patterns.sort(
        (a, b) => (b['confidence'] as int).compareTo(a['confidence'] as int),
      );
      _cache[key] = _CacheEntry(patterns, DateTime.now());
      return patterns;
    } catch (_) {
      return [];
    }
  }

  Map<String, List<(int, double)>> _findPivots(
    List<double> prices, {
    required int window,
  }) {
    final highs = <(int, double)>[];
    final lows = <(int, double)>[];
    for (var i = window; i < prices.length - window; i++) {
      final segment = prices.sublist(i - window, i + window + 1);
      if (prices[i] == segment.reduce(max)) highs.add((i, prices[i]));
      if (prices[i] == segment.reduce(min)) lows.add((i, prices[i]));
    }
    return {'highs': highs, 'lows': lows};
  }

  Map<String, dynamic>? _detectDoubleBottom(
    Map<String, List<(int, double)>> pivots,
    List<double> prices,
  ) {
    final lows = pivots['lows']!;
    if (lows.length < 2) return null;

    for (var i = 0; i < lows.length - 1; i++) {
      for (var j = i + 1; j < lows.length; j++) {
        final (_, p1) = lows[i];
        final (_, p2) = lows[j];
        if ((p1 - p2).abs() / p1 > 0.03) continue;
        if (j - i < 10) continue;

        final between = prices.sublist(lows[i].$1, lows[j].$1);
        if (between.isEmpty) continue;
        final peak = between.reduce(max);
        if (peak < p1 * 1.05) continue;

        return {
          'pattern': 'Double Bottom',
          'direction': 'bullish',
          'confidence': 65,
          'description': 'Two lows at similar levels with intervening peak',
        };
      }
    }
    return null;
  }

  Map<String, dynamic>? _detectAscendingTriangle(
    Map<String, List<(int, double)>> pivots,
    List<double> prices,
  ) {
    final highs = pivots['highs']!;
    final lows = pivots['lows']!;
    if (highs.length < 2 || lows.length < 2) return null;

    final recentHighs = highs.length >= 3 ? highs.sublist(highs.length - 3) : highs;
    final recentLows = lows.length >= 3 ? lows.sublist(lows.length - 3) : lows;

    final highFlat = recentHighs.map((h) => h.$2).reduce((a, b) => a + b) /
        recentHighs.length;
    final lowSlope = recentLows.last.$2 - recentLows.first.$2;
    if (lowSlope <= 0) return null;

    final flatRange = recentHighs.map((h) => (h.$2 - highFlat).abs()).reduce(max);
    if (flatRange / highFlat > 0.02) return null;

    return {
      'pattern': 'Ascending Triangle',
      'direction': 'bullish',
      'confidence': 55,
      'description': 'Flat resistance with rising support',
    };
  }
}

class _CacheEntry {
  _CacheEntry(this.data, this.timestamp);
  final List<Map<String, dynamic>> data;
  final DateTime timestamp;
}

/// Multi-timeframe trend alignment — mirrors News/engine/multi_timeframe.py.
class MultiTimeframeAnalyzer {
  MultiTimeframeAnalyzer({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  Future<Map<String, dynamic>> analyze(String ticker) async {
    final frames = {
      '1d': '1mo',
      '1w': '3mo',
      '1m': '6mo',
    };

    final trends = <String, String>{};
    for (final entry in frames.entries) {
      final bars = await _yahoo.getOhlcvHistory(ticker, range: entry.value);
      if (bars.length < 10) {
        trends[entry.key] = 'neutral';
        continue;
      }
      final closes =
          bars.map((b) => (b['close'] as num).toDouble()).toList();
      final sma20 = closes.length >= 20
          ? closes.sublist(closes.length - 20).reduce((a, b) => a + b) / 20
          : closes.reduce((a, b) => a + b) / closes.length;
      final last = closes.last;
      trends[entry.key] =
          last > sma20 * 1.01 ? 'bullish' : last < sma20 * 0.99 ? 'bearish' : 'neutral';
    }

    final bullish = trends.values.where((t) => t == 'bullish').length;
    final bearish = trends.values.where((t) => t == 'bearish').length;
    String alignment;
    if (bullish >= 2 && bearish == 0) {
      alignment = 'aligned_bullish';
    } else if (bearish >= 2 && bullish == 0) {
      alignment = 'aligned_bearish';
    } else {
      alignment = 'mixed';
    }

    return {
      'ticker': ticker.toUpperCase(),
      'timeframes': trends,
      'alignment': alignment,
      'score': bullish - bearish,
    };
  }
}
