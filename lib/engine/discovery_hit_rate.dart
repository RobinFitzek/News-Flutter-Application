import 'dart:math';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Discovery hit rate tracker — mirrors News/engine/discovery_hit_rate.py.
class DiscoveryHitRate {
  DiscoveryHitRate(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  Future<Map<String, dynamic>> checkOutcomes() async {
    final promoted = await (_db.select(_db.discoveries)
          ..where((t) => t.isPromoted.equals(true))
          ..where((t) => t.promotedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.promotedAt)])
          ..limit(200))
        .get();

    var updated = 0;
    final now = DateTime.now();

    for (final disc in promoted) {
      final promotedAt = disc.promotedAt!;
      final daysElapsed = now.difference(promotedAt).inDays;
      if (daysElapsed < 25) continue;

      final existing = await (_db.select(_db.discoveryOutcomes)
            ..where((t) => t.discoveryId.equals(disc.id)))
          .getSingleOrNull();

      final needs30 =
          daysElapsed >= 30 && (existing?.price30d == null);
      final needs60 =
          daysElapsed >= 60 && (existing?.price60d == null);
      final needs90 =
          daysElapsed >= 90 && (existing?.price90d == null);
      if (!needs30 && !needs60 && !needs90) continue;

      try {
        final bars = await _yahoo.getOhlcvHistory(
          disc.symbol,
          range: '6mo',
        );
        if (bars.isEmpty) continue;

        double? priceAtDay(int days) {
          final target = promotedAt.add(Duration(days: days));
          for (final bar in bars) {
            final ts = bar['timestamp'] as DateTime? ??
                DateTime.tryParse(bar['date']?.toString() ?? '');
            if (ts != null && !ts.isBefore(target)) {
              return (bar['close'] as num).toDouble();
            }
          }
          return null;
        }

        final p30 = needs30 ? priceAtDay(30) : existing?.price30d;
        final p60 = needs60 ? priceAtDay(60) : existing?.price60d;
        final p90 = needs90 ? priceAtDay(90) : existing?.price90d;
        final base = disc.currentPrice;

        double? ret(double? p) =>
            p != null && base > 0 ? ((p - base) / base) * 100 : null;

        if (existing != null) {
          await (_db.update(_db.discoveryOutcomes)
                ..where((t) => t.id.equals(existing.id)))
              .write(DiscoveryOutcomesCompanion(
            price30d: p30 != null ? Value(p30) : const Value.absent(),
            price60d: p60 != null ? Value(p60) : const Value.absent(),
            price90d: p90 != null ? Value(p90) : const Value.absent(),
            return30d: ret(p30) != null
                ? Value(double.parse(ret(p30)!.toStringAsFixed(2)))
                : const Value.absent(),
            return60d: ret(p60) != null
                ? Value(double.parse(ret(p60)!.toStringAsFixed(2)))
                : const Value.absent(),
            return90d: ret(p90) != null
                ? Value(double.parse(ret(p90)!.toStringAsFixed(2)))
                : const Value.absent(),
            updatedAt: Value(DateTime.now()),
          ));
        } else {
          await _db.into(_db.discoveryOutcomes).insert(
                DiscoveryOutcomesCompanion.insert(
                  discoveryId: disc.id,
                  symbol: disc.symbol,
                  promotedAt: promotedAt,
                  promotedPrice: base,
                  strategy: Value(disc.strategy),
                  price30d: Value(p30),
                  price60d: Value(p60),
                  price90d: Value(p90),
                  return30d: Value(ret(p30)),
                  return60d: Value(ret(p60)),
                  return90d: Value(ret(p90)),
                ),
              );
        }
        updated++;
      } catch (_) {
        continue;
      }
    }
    return {'updated': updated};
  }

  Future<List<Map<String, dynamic>>> getStrategyHitRates() async {
    final rows = await _db.customSelect('''
      SELECT strategy,
        COUNT(*) as total,
        SUM(CASE WHEN return_30d > 0 THEN 1 ELSE 0 END) as wins_30d,
        SUM(CASE WHEN return_60d > 0 THEN 1 ELSE 0 END) as wins_60d,
        SUM(CASE WHEN return_90d > 0 THEN 1 ELSE 0 END) as wins_90d,
        AVG(return_30d) as avg_30d,
        AVG(return_60d) as avg_60d,
        AVG(return_90d) as avg_90d,
        COUNT(return_30d) as n_30d,
        COUNT(return_60d) as n_60d,
        COUNT(return_90d) as n_90d
      FROM discovery_outcomes
      GROUP BY strategy
      ORDER BY avg_30d DESC
    ''').get();

    return rows.map((r) {
      final n30 = max(1, r.read<int>('n_30d'));
      final n60 = max(1, r.read<int>('n_60d'));
      final n90 = max(1, r.read<int>('n_90d'));
      return {
        'strategy': r.read<String?>('strategy') ?? 'unknown',
        'total': r.read<int>('total'),
        'hit_rate_30d':
            double.parse((r.read<int>('wins_30d') / n30 * 100).toStringAsFixed(1)),
        'hit_rate_60d':
            double.parse((r.read<int>('wins_60d') / n60 * 100).toStringAsFixed(1)),
        'hit_rate_90d':
            double.parse((r.read<int>('wins_90d') / n90 * 100).toStringAsFixed(1)),
        'avg_return_30d':
            double.parse((r.read<double?>('avg_30d') ?? 0).toStringAsFixed(2)),
        'avg_return_60d':
            double.parse((r.read<double?>('avg_60d') ?? 0).toStringAsFixed(2)),
        'avg_return_90d':
            double.parse((r.read<double?>('avg_90d') ?? 0).toStringAsFixed(2)),
      };
    }).toList();
  }

  Future<Map<String, dynamic>> getOverallHitRate() async {
    final row = await _db.customSelect('''
      SELECT COUNT(*) as total,
        COUNT(return_30d) as with_30d,
        SUM(CASE WHEN return_30d > 0 THEN 1 ELSE 0 END) as wins_30d,
        AVG(return_30d) as avg_30d,
        COUNT(return_90d) as with_90d,
        SUM(CASE WHEN return_90d > 0 THEN 1 ELSE 0 END) as wins_90d,
        AVG(return_90d) as avg_90d
      FROM discovery_outcomes
    ''').getSingleOrNull();

    if (row == null || row.read<int>('total') == 0) {
      return {'available': false};
    }

    final n30 = max(1, row.read<int>('with_30d'));
    final n90 = max(1, row.read<int>('with_90d'));
    return {
      'available': true,
      'total_tracked': row.read<int>('total'),
      'hit_rate_30d':
          double.parse((row.read<int>('wins_30d') / n30 * 100).toStringAsFixed(1)),
      'avg_return_30d':
          double.parse((row.read<double?>('avg_30d') ?? 0).toStringAsFixed(2)),
      'hit_rate_90d':
          double.parse((row.read<int>('wins_90d') / n90 * 100).toStringAsFixed(1)),
      'avg_return_90d':
          double.parse((row.read<double?>('avg_90d') ?? 0).toStringAsFixed(2)),
    };
  }
}
