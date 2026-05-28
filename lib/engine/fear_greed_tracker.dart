import 'package:dio/dio.dart';

import '../data/datasources/remote/yahoo_finance_client.dart';

/// Fear & Greed tracker — mirrors News/engine/fear_greed_tracker.py.
class FearGreedTracker {
  FearGreedTracker({YahooFinanceClient? yahoo, Dio? dio})
      : _yahoo = yahoo ?? YahooFinanceClient(),
        _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              headers: {
                'User-Agent': 'Mozilla/5.0 (compatible; StockholmApp/1.0)',
                'Accept': 'application/json',
                'Referer': 'https://www.cnn.com/markets/fear-and-greed',
              },
            ));

  final YahooFinanceClient _yahoo;
  final Dio _dio;

  Map<String, dynamic>? _cache;
  DateTime? _cacheTime;
  static const _cacheHours = 6;

  Future<Map<String, dynamic>> getCurrentSnapshot() async {
    if (_cache != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!).inHours < _cacheHours) {
      return _cache!;
    }

    double? fgScore;
    var cnnUsed = false;
    try {
      final response = await _dio.get(
        'https://production.dataviz.cnn.io/index/fearandgreed/graphdata',
      );
      final data = response.data as Map<String, dynamic>;
      final current = data['fear_and_greed'] as Map<String, dynamic>?;
      fgScore = (current?['score'] as num?)?.toDouble();
      if (fgScore == null) {
        final hist = data['fear_and_greed_historical']?['data'] as List?;
        if (hist != null && hist.isNotEmpty) {
          final last = hist.last as Map<String, dynamic>;
          fgScore = (last['y'] as num?)?.toDouble() ??
              (last['score'] as num?)?.toDouble();
        }
      }
      if (fgScore != null) cnnUsed = true;
    } catch (_) {}

    final vixQ = await _yahoo.getStockQuote('^VIX');
    final spyQ = await _yahoo.getStockQuote('SPY');
    final vix = (vixQ['currentPrice'] as num).toDouble();
    final spyChange = (spyQ['changePercent'] as num).toDouble();

    fgScore ??= _vixFallbackScore(vix, spyChange);

    final result = {
      'score': fgScore.round().clamp(0, 100),
      'sentiment': getFgLabel(fgScore),
      'vix': vix,
      'spy_change': spyChange,
      'vix_10d_avg': await _vixRollingAvg(10),
      'vix_20d_avg': await _vixRollingAvg(20),
      'source': cnnUsed ? 'cnn' : 'vix_fallback',
      'timestamp': DateTime.now().toIso8601String(),
    };

    _cache = result;
    _cacheTime = DateTime.now();
    return result;
  }

  double _vixFallbackScore(double vix, double spyChange) {
    if (vix < 15) return (75 + spyChange.clamp(-5, 5) * 2).clamp(0, 100).toDouble();
    if (vix < 20) return (50 + spyChange.clamp(-5, 5) * 2).clamp(0, 100).toDouble();
    if (vix < 30) return (30 + spyChange.clamp(-5, 5)).clamp(0, 100).toDouble();
    return 15;
  }

  String getFgLabel(double value) {
    if (value <= 20) return 'Extreme Fear';
    if (value <= 40) return 'Fear';
    if (value <= 60) return 'Neutral';
    if (value <= 80) return 'Greed';
    return 'Extreme Greed';
  }

  Future<double?> _vixRollingAvg(int days) async {
    try {
      final bars = await _yahoo.getOhlcvHistory('^VIX', range: '1mo');
      if (bars.length < days) return null;
      final closes = bars
          .sublist(bars.length - days)
          .map((b) => (b['close'] as num).toDouble());
      return closes.reduce((a, b) => a + b) / days;
    } catch (_) {
      return null;
    }
  }
}
