import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Top picks from verified prediction accuracy — mirrors db.get_top_picks().
class TopPicksEngine {
  TopPicksEngine(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  Future<Map<String, dynamic>> getTopPicks({
    int minPredictions = 5,
    double minAccuracy = 0.6,
    int limit = 20,
  }) async {
    final verified = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNotNull()))
        .get();

    final byTicker = <String, List<PredictionOutcomeData>>{};
    for (final p in verified) {
      byTicker.putIfAbsent(p.symbol, () => []).add(p);
    }

    final picks = <Map<String, dynamic>>[];
    for (final entry in byTicker.entries) {
      final group = entry.value;
      if (group.length < minPredictions) continue;

      final correct =
          group.where((p) => (p.accuracyScore ?? 0) >= 0.9).length;
      final wrong = group.where((p) => (p.accuracyScore ?? 0) <= 0.1).length;
      final accuracy = group.fold<double>(
            0,
            (s, p) => s + (p.accuracyScore ?? 0.5),
          ) /
          group.length;
      if (accuracy < minAccuracy) continue;

      final avgConf =
          group.fold<double>(0, (s, p) => s + p.confidence) / group.length;
      final winRate = correct / group.length;
      final consistency = 1 - (2 * winRate - 1).abs();
      final pickScore =
          accuracy * 0.5 + (avgConf / 100) * 0.3 + consistency * 0.2;

      String trustTier = 'none';
      if (accuracy >= 0.8 && avgConf >= 75) {
        trustTier = 'gold';
      } else if (accuracy >= 0.7 && avgConf >= 65) {
        trustTier = 'silver';
      } else if (accuracy >= 0.6) {
        trustTier = 'bronze';
      }

      final lastVerified = group
          .map((p) => p.verifiedAt)
          .whereType<DateTime>()
          .reduce((a, b) => a.isAfter(b) ? a : b);

      picks.add({
        'ticker': entry.key,
        'total_predictions': group.length,
        'accuracy': double.parse((accuracy * 100).toStringAsFixed(1)),
        'avg_confidence': double.parse(avgConf.toStringAsFixed(1)),
        'consistency': double.parse(consistency.toStringAsFixed(3)),
        'pick_score': double.parse(pickScore.toStringAsFixed(3)),
        'trust_tier': trustTier,
        'correct_count': correct,
        'wrong_count': wrong,
        'last_verified': lastVerified.toIso8601String(),
      });
    }

    picks.sort((a, b) =>
        (b['pick_score'] as double).compareTo(a['pick_score'] as double));

    final recentSignals = await _recentHighConfidence(days: 7, minConfidence: 70);
    final totalTrusted =
        picks.where((p) => (p['accuracy'] as double) >= 70).length;

    return {
      'top_picks': picks.take(limit).toList(),
      'recent_signals': recentSignals,
      'total_trusted': totalTrusted,
    };
  }

  Future<List<Map<String, dynamic>>> _recentHighConfidence({
    required int days,
    required int minConfidence,
  }) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final rows = await (_db.select(_db.analysisResults)
          ..where((t) => t.createdAt.isBiggerOrEqualValue(cutoff))
          ..where((t) => t.confidence.isBiggerOrEqualValue(minConfidence / 100)))
        .get();

    return rows
        .map((r) => {
              'ticker': r.symbol,
              'signal': r.signal,
              'confidence': (r.confidence * 100).round(),
              'recommendation': r.recommendation,
              'created_at': r.createdAt.toIso8601String(),
            })
        .toList();
  }
}

/// Graveyard performance tracking — mirrors /api/graveyard/performance.
class GraveyardTracker {
  GraveyardTracker(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  Future<void> addToGraveyard(String ticker, {String? reason}) async {
    await _db.into(_db.tickerGraveyard).insertOnConflictUpdate(
          TickerGraveyardCompanion.insert(
            ticker: ticker.toUpperCase(),
            reason: reason ?? 'No data from yfinance (possible delisting)',
            lastSeen: Value(DateTime.now().toIso8601String().split('T').first),
          ),
        );
  }

  Future<bool> isInGraveyard(String ticker) async {
    final row = await (_db.select(_db.tickerGraveyard)
          ..where((t) => t.ticker.equals(ticker.toUpperCase())))
        .getSingleOrNull();
    return row != null;
  }

  Future<List<Map<String, dynamic>>> getPerformance({int limit = 50}) async {
    final rows = await (_db.select(_db.tickerGraveyard)
          ..orderBy([(t) => OrderingTerm.desc(t.addedAt)])
          ..limit(limit))
        .get();

    final results = <Map<String, dynamic>>[];
    for (final row in rows) {
      try {
        final q = await _yahoo.getStockQuote(row.ticker);
        final current = (q['currentPrice'] as num?)?.toDouble();
        if (current == null) continue;

        final bars = await _yahoo.getOhlcvHistory(row.ticker, range: '1y');
        double? removalPrice;
        for (final bar in bars) {
          final ts = bar['timestamp'] as DateTime? ??
              DateTime.tryParse(bar['date']?.toString() ?? '');
          if (ts != null && !ts.isBefore(row.addedAt)) {
            removalPrice = (bar['close'] as num).toDouble();
            break;
          }
        }
        removalPrice ??=
            bars.isNotEmpty ? (bars.first['close'] as num).toDouble() : current;

        final changePct = removalPrice > 0
            ? ((current - removalPrice) / removalPrice) * 100
            : 0.0;

        results.add({
          'ticker': row.ticker,
          'reason': row.reason,
          'removed_at': row.addedAt.toIso8601String(),
          'removal_price': double.parse(removalPrice.toStringAsFixed(2)),
          'current_price': double.parse(current.toStringAsFixed(2)),
          'change_pct': double.parse(changePct.toStringAsFixed(2)),
        });
      } catch (_) {}
    }
    return results;
  }
}
