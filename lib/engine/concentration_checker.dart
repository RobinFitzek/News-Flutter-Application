import '../data/datasources/remote/yahoo_finance_client.dart';
import 'correlation_analyzer.dart';

/// Sector and position concentration — mirrors concentration_checker.py.
class ConcentrationChecker {
  ConcentrationChecker({
    YahooFinanceClient? yahoo,
    CorrelationAnalyzer? correlation,
  })  : _yahoo = yahoo ?? YahooFinanceClient(),
        _correlation = correlation ?? CorrelationAnalyzer();

  final YahooFinanceClient _yahoo;
  final CorrelationAnalyzer _correlation;
  final _sectorCache = <String, String>{};

  Future<Map<String, dynamic>> checkPortfolio(
    List<Map<String, dynamic>> holdings,
  ) async {
    if (holdings.isEmpty) {
      return {
        'warnings': <String>[],
        'sector_breakdown': <String, double>{},
        'diversification_score': 100,
        'high_correlation_pairs': <Map<String, dynamic>>[],
      };
    }

    final totalValue = holdings.fold<double>(
      0,
      (s, h) => s + ((h['value'] as num?)?.toDouble() ?? 0),
    );
    if (totalValue <= 0) {
      return {
        'warnings': ['Portfolio value is zero'],
        'sector_breakdown': <String, double>{},
        'diversification_score': 0,
        'high_correlation_pairs': <Map<String, dynamic>>[],
      };
    }

    final warnings = <String>[];
    final sectorBreakdown = <String, double>{};

    for (final h in holdings) {
      final symbol = h['symbol'] as String;
      final value = (h['value'] as num?)?.toDouble() ?? 0;
      final weight = value / totalValue * 100;
      if (weight >= 15) {
        warnings.add('$symbol is ${weight.toStringAsFixed(1)}% of portfolio');
      }
      final sector = await _sector(symbol);
      sectorBreakdown[sector] = (sectorBreakdown[sector] ?? 0) + weight;
    }

    for (final entry in sectorBreakdown.entries) {
      if (entry.value >= 30) {
        warnings.add('${entry.key} sector at ${entry.value.toStringAsFixed(1)}%');
      }
    }

    final symbols = holdings.map((h) => h['symbol'] as String).toList();
    final matrix = await _correlation.getCorrelationMatrix(symbols);
    final highPairs = matrix == null
        ? <Map<String, dynamic>>[]
        : _correlation.getHighCorrelationPairs(matrix);

    for (final pair in highPairs.take(3)) {
      warnings.add(
        'High correlation ${pair['a']}/${pair['b']}: '
        '${(pair['correlation'] as double).toStringAsFixed(2)}',
      );
    }

    var score = 100.0;
    score -= sectorBreakdown.values.where((w) => w > 20).length * 10;
    score -= highPairs.length * 5;
    score -= warnings.where((w) => w.contains('% of portfolio')).length * 8;
    score = score.clamp(0, 100);

    return {
      'warnings': warnings,
      'sector_breakdown': sectorBreakdown,
      'diversification_score': double.parse(score.toStringAsFixed(0)),
      'high_correlation_pairs': highPairs,
    };
  }

  Future<String> _sector(String symbol) async {
    final key = symbol.toUpperCase();
    if (_sectorCache.containsKey(key)) return _sectorCache[key]!;
    try {
      final info = await _yahoo.getStockInfo(key);
      final sector = info['sector']?.toString() ?? 'Unknown';
      _sectorCache[key] = sector;
      return sector;
    } catch (_) {
      return 'Unknown';
    }
  }
}
