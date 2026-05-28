import 'math/technical_indicators.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

/// Market regime detection — mirrors News/engine/market_regime.py.
class MarketRegime {
  MarketRegime({YahooFinanceClient? yahooClient})
      : _yahoo = yahooClient ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  Map<String, dynamic>? _cache;
  DateTime? _cacheTime;
  static const _cacheDuration = Duration(minutes: 60);

  Future<Map<String, dynamic>> getCurrentRegime() async {
    if (_cache != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheDuration) {
      return _cache!;
    }

    final result = <String, dynamic>{
      'regime': 'choppy',
      'spy_price': null,
      'sma50': null,
      'sma200': null,
      'vix': null,
      'ten_year_yield': null,
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      final spyRaw = await _yahoo.getOhlcvHistory('SPY', range: '1y');
      final spyCloses = spyRaw
          .where((p) => p['close'] != null)
          .map((p) => (p['close'] as num).toDouble())
          .toList();

      if (spyCloses.length >= 200) {
        result['spy_price'] =
            double.parse(spyCloses.last.toStringAsFixed(2));
        final sma50 = TechnicalIndicators.sma(spyCloses, 50);
        final sma200 = TechnicalIndicators.sma(spyCloses, 200);
        result['sma50'] = sma50 != null ? double.parse(sma50.toStringAsFixed(2)) : null;
        result['sma200'] =
            sma200 != null ? double.parse(sma200.toStringAsFixed(2)) : null;

        final price = result['spy_price'] as double;
        if (sma50 != null && sma200 != null) {
          if (price > sma200 && sma50 > sma200) {
            result['regime'] = 'bull';
          } else if (price < sma200 && sma50 < sma200) {
            result['regime'] = 'bear';
          }
        }
      } else if (spyCloses.isNotEmpty) {
        result['spy_price'] =
            double.parse(spyCloses.last.toStringAsFixed(2));
      }
    } catch (_) {}

    try {
      final vixRaw = await _yahoo.getStockQuote('^VIX');
      result['vix'] = (vixRaw['currentPrice'] as num?)?.toDouble();
    } catch (_) {}

    try {
      final tnxRaw = await _yahoo.getStockQuote('^TNX');
      result['ten_year_yield'] =
          (tnxRaw['currentPrice'] as num?)?.toDouble();
    } catch (_) {}

    _cache = result;
    _cacheTime = DateTime.now();
    return result;
  }

  int getConfidenceAdjustment(String signal, String regime) {
    if (regime == 'bear' &&
        (signal == 'Opportunity' || signal == 'BUY' || signal == 'STRONG_BUY')) {
      return -15;
    }
    if (regime == 'bull' &&
        (signal == 'Caution' || signal == 'SELL' || signal == 'STRONG_SELL')) {
      return 15;
    }
    return 0;
  }

  Map<String, double> getRegimeWeightAdjustments(String regime) {
    switch (regime) {
      case 'bull':
        return {
          'valuation': 0.85,
          'technical': 1.15,
          'momentum': 1.20,
          'quality': 0.90,
        };
      case 'bear':
        return {
          'valuation': 1.20,
          'technical': 0.90,
          'momentum': 0.80,
          'quality': 1.25,
        };
      default:
        return {
          'valuation': 1.0,
          'technical': 1.0,
          'momentum': 1.0,
          'quality': 1.0,
        };
    }
  }
}
