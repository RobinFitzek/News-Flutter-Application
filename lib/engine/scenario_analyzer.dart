import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Portfolio stress scenarios — mirrors News/engine/scenario_analyzer.py.
class ScenarioAnalyzer {
  ScenarioAnalyzer({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const sectorRateSensitivity = {
    'Technology': -0.8,
    'Real Estate': -1.2,
    'Utilities': -0.9,
    'Consumer Discretionary': -0.5,
    'Financial Services': 0.6,
    'Financials': 0.6,
    'Healthcare': -0.2,
    'Consumer Defensive': -0.1,
    'Consumer Staples': -0.1,
    'Energy': 0.1,
    'Industrials': -0.3,
    'Communication Services': -0.4,
  };

  static const presetScenarios = {
    'rate_hike': {
      'name': 'Interest Rates +100bps',
      'description': 'Fed raises rates by 100 basis points',
      'type': 'rate',
      'magnitude': 1.0,
    },
    'rate_cut': {
      'name': 'Interest Rates -100bps',
      'description': 'Fed cuts rates by 100 basis points',
      'type': 'rate',
      'magnitude': -1.0,
    },
    'market_crash': {
      'name': 'Market Crash -20%',
      'description': 'Broad market decline of 20%',
      'type': 'market',
      'magnitude': -0.20,
    },
    'market_rally': {
      'name': 'Market Rally +15%',
      'description': 'Broad market rally of 15%',
      'type': 'market',
      'magnitude': 0.15,
    },
    'tech_rotation': {
      'name': 'Tech Rotation',
      'description': 'Growth/tech to value/defensive rotation',
      'type': 'rotation',
      'profile': 'tech_rotation',
    },
  };

  List<Map<String, dynamic>> getPresetScenarios() {
    return presetScenarios.entries
        .map((e) => {'key': e.key, ...e.value})
        .toList();
  }

  Future<Map<String, dynamic>> runScenario(
    String scenarioKey,
    List<PositionData> holdings,
  ) async {
    final scenario = presetScenarios[scenarioKey];
    if (scenario == null) {
      return {'error': 'Unknown scenario: $scenarioKey'};
    }

    final active =
        holdings.where((h) => h.shares > 0 && h.currentPrice > 0).toList();
    if (active.isEmpty) {
      return {'error': 'No active holdings', 'impacts': []};
    }

    var totalValue = 0.0;
    final impacts = <Map<String, dynamic>>[];

    for (final h in active) {
      final value = h.shares * h.currentPrice;
      totalValue += value;
      Map<String, dynamic> info = {};
      try {
        info = await _yahoo.getStockInfo(h.symbol);
      } catch (_) {}
      final sector = info['sector']?.toString() ?? 'Unknown';
      final beta = (info['beta'] as num?)?.toDouble() ?? 1.0;

      double pctChange;
      switch (scenario['type']) {
        case 'rate':
          final sens = sectorRateSensitivity[sector] ?? -0.3;
          pctChange = (scenario['magnitude'] as num) * sens * 0.02;
        case 'market':
          pctChange = beta * (scenario['magnitude'] as num);
        case 'rotation':
          pctChange = _rotationImpact(sector, scenario['profile'] as String);
        default:
          pctChange = 0;
      }

      final impactUsd = value * pctChange;
      impacts.add({
        'symbol': h.symbol,
        'sector': sector,
        'beta': double.parse(beta.toStringAsFixed(2)),
        'value': double.parse(value.toStringAsFixed(2)),
        'pct_change': double.parse((pctChange * 100).toStringAsFixed(2)),
        'impact_usd': double.parse(impactUsd.toStringAsFixed(2)),
      });
    }

    final totalImpact =
        impacts.fold<double>(0, (s, i) => s + (i['impact_usd'] as double));
    final totalPct =
        totalValue > 0 ? (totalImpact / totalValue) * 100 : 0.0;

    impacts.sort((a, b) =>
        (a['impact_usd'] as double).compareTo(b['impact_usd'] as double));

    return {
      'scenario': scenario['name'],
      'description': scenario['description'],
      'portfolio_value': double.parse(totalValue.toStringAsFixed(2)),
      'total_impact_usd': double.parse(totalImpact.toStringAsFixed(2)),
      'total_impact_pct': double.parse(totalPct.toStringAsFixed(2)),
      'impacts': impacts,
    };
  }

  double _rotationImpact(String sector, String profile) {
    const profiles = {
      'tech_rotation': {
        'Technology': -0.15,
        'Communication Services': -0.10,
        'Consumer Discretionary': -0.08,
        'Utilities': 0.06,
        'Consumer Staples': 0.05,
        'Healthcare': 0.04,
        'Financials': 0.03,
      },
    };
    return profiles[profile]?[sector] ?? 0.0;
  }
}
