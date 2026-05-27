import 'math/technical_indicators.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

/// Volume confirmation — mirrors News/engine/volume_analyzer.py.
class VolumeAnalyzer {
  VolumeAnalyzer({YahooFinanceClient? yahooClient})
      : _yahoo = yahooClient ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(minutes: 30);

  Future<Map<String, dynamic>> getVolumeMetrics(String ticker) async {
    ticker = ticker.toUpperCase();
    final cached = _cache[ticker];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheDuration) {
      return cached.data;
    }

    try {
      final raw = await _yahoo.getOhlcvHistory(ticker, range: '3mo');
      if (raw.length < 20) return _emptyMetrics();

      final bars = raw
          .where((p) => p['close'] != null && p['volume'] != null)
          .map(
            (p) => OhlcvBar(
              open: (p['open'] as num?)?.toDouble() ?? 0,
              high: (p['high'] as num?)?.toDouble() ?? 0,
              low: (p['low'] as num?)?.toDouble() ?? 0,
              close: (p['close'] as num).toDouble(),
              volume: (p['volume'] as num).toDouble(),
            ),
          )
          .toList();

      if (bars.length < 20) return _emptyMetrics();

      final volumes = bars.map((b) => b.volume).toList();
      final closes = bars.map((b) => b.close).toList();

      final avgVol20 =
          volumes.sublist(volumes.length - 20).reduce((a, b) => a + b) / 20;
      final currentVol = volumes.last;
      final volumeRatio =
          avgVol20 > 0 ? double.parse((currentVol / avgVol20).toStringAsFixed(2)) : 1.0;

      final recentAvg = volumes.sublist(volumes.length - 5).reduce((a, b) => a + b) / 5;
      final olderStart = volumes.length >= 20 ? volumes.length - 20 : 0;
      final olderEnd = volumes.length >= 10 ? volumes.length - 10 : volumes.length;
      final olderAvg = volumes.sublist(olderStart, olderEnd).reduce((a, b) => a + b) /
          (olderEnd - olderStart).clamp(1, 999);

      final volumeTrend = recentAvg > olderAvg * 1.2
          ? 'increasing'
          : recentAvg < olderAvg * 0.8
              ? 'decreasing'
              : 'stable';

      var upVol = 0.0;
      var downVol = 0.0;
      for (final bar in bars.sublist(bars.length - 10)) {
        if (bar.close > bar.open) {
          upVol += bar.volume;
        } else if (bar.close < bar.open) {
          downVol += bar.volume;
        }
      }
      final totalVol = upVol + downVol;
      String accDist = 'neutral';
      if (totalVol > 0) {
        final ratio = (upVol - downVol) / totalVol;
        if (ratio > 0.3) {
          accDist = 'accumulation';
        } else if (ratio < -0.3) {
          accDist = 'distribution';
        }
      }

      final metrics = {
        'ticker': ticker,
        'avg_volume_20d': avgVol20.round(),
        'current_volume': currentVol.round(),
        'volume_ratio': volumeRatio,
        'volume_trend': volumeTrend,
        'accumulation_distribution': accDist,
        'high_volume_anomaly': volumeRatio >= 3.0,
        'volume_confirmation': _volumeConfirmation(volumeRatio, accDist),
        'current_price': closes.last,
      };

      _cache[ticker] = _CacheEntry(data: metrics, timestamp: DateTime.now());
      return metrics;
    } catch (_) {
      return _emptyMetrics();
    }
  }

  Map<String, dynamic> enhanceSignal(
    String signal,
    Map<String, dynamic> volumeMetrics,
  ) {
    final ratio = (volumeMetrics['volume_ratio'] as num?)?.toDouble() ?? 1.0;
    final accDist = volumeMetrics['accumulation_distribution']?.toString() ?? 'neutral';

    if (ratio >= 2.0 && accDist == 'accumulation' && signal == 'Opportunity') {
      return {
        'enhanced_signal': 'Opportunity',
        'note': 'Volume-confirmed accumulation (${ratio}x avg)',
      };
    }
    if (ratio >= 2.0 && accDist == 'distribution' && signal == 'Caution') {
      return {
        'enhanced_signal': 'Caution',
        'note': 'Volume-confirmed distribution (${ratio}x avg)',
      };
    }
    return {'enhanced_signal': signal, 'note': ''};
  }

  String _volumeConfirmation(double ratio, String accDist) {
    if (ratio >= 3.0 && accDist == 'accumulation') return 'strong_bullish';
    if (ratio >= 3.0 && accDist == 'distribution') return 'strong_bearish';
    if (ratio >= 1.5) return 'moderate';
    return 'weak';
  }

  Map<String, dynamic> _emptyMetrics() => {
        'avg_volume_20d': 0,
        'current_volume': 0,
        'volume_ratio': 1.0,
        'volume_trend': 'unknown',
        'accumulation_distribution': 'neutral',
        'high_volume_anomaly': false,
        'volume_confirmation': 'weak',
      };
}

class _CacheEntry {
  _CacheEntry({required this.data, required this.timestamp});
  final Map<String, dynamic> data;
  final DateTime timestamp;
}
