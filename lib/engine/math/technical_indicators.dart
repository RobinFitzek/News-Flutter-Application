import 'dart:math' show max;

import 'statistics.dart';

/// OHLCV bar used by quant screener and volume analyzer.
class OhlcvBar {
  const OhlcvBar({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    this.timestamp,
  });

  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final DateTime? timestamp;
}

class TechnicalIndicators {
  static double? computeRsi(List<double> closes, {int period = 14}) {
    if (closes.length < period + 1) return null;

    double avgGain = 0;
    double avgLoss = 0;

    for (int i = 1; i <= period; i++) {
      final change = closes[i] - closes[i - 1];
      if (change >= 0) {
        avgGain += change;
      } else {
        avgLoss += -change;
      }
    }
    avgGain /= period;
    avgLoss /= period;

    for (int i = period + 1; i < closes.length; i++) {
      final change = closes[i] - closes[i - 1];
      final gain = change > 0 ? change : 0.0;
      final loss = change < 0 ? -change : 0.0;
      avgGain = (avgGain * (period - 1) + gain) / period;
      avgLoss = (avgLoss * (period - 1) + loss) / period;
    }

    if (avgLoss == 0) return 100;
    final rs = avgGain / avgLoss;
    return 100 - (100 / (1 + rs));
  }

  static double? sma(List<double> values, int period) {
    if (values.length < period) return null;
    final slice = values.sublist(values.length - period);
    return Statistics.mean(slice);
  }

  static String computeSmaCrossSignal(List<double> closes) {
    if (closes.length < 210) {
      final sma50 = sma(closes, 50);
      final sma200 = sma(closes, 200);
      if (sma50 == null || sma200 == null) return 'neutral';
      return sma50 > sma200 ? 'bullish' : 'bearish';
    }

    final sma50Series = <double>[];
    final sma200Series = <double>[];
    for (int i = 0; i < closes.length; i++) {
      final s50 = Statistics.rollingMean(closes, 50, i);
      final s200 = Statistics.rollingMean(closes, 200, i);
      if (s50 != null) sma50Series.add(s50);
      if (s200 != null) sma200Series.add(s200);
    }

    if (sma50Series.isEmpty || sma200Series.isEmpty) return 'neutral';

    final last50 = sma50Series.last;
    final last200 = sma200Series.last;

    if (last50 > last200) {
      final recentStart = max(0, sma50Series.length - 10);
      final recentDiff = <double>[];
      for (int i = recentStart; i < sma50Series.length; i++) {
        final idx200 = i - (sma50Series.length - sma200Series.length);
        if (idx200 >= 0 && idx200 < sma200Series.length) {
          recentDiff.add(sma50Series[i] - sma200Series[idx200]);
        }
      }
      if (recentDiff.any((d) => d <= 0)) return 'golden_cross';
      return 'bullish';
    }

    final recentStart = max(0, sma50Series.length - 10);
    final recentDiff = <double>[];
    for (int i = recentStart; i < sma50Series.length; i++) {
      final idx200 = i - (sma50Series.length - sma200Series.length);
      if (idx200 >= 0 && idx200 < sma200Series.length) {
        recentDiff.add(sma50Series[i] - sma200Series[idx200]);
      }
    }
    if (recentDiff.any((d) => d >= 0)) return 'death_cross';
    return 'bearish';
  }

  static double computeBollingerPosition(List<double> closes, {int period = 20}) {
    if (closes.length < period) return 0;
    final slice = closes.sublist(closes.length - period);
    final mid = Statistics.mean(slice);
    final std = Statistics.stdDev(slice);
    if (std == 0) return 0;
    final upper = mid + 2 * std;
    final lower = mid - 2 * std;
    if (upper == lower) return 0;
    return ((closes.last - mid) / (upper - mid)).clamp(-2.0, 2.0);
  }

  static double priceVs52WeekRange(List<double> closes) {
    if (closes.isEmpty) return 0.5;
    final high = closes.reduce((a, b) => a > b ? a : b);
    final low = closes.reduce((a, b) => a < b ? a : b);
    if (high == low) return 0.5;
    return ((closes.last - low) / (high - low)).clamp(0.0, 1.0);
  }
}
