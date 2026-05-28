import 'dart:math';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';
import 'correlation_analyzer.dart';

/// Portfolio-level anomaly detection — mirrors News/engine/portfolio_anomaly.py.
class PortfolioAnomaly {
  PortfolioAnomaly({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  Future<List<Map<String, dynamic>>> scan(
    List<PositionData> holdings,
  ) async {
    final active =
        holdings.where((h) => h.shares > 0 && h.currentPrice > 0).toList();
    if (active.length < 2) return [];

    final anomalies = <Map<String, dynamic>>[];

    // 1. Systemic direction — >70% moving same direction intraday
    var up = 0;
    var down = 0;
    for (final h in active) {
      try {
        final q = await _yahoo.getStockQuote(h.symbol);
        final change = (q['changePercent'] as num?)?.toDouble() ?? 0;
        if (change > 0.1) {
          up++;
        } else if (change < -0.1) {
          down++;
        }
      } catch (_) {}
    }
    final total = active.length;
    if (up / total > 0.7 || down / total > 0.7) {
      anomalies.add({
        'type': 'systemic_direction',
        'severity': 0.8,
        'description':
            '${max(up, down)} of $total holdings moving ${up > down ? 'up' : 'down'} today',
      });
    }

    // 2. Correlation spike
    if (active.length >= 3) {
      final series = <List<double>>[];
      for (final h in active.take(8)) {
        try {
          final bars = await _yahoo.getOhlcvHistory(h.symbol, range: '3mo');
          if (bars.length >= 20) {
            series.add(bars
                .map((b) => (b['close'] as num).toDouble())
                .toList());
          }
        } catch (_) {}
      }
      if (series.length >= 2) {
        final analyzer = CorrelationAnalyzer();
        var sumCorr = 0.0;
        var pairs = 0;
        for (var i = 0; i < series.length; i++) {
          for (var j = i + 1; j < series.length; j++) {
            sumCorr += analyzer.pairCorrelation(series[i], series[j]).abs();
            pairs++;
          }
        }
        final avgCorr = pairs > 0 ? sumCorr / pairs : 0;
        if (avgCorr > 0.75) {
          anomalies.add({
            'type': 'correlation_spike',
            'severity': avgCorr,
            'description':
                'High pairwise correlation (${avgCorr.toStringAsFixed(2)}) — diversification risk',
          });
        }
      }
    }

    // 3. Beta creep — effective beta > 1.5
    var weightedBeta = 0.0;
    var totalValue = 0.0;
    for (final h in active) {
      final value = h.shares * h.currentPrice;
      totalValue += value;
      try {
        final info = await _yahoo.getStockInfo(h.symbol);
        weightedBeta +=
            value * ((info['beta'] as num?)?.toDouble() ?? 1.0);
      } catch (_) {
        weightedBeta += value;
      }
    }
    if (totalValue > 0) {
      final portBeta = weightedBeta / totalValue;
      if (portBeta > 1.5) {
        anomalies.add({
          'type': 'beta_creep',
          'severity': portBeta / 1.5,
          'description':
              'Portfolio beta ${portBeta.toStringAsFixed(2)} exceeds 1.5 target',
        });
      }
    }

    return anomalies;
  }
}
