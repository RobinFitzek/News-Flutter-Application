import 'package:drift/drift.dart';

import '../data/database/app_database.dart';

/// Risk score trend over time from analysis history.
class RiskTrend {
  RiskTrend(this._db);

  final AppDatabase _db;

  Future<List<Map<String, dynamic>>> getRiskTrend(String ticker, {int limit = 20}) async {
    final rows = await (_db.select(_db.analysisResults)
          ..where((t) => t.symbol.equals(ticker.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();

    final points = rows.reversed.map((r) => {
          'date': r.createdAt.toIso8601String().split('T').first,
          'risk_score': r.riskScore,
          'geo_risk_score': r.geoRiskScore,
          'signal': r.signal,
          'confidence': (r.confidence * 100).round(),
        }).toList();

    String trend = 'stable';
    if (points.length >= 3) {
      final first = points.first['risk_score'] as int;
      final last = points.last['risk_score'] as int;
      if (last > first + 1) {
        trend = 'rising';
      } else if (last < first - 1) {
        trend = 'falling';
      }
    }

    return points;
  }

  Future<Map<String, dynamic>> getRiskTrendSummary(String ticker) async {
    final points = await getRiskTrend(ticker);
    if (points.isEmpty) {
      return {'ticker': ticker, 'points': [], 'trend': 'unknown', 'current_risk': null};
    }
    return {
      'ticker': ticker.toUpperCase(),
      'points': points,
      'trend': points.length >= 2
          ? (points.last['risk_score'] as int) > (points.first['risk_score'] as int)
              ? 'rising'
              : (points.last['risk_score'] as int) < (points.first['risk_score'] as int)
                  ? 'falling'
                  : 'stable'
          : 'stable',
      'current_risk': points.last['risk_score'],
      'avg_risk': points.isEmpty
          ? null
          : double.parse(
              (points.fold<int>(0, (s, p) => s + (p['risk_score'] as int)) /
                      points.length)
                  .toStringAsFixed(1)),
    };
  }
}
