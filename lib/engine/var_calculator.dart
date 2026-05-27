import '../data/datasources/remote/yahoo_finance_client.dart';
import 'math/statistics.dart';

/// Historical simulation VaR — mirrors var_calculator.py.
class VarCalculator {
  VarCalculator({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  Future<Map<String, dynamic>> calculateVar({
    required List<String> tickers,
    List<double>? weights,
    double confidence = 0.95,
    int lookbackDays = 252,
  }) async {
    if (tickers.isEmpty) return {'error': 'No tickers provided'};

    final symbols = tickers.map((t) => t.toUpperCase()).toList();
    final w = weights ??
        List<double>.filled(symbols.length, 1 / symbols.length);
    if (w.length != symbols.length) {
      return {'error': 'Weights length mismatch'};
    }

    final weightSum = w.reduce((a, b) => a + b);
    final normWeights = w.map((x) => x / weightSum).toList();

    final returnsBySymbol = <String, List<double>>{};
    for (final symbol in symbols) {
      final bars = await _yahoo.getOhlcvHistory(symbol, range: '2y');
      if (bars.length < 30) continue;
      final closes = bars.map((b) => (b['close'] as num).toDouble()).toList();
      final trimmed = closes.length > lookbackDays + 1
          ? closes.sublist(closes.length - lookbackDays - 1)
          : closes;
      final returns = <double>[];
      for (var i = 1; i < trimmed.length; i++) {
        if (trimmed[i - 1] != 0) {
          returns.add((trimmed[i] - trimmed[i - 1]) / trimmed[i - 1]);
        }
      }
      if (returns.isNotEmpty) returnsBySymbol[symbol] = returns;
    }

    if (returnsBySymbol.length < 1) {
      return {'error': 'Insufficient price history'};
    }

    final minLen = returnsBySymbol.values.map((r) => r.length).reduce(
          (a, b) => a < b ? a : b,
        );
    final portfolioReturns = List<double>.filled(minLen, 0);
    for (var i = 0; i < symbols.length; i++) {
      final symbol = symbols[i];
      final series = returnsBySymbol[symbol];
      if (series == null) continue;
      final slice = series.sublist(series.length - minLen);
      for (var j = 0; j < minLen; j++) {
        portfolioReturns[j] += slice[j] * normWeights[i];
      }
    }

    final sorted = portfolioReturns.toList()..sort();
    final idx = ((1 - confidence) * sorted.length).floor().clamp(0, sorted.length - 1);
    final varDaily = -sorted[idx];
    final varAnnual = varDaily * (252).sqrt();

    return {
      'var_daily_pct': double.parse((varDaily * 100).toStringAsFixed(2)),
      'var_annual_pct': double.parse((varAnnual * 100).toStringAsFixed(2)),
      'confidence': confidence,
      'observations': minLen,
      'mean_daily_return_pct':
          double.parse((Statistics.mean(portfolioReturns) * 100).toStringAsFixed(3)),
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
