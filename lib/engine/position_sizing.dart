import '../data/datasources/remote/yahoo_finance_client.dart';
import 'correlation_analyzer.dart';
import 'math/statistics.dart';

/// Kelly + volatility-adjusted sizing — mirrors position_sizing.py.
class PositionSizer {
  PositionSizer({
    YahooFinanceClient? yahoo,
    CorrelationAnalyzer? correlation,
  })  : _yahoo = yahoo ?? YahooFinanceClient(),
        _correlation = correlation ?? CorrelationAnalyzer();

  final YahooFinanceClient _yahoo;
  final CorrelationAnalyzer _correlation;

  static const maxPositionPct = 10.0;
  static const kellyFraction = 0.25;

  Future<Map<String, dynamic>> recommend({
    required String ticker,
    required double portfolioValue,
    required double confidence,
    required String signal,
    List<String> existingTickers = const [],
  }) async {
    if (portfolioValue <= 0) {
      return {'recommended_pct': 0.0, 'recommended_usd': 0.0, 'notes': ['Invalid portfolio value']};
    }

    final edge = _signalEdge(signal, confidence);
    final kellyPct = (edge * kellyFraction * 100).clamp(0.0, maxPositionPct);

    final volAdj = await _volatilityAdjustment(ticker);
    var sizePct = (kellyPct * volAdj).clamp(1.0, maxPositionPct);

    final corrAdj = await _correlationAdjustment(ticker, existingTickers);
    sizePct = (sizePct * (corrAdj['multiplier'] as double)).clamp(1.0, maxPositionPct);

    final usd = portfolioValue * sizePct / 100;
    return {
      'recommended_pct': double.parse(sizePct.toStringAsFixed(2)),
      'recommended_usd': double.parse(usd.toStringAsFixed(2)),
      'kelly_raw_pct': double.parse(kellyPct.toStringAsFixed(2)),
      'volatility_multiplier': volAdj,
      'correlation_multiplier': corrAdj['multiplier'],
      'notes': [
        if (corrAdj['note'] != null) corrAdj['note'],
      ],
    };
  }

  double _signalEdge(String signal, double confidence) {
    final conf = confidence.clamp(0.0, 1.0);
    return switch (signal) {
      'Opportunity' => 0.15 + conf * 0.35,
      'Caution' => 0.05 + conf * 0.10,
      _ => 0.08 + conf * 0.15,
    };
  }

  Future<double> _volatilityAdjustment(String ticker) async {
    try {
      final bars = await _yahoo.getOhlcvHistory(ticker, range: '6mo');
      if (bars.length < 30) return 1.0;
      final closes = bars.map((b) => (b['close'] as num).toDouble()).toList();
      final returns = <double>[];
      for (var i = 1; i < closes.length; i++) {
        if (closes[i - 1] != 0) {
          returns.add((closes[i] - closes[i - 1]) / closes[i - 1]);
        }
      }
      final vol = Statistics.stdDev(returns) * (252).sqrt() * 100;
      if (vol <= 20) return 1.0;
      if (vol >= 60) return 0.5;
      return 1.0 - (vol - 20) / 80;
    } catch (_) {
      return 1.0;
    }
  }

  Future<Map<String, dynamic>> _correlationAdjustment(
    String ticker,
    List<String> existingTickers,
  ) async {
    if (existingTickers.isEmpty) {
      return {'multiplier': 1.0, 'note': 'No existing positions'};
    }
    final matrix = await _correlation.getCorrelationMatrix(
      [...existingTickers, ticker],
    );
    if (matrix == null) {
      return {'multiplier': 1.0, 'note': 'Correlation data unavailable'};
    }
    final key = ticker.toUpperCase();
    final corrs = <double>[];
    for (final pt in existingTickers) {
      final other = pt.toUpperCase();
      final c = matrix[key]?[other];
      if (c != null) corrs.add(c.abs());
    }
    if (corrs.isEmpty) {
      return {'multiplier': 1.0, 'note': 'No valid correlation pairs'};
    }
    final avg = corrs.reduce((a, b) => a + b) / corrs.length;
    return {
      'multiplier': (1.0 - avg).clamp(0.5, 1.0),
      'note': 'Avg corr ${avg.toStringAsFixed(2)}',
    };
  }
}

extension on double {
  double sqrt() {
    if (this <= 0) return 0;
    var x = this;
    var y = (x + 1) / 2;
    while ((y - x).abs() > 1e-10) {
      x = y;
      y = (x + this / x) / 2;
    }
    return x;
  }
}

extension on int {
  double sqrt() => toDouble().sqrt();
}
