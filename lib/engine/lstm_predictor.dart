import 'dart:math';

import '../data/datasources/remote/yahoo_finance_client.dart';
import 'fear_greed_tracker.dart';
import 'math/technical_indicators.dart';
import 'politician_tracker.dart';

/// Simplified LSTM-style predictor — heuristic ensemble mirroring lstm_predictor.py output shape.
class LstmPredictor {
  LstmPredictor({
    YahooFinanceClient? yahoo,
    PoliticianTracker? politician,
    FearGreedTracker? fearGreed,
  })  : _yahoo = yahoo ?? YahooFinanceClient(),
        _politician = politician ?? PoliticianTracker(),
        _fearGreed = fearGreed ?? FearGreedTracker();

  final YahooFinanceClient _yahoo;
  final PoliticianTracker _politician;
  final FearGreedTracker _fearGreed;

  static const threshold = 0.50;

  Future<Map<String, dynamic>> predict(String ticker) async {
    ticker = ticker.toUpperCase();
    final features = await _buildFeatures(ticker);
    if (features == null) {
      return {
        'ticker': ticker,
        'confidence': 0.0,
        'buy_signal': false,
        'threshold': threshold,
        'error': 'Insufficient data',
      };
    }

    final confidence = _score(features);
    return {
      'ticker': ticker,
      'confidence': double.parse(confidence.toStringAsFixed(3)),
      'buy_signal': confidence >= threshold,
      'threshold': threshold,
      'predicted_at': DateTime.now().toIso8601String(),
      'features_used': features.keys.length,
    };
  }

  Future<List<Map<String, dynamic>>> getBuySignals(List<String> tickers) async {
    final signals = <Map<String, dynamic>>[];
    for (final t in tickers) {
      final p = await predict(t);
      if (p['buy_signal'] == true) signals.add(p);
    }
    signals.sort((a, b) =>
        (b['confidence'] as double).compareTo(a['confidence'] as double));
    return signals;
  }

  Future<Map<String, dynamic>?> _buildFeatures(String ticker) async {
    try {
      final bars = await _yahoo.getOhlcvHistory(ticker, range: '6mo');
      if (bars.length < 30) return null;

      final closes = bars.map((b) => (b['close'] as num).toDouble()).toList();
      final price = closes.last;
      final info = await _yahoo.getStockInfo(ticker);
      final rsi = TechnicalIndicators.computeRsi(closes) ?? 50.0;
      final sma20 = TechnicalIndicators.sma(closes, 20) ?? price;
      final sma50 = TechnicalIndicators.sma(closes, 50) ?? price;

      final mom20 = closes.length >= 21
          ? (price - closes[closes.length - 21]) / closes[closes.length - 21]
          : 0.0;

      final pol = await _politician.getFeaturesForTicker(ticker);
      final fg = await _fearGreed.getCurrentSnapshot();

      return {
        'rsi': rsi,
        'sma_cross': sma20 > sma50 ? 1.0 : 0.0,
        'momentum_20d': mom20,
        'pe': (info['trailingPE'] as num?)?.toDouble() ?? 20,
        'pol_buys': (pol['pol_buy_count'] as int) / max(1, pol['pol_total_trades'] as int),
        'fear_greed': (fg['score'] as num?)?.toDouble() ?? 50,
      };
    } catch (_) {
      return null;
    }
  }

  double _score(Map<String, dynamic> f) {
    var score = 0.35;
    final rsi = f['rsi'] as double? ?? 50;
    if (rsi > 40 && rsi < 65) score += 0.1;
    if (f['sma_cross'] == 1.0) score += 0.15;
    final mom = f['momentum_20d'] as double? ?? 0;
    if (mom > 0.03) score += 0.15;
    if (mom > 0.08) score += 0.1;
    if ((f['pol_buys'] as double? ?? 0) > 0.6) score += 0.1;
    final fg = f['fear_greed'] as double? ?? 50;
    if (fg < 40) score += 0.05;
    return score.clamp(0.0, 0.99);
  }
}
