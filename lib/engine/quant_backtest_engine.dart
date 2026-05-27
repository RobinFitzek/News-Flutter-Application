import 'dart:math';

import '../data/datasources/remote/yahoo_finance_client.dart';
import 'math/technical_indicators.dart';

/// Walk-forward quant signal backtest — simplified port of backtest_engine.py.
class QuantBacktestEngine {
  QuantBacktestEngine({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const buyThreshold = 65;
  static const sellThreshold = 35;
  static const forwardDays = 30;

  Future<Map<String, dynamic>> runWalkForward({
    required List<String> symbols,
    int lookbackMonths = 18,
  }) async {
    final allSignals = <Map<String, dynamic>>[];
    final symbolStats = <String, Map<String, dynamic>>{};

    for (final raw in symbols) {
      final symbol = raw.toUpperCase().trim();
      if (symbol.isEmpty) continue;

      try {
        final bars = await _yahoo.getOhlcvHistory(symbol, range: '2y');
        if (bars.length < 120) continue;

        final parsed = _parseBars(bars);
        final signals = _walkForward(symbol, parsed, lookbackMonths);
        allSignals.addAll(signals);

        if (signals.isNotEmpty) {
          final wins = signals.where((s) => s['correct'] == true).length;
          symbolStats[symbol] = {
            'signals': signals.length,
            'hit_rate': wins / signals.length,
            'avg_return': _mean(signals.map((s) => s['return'] as double)),
          };
        }
      } catch (_) {
        continue;
      }
    }

    if (allSignals.isEmpty) {
      return {
        'strategy': 'quant_walkforward',
        'error': 'Insufficient history for selected symbols',
      };
    }

    final buySignals =
        allSignals.where((s) => s['direction'] == 'long').toList();
    final sellSignals =
        allSignals.where((s) => s['direction'] == 'short').toList();

    final buyHitRate = buySignals.isEmpty
        ? 0.0
        : buySignals.where((s) => s['correct'] == true).length /
            buySignals.length;
    final sellHitRate = sellSignals.isEmpty
        ? 0.0
        : sellSignals.where((s) => s['correct'] == true).length /
            sellSignals.length;

    final returns =
        allSignals.map((s) => s['return'] as double).toList();
    final avgReturn = _mean(returns);
    final winRate = allSignals.where((s) => s['correct'] == true).length /
        allSignals.length;

    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: lookbackMonths * 30));

    return {
      'strategy': 'quant_walkforward',
      'startDate': startDate.toIso8601String(),
      'endDate': now.toIso8601String(),
      'initialCapital': 100000.0,
      'finalCapital': 100000 * (1 + avgReturn),
      'totalReturn': 100000 * avgReturn,
      'totalReturnPercent': avgReturn * 100,
      'maxDrawdown': _maxDrawdown(returns),
      'maxDrawdownPercent': _maxDrawdown(returns) * 100,
      'totalTrades': allSignals.length,
      'winningTrades': allSignals.where((s) => s['correct'] == true).length,
      'losingTrades': allSignals.where((s) => s['correct'] == false).length,
      'winRate': winRate * 100,
      'avgWin': _mean(allSignals
          .where((s) => (s['return'] as double) > 0)
          .map((s) => s['return'] as double)),
      'avgLoss': _mean(allSignals
          .where((s) => (s['return'] as double) < 0)
          .map((s) => s['return'] as double)
          .map((r) => r.abs())),
      'profitFactor': _profitFactor(returns),
      'symbols': symbols.join(','),
      'buy_hit_rate': buyHitRate,
      'sell_hit_rate': sellHitRate,
      'symbol_stats': symbolStats,
      'lookback_months': lookbackMonths,
      'forward_days': forwardDays,
    };
  }

