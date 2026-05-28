import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Smart money / institutional activity — mirrors institutional_tracker smart money.
class SmartMoneyTracker {
  SmartMoneyTracker(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  Future<Map<String, dynamic>> getSmartMoneyActivity(
    String ticker, {
    int daysBack = 95,
  }) async {
    ticker = ticker.toUpperCase();
    await _refreshIfStale(ticker);

    final cutoff = DateTime.now().subtract(Duration(days: daysBack));
    final rows = await (_db.select(_db.institutionalHolders)
          ..where((t) => t.symbol.equals(ticker))
          ..where((t) => t.reportDate.isBiggerOrEqualValue(cutoff)))
        .get();

    if (rows.isEmpty) {
      return {
        'ticker': ticker,
        'new_positions': <Map<String, dynamic>>[],
        'increased': <Map<String, dynamic>>[],
        'decreased': <Map<String, dynamic>>[],
        'smart_money_badge': false,
        'total_top_filers_holding': 0,
      };
    }

    final byFiler = <String, InstitutionalHolderData>{};
    for (final r in rows) {
      final existing = byFiler[r.holderName];
      if (existing == null || r.reportDate.isAfter(existing.reportDate)) {
        byFiler[r.holderName] = r;
      }
    }

    final newPositions = <Map<String, dynamic>>[];
    final increased = <Map<String, dynamic>>[];
    final decreased = <Map<String, dynamic>>[];

    for (final current in byFiler.values) {
      final prev = await (_db.select(_db.institutionalHolders)
            ..where((t) =>
                t.symbol.equals(ticker) &
                t.holderName.equals(current.holderName) &
                t.reportDate.isSmallerThanValue(current.reportDate))
            ..orderBy([(t) => OrderingTerm.desc(t.reportDate)])
            ..limit(1))
          .getSingleOrNull();

      if (prev == null) {
        newPositions.add(_toMap(current, null));
      } else if (prev.shares > 0) {
        final changePct = ((current.shares - prev.shares) / prev.shares) * 100;
        if (changePct > 5) {
          increased.add(_toMap(current, changePct));
        } else if (changePct < -5) {
          decreased.add(_toMap(current, changePct));
        }
      }
    }

    return {
      'ticker': ticker,
      'new_positions': newPositions,
      'increased': increased,
      'decreased': decreased,
      'smart_money_badge': newPositions.isNotEmpty || increased.isNotEmpty,
      'total_top_filers_holding': byFiler.length,
    };
  }

  Map<String, dynamic> _toMap(InstitutionalHolderData h, double? changePct) => {
        'filer_name': h.holderName,
        'shares': h.shares,
        'value': h.value,
        'change_pct': changePct ?? h.change,
        'report_date': h.reportDate.toIso8601String(),
      };

  Future<void> _refreshIfStale(String ticker) async {
    final latest = await (_db.select(_db.institutionalHolders)
          ..where((t) => t.symbol.equals(ticker))
          ..orderBy([(t) => OrderingTerm.desc(t.reportDate)])
          ..limit(1))
        .getSingleOrNull();

    if (latest != null &&
        DateTime.now().difference(latest.reportDate).inDays < 7) {
      return;
    }

    try {
      final holders = await _yahoo.getInstitutionalHolders(ticker);
      for (final h in holders) {
        try {
          await _db.into(_db.institutionalHolders).insert(
                InstitutionalHoldersCompanion.insert(
                  symbol: ticker,
                  holderName: h['holderName']?.toString() ?? 'Unknown',
                  shares: (h['shares'] as num?)?.toDouble() ?? 0,
                  value: (h['value'] as num?)?.toDouble() ?? 0,
                  percentOut: (h['percentOut'] as num?)?.toDouble() ?? 0,
                  reportDate: DateTime.now(),
                  change: Value((h['change'] as num?)?.toDouble()),
                ),
              );
        } catch (_) {}
      }
    } catch (_) {}
  }
}
