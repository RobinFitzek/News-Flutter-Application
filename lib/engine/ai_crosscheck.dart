import '../data/datasources/remote/yahoo_finance_client.dart';

/// Validates AI claims vs Yahoo data — mirrors News/engine/ai_crosscheck.py.
class AiCrosscheck {
  AiCrosscheck({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static final _metricPatterns = <String, _MetricConfig>{
    'P/E Ratio': _MetricConfig(
      yfKeys: ['trailingPE', 'forwardPE'],
      patterns: [
        _Pattern(r'(?:P/?E|PE)\s*(?:ratio)?\s*(?:of|:|is|at)?\s*(\d+\.?\d*)', 1),
        _Pattern(r'(\d+\.?\d*)\s*x\s*earnings', 1),
      ],
    ),
    'Market Cap': _MetricConfig(
      yfKeys: ['marketCap'],
      patterns: [
        _Pattern(
          r'\$\s*(\d+\.?\d*)\s*(?:T|trillion)',
          1,
          multiplier: 1e12,
        ),
        _Pattern(
          r'\$\s*(\d+\.?\d*)\s*(?:B|billion)',
          1,
          multiplier: 1e9,
        ),
      ],
    ),
    'Revenue Growth': _MetricConfig(
      yfKeys: ['revenueGrowth'],
      patterns: [
        _Pattern(
          r'revenue\s*(?:grew|growth|increased|rising|up)\s*(?:of|by|:)?\s*(\d+\.?\d*)\s*%',
          1,
          multiplier: 0.01,
        ),
      ],
    ),
    'EPS': _MetricConfig(
      yfKeys: ['trailingEps'],
      patterns: [
        _Pattern(r'EPS\s*(?:of|:|is|at)\s*\$?\s*(\d+\.?\d*)', 1),
      ],
    ),
    'Dividend Yield': _MetricConfig(
      yfKeys: ['dividendYield'],
      patterns: [
        _Pattern(
          r'dividend\s*yield\s*(?:of|:|is|at)?\s*(\d+\.?\d*)\s*%',
          1,
          multiplier: 0.01,
        ),
      ],
    ),
    'Price': _MetricConfig(
      yfKeys: ['currentPrice', 'regularMarketPrice'],
      patterns: [
        _Pattern(r'trad(?:ing|es)\s*at\s*\$\s*(\d+\.?\d*)', 1),
        _Pattern(r'current\s*price\s*(?:of|:|is|at)\s*\$\s*(\d+\.?\d*)', 1),
      ],
    ),
  };

  Future<Map<String, dynamic>> checkAnalysis(
    String ticker,
    String analysisText,
  ) async {
    if (ticker.isEmpty || analysisText.isEmpty) {
      return _emptyResult(ticker, warning: 'No analysis text provided');
    }

    final claims = _extractClaims(analysisText);
    final actual = await _getActualData(ticker);

    if (claims.isEmpty) {
      return {
        'ticker': ticker.toUpperCase(),
        'claims_found': 0,
        'claims_verified': 0,
        'accuracy': 1.0,
        'details': <Map<String, dynamic>>[],
        'trust_score': 1.0,
        'warning': null,
      };
    }

    final details = <Map<String, dynamic>>[];
    final scores = <double>[];

    for (final claim in claims) {
      final config = _metricPatterns[claim['metric']]!;
      double? actualValue;
      for (final key in config.yfKeys) {
        if (actual.containsKey(key)) {
          actualValue = actual[key];
          break;
        }
      }
      if (actualValue == null) continue;

      final aiValue = claim['value'] as double;
      final comparison = _compare(aiValue, actualValue);
      scores.add(comparison.$1);
      details.add({
        'metric': claim['metric'],
        'ai_value': aiValue,
        'actual_value': actualValue,
        'score': comparison.$1,
        'status': comparison.$2,
      });
    }

    final verified = details.length;
    final accuracy =
        scores.isEmpty ? 0.0 : scores.reduce((a, b) => a + b) / scores.length;
    final trustScore = _calculateTrustScore(
      accuracy,
      verified,
      claims.length - verified,
    );

    String? warning;
    if (accuracy < 0.6 && verified > 0) {
      warning =
          'Low accuracy (${(accuracy * 100).toStringAsFixed(0)}%): AI analysis '
          'contains discrepancies from market data.';
    }

    return {
      'ticker': ticker.toUpperCase(),
      'claims_found': claims.length,
      'claims_verified': verified,
      'accuracy': double.parse(accuracy.toStringAsFixed(4)),
      'details': details,
      'trust_score': double.parse(trustScore.toStringAsFixed(4)),
      'warning': warning,
    };
  }

  Map<String, dynamic> _emptyResult(String ticker, {String? warning}) => {
        'ticker': ticker.toUpperCase(),
        'claims_found': 0,
        'claims_verified': 0,
        'accuracy': 0.0,
        'details': <Map<String, dynamic>>[],
        'trust_score': 0.0,
        'warning': warning,
      };

  List<Map<String, dynamic>> _extractClaims(String text) {
    final claims = <Map<String, dynamic>>[];
    final seen = <String>{};

    for (final entry in _metricPatterns.entries) {
      if (seen.contains(entry.key)) continue;
      for (final pattern in entry.value.patterns) {
        final match = pattern.regex.firstMatch(text);
        if (match != null) {
          final raw = double.tryParse(match.group(pattern.group)!);
          if (raw != null) {
            claims.add({
              'metric': entry.key,
              'value': raw * pattern.multiplier,
            });
            seen.add(entry.key);
            break;
          }
        }
      }
    }
    return claims;
  }

  Future<Map<String, double>> _getActualData(String ticker) async {
    try {
      final info = await _yahoo.getStockInfo(ticker);
      const keys = [
        'trailingPE',
        'forwardPE',
        'marketCap',
        'revenueGrowth',
        'trailingEps',
        'dividendYield',
        'currentPrice',
        'regularMarketPrice',
      ];
      final data = <String, double>{};
      for (final key in keys) {
        final val = info[key];
        if (val is num) data[key] = val.toDouble();
      }
      if (!data.containsKey('currentPrice') &&
          data.containsKey('regularMarketPrice')) {
        data['currentPrice'] = data['regularMarketPrice']!;
      }
      return data;
    } catch (_) {
      return {};
    }
  }

  (double, String) _compare(double claimed, double actual,
      {double tolerance = 0.10}) {
    if (actual == 0) {
      return claimed.abs() < 1e-6 ? (1.0, 'accurate') : (0.0, 'inaccurate');
    }
    final deviation = (claimed - actual).abs() / actual.abs();
    if (deviation <= tolerance) return (1.0, 'accurate');
    if (deviation <= 0.25) return (0.5, 'approximate');
    return (0.0, 'inaccurate');
  }

  double _calculateTrustScore(
    double accuracy,
    int verifiedCount,
    int unverifiableCount,
  ) {
    if (verifiedCount == 0 && unverifiableCount == 0) return 1.0;
    if (verifiedCount == 0) return 0.5;
    final total = verifiedCount + unverifiableCount;
    final coverage = verifiedCount / total;
    var trust = accuracy * (0.7 + 0.3 * coverage);
    if (verifiedCount >= 5) {
      trust = (trust + 0.05).clamp(0.0, 1.0);
    } else if (verifiedCount >= 3) {
      trust = (trust + 0.02).clamp(0.0, 1.0);
    }
    return trust.clamp(0.0, 1.0);
  }

  /// Minimum trust score to allow auto-trading when AI text is present.
  static const minTrustScore = 0.55;
}

class _MetricConfig {
  _MetricConfig({required this.yfKeys, required this.patterns});
  final List<String> yfKeys;
  final List<_Pattern> patterns;
}

class _Pattern {
  _Pattern(this.source, this.group, {this.multiplier = 1.0})
      : regex = RegExp(source, caseSensitive: false);
  final String source;
  final int group;
  final double multiplier;
  final RegExp regex;
}