  List<Map<String, dynamic>> _walkForward(
    String symbol,
    List<_Bar> bars,
    int lookbackMonths,
  ) {
    final signals = <Map<String, dynamic>>[];
    final startIdx = max(60, bars.length - lookbackMonths * 21);

    for (var i = startIdx; i < bars.length - forwardDays; i += 21) {
      final slice = bars.sublist(0, i + 1);
      final closes = slice.map((b) => b.close).toList();
      final score = _compositeScore(closes, slice);

      String? direction;
      if (score >= buyThreshold) {
        direction = 'long';
      } else if (score <= sellThreshold) {
        direction = 'short';
      }
      if (direction == null) continue;

      final entry = bars[i].close;
      final exit = bars[i + forwardDays].close;
      final ret = (exit - entry) / entry;
      final signedRet = direction == 'long' ? ret : -ret;
      final correct = signedRet > 0.02;

      signals.add({
        'symbol': symbol,
        'date': bars[i].date.toIso8601String(),
        'score': score,
        'direction': direction,
        'return': signedRet,
        'correct': correct,
      });
    }
    return signals;
  }

  int _compositeScore(List<double> closes, List<_Bar> bars) {
    final tech = _technicalScore(closes);
    final mom = _momentumScore(closes, bars);
    return ((tech + mom) / 2).round().clamp(0, 100);
  }

  double _technicalScore(List<double> closes) {
    var score = 50.0;
    final rsi = TechnicalIndicators.computeRsi(closes);
    if (rsi != null) {
      if (rsi < 30) {
        score += 15;
      } else if (rsi > 70) {
        score -= 15;
      } else if (rsi >= 45 && rsi <= 55) {
        score += 5;
      }
    }

    final sma50 = TechnicalIndicators.sma(closes, 50);
    final sma200 = TechnicalIndicators.sma(closes, 200);
    if (sma50 != null && sma200 != null) {
      score += sma50 > sma200 ? 10 : -10;
    }

    final cross = TechnicalIndicators.computeSmaCrossSignal(closes);
    if (cross == 'golden_cross') score += 15;
    if (cross == 'death_cross') score -= 15;

    return score.clamp(0, 100);
  }

  double _momentumScore(List<double> closes, List<_Bar> bars) {
    var score = 50.0;
    if (closes.length >= 21) {
      final ret1m = (closes.last - closes[closes.length - 21]) /
          closes[closes.length - 21];
      score += (ret1m * 200).clamp(-20, 20);
    }
    if (closes.length >= 63) {
      final ret3m = (closes.last - closes[closes.length - 63]) /
          closes[closes.length - 63];
      score += (ret3m * 100).clamp(-15, 15);
    }
    return score.clamp(0, 100);
  }

  List<_Bar> _parseBars(List<Map<String, dynamic>> raw) {
    return raw
        .map((b) {
          final ts = DateTime.tryParse(b['timestamp']?.toString() ?? '');
          if (ts == null) return null;
          return _Bar(
            date: ts,
            close: (b['close'] as num).toDouble(),
          );
        })
        .whereType<_Bar>()
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  double _mean(Iterable<double> values) {
    final list = values.toList();
    if (list.isEmpty) return 0;
    return list.reduce((a, b) => a + b) / list.length;
  }

  double _maxDrawdown(List<double> returns) {
    var peak = 0.0;
    var equity = 1.0;
    var maxDd = 0.0;
    for (final r in returns) {
      equity *= (1 + r);
      if (equity > peak) peak = equity;
      final dd = peak > 0 ? (peak - equity) / peak : 0;
      if (dd > maxDd) maxDd = dd.toDouble();
    }
    return maxDd;
  }

  double _profitFactor(List<double> returns) {
    final gains = returns.where((r) => r > 0).fold(0.0, (a, b) => a + b);
    final losses =
        returns.where((r) => r < 0).fold(0.0, (a, b) => a + b.abs());
    if (losses == 0) return gains > 0 ? 99.0 : 0.0;
    return gains / losses;
  }
}

class _Bar {
  const _Bar({required this.date, required this.close});
  final DateTime date;
  final double close;
}
