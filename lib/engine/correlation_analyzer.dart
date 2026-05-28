import '../data/datasources/remote/yahoo_finance_client.dart';
import 'math/statistics.dart';

/// Pairwise return correlations — mirrors correlation_analyzer.py.
class CorrelationAnalyzer {
  CorrelationAnalyzer({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  static const lookbackDays = 90;

  Future<Map<String, Map<String, double>>?> getCorrelationMatrix(
    List<String> tickers,
  ) async {
    final symbols = tickers.map((t) => t.toUpperCase()).toSet().toList();
    if (symbols.length < 2) return null;

    final returnsBySymbol = <String, List<double>>{};
    for (final symbol in symbols) {
      final bars = await _yahoo.getOhlcvHistory(symbol, range: '6mo');
      if (bars.length < 25) continue;
      final closes = bars.map((b) => (b['close'] as num).toDouble()).toList();
      final trimmed = closes.length > lookbackDays
          ? closes.sublist(closes.length - lookbackDays)
          : closes;
      final returns = <double>[];
      for (var i = 1; i < trimmed.length; i++) {
        if (trimmed[i - 1] != 0) {
          returns.add((trimmed[i] - trimmed[i - 1]) / trimmed[i - 1]);
        }
      }
      if (returns.length >= 20) returnsBySymbol[symbol] = returns;
    }

    if (returnsBySymbol.length < 2) return null;

    final minLen = returnsBySymbol.values.map((r) => r.length).reduce(
          (a, b) => a < b ? a : b,
        );
    final matrix = <String, Map<String, double>>{};
    for (final a in returnsBySymbol.keys) {
      matrix[a] = {};
      final ra = returnsBySymbol[a]!.sublist(returnsBySymbol[a]!.length - minLen);
      for (final b in returnsBySymbol.keys) {
        final rb = returnsBySymbol[b]!.sublist(returnsBySymbol[b]!.length - minLen);
        matrix[a]![b] = _correlation(ra, rb);
      }
    }
    return matrix;
  }

  List<Map<String, dynamic>> getHighCorrelationPairs(
    Map<String, Map<String, double>> matrix, {
    double threshold = 0.75,
  }) {
    final pairs = <Map<String, dynamic>>[];
    final keys = matrix.keys.toList();
    for (var i = 0; i < keys.length; i++) {
      for (var j = i + 1; j < keys.length; j++) {
        final a = keys[i];
        final b = keys[j];
        final corr = matrix[a]?[b] ?? 0;
        if (corr.abs() >= threshold) {
          pairs.add({'a': a, 'b': b, 'correlation': corr});
        }
      }
    }
    pairs.sort(
      (x, y) => (y['correlation'] as double).abs().compareTo(
            (x['correlation'] as double).abs(),
          ),
    );
    return pairs;
  }

  /// Pearson correlation for two price series (uses last min length).
  double pairCorrelation(List<double> x, List<double> y) {
    final minLen = x.length < y.length ? x.length : y.length;
    if (minLen < 5) return 0;
    final ra = <double>[];
    final rb = <double>[];
    for (var i = 1; i < minLen; i++) {
      if (x[i - 1] != 0 && y[i - 1] != 0) {
        ra.add((x[i] - x[i - 1]) / x[i - 1]);
        rb.add((y[i] - y[i - 1]) / y[i - 1]);
      }
    }
    return _correlation(ra, rb);
  }

  double _correlation(List<double> x, List<double> y) {
    if (x.length != y.length || x.isEmpty) return 0;
    final mx = Statistics.mean(x);
    final my = Statistics.mean(y);
    var num = 0.0;
    var dx = 0.0;
    var dy = 0.0;
    for (var i = 0; i < x.length; i++) {
      final vx = x[i] - mx;
      final vy = y[i] - my;
      num += vx * vy;
      dx += vx * vx;
      dy += vy * vy;
    }
    if (dx == 0 || dy == 0) return 0;
    return num / (dx.sqrt() * dy.sqrt());
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
