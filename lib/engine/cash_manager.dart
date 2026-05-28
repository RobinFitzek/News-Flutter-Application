import 'package:drift/drift.dart';

import '../core/app_settings_store.dart';
import '../data/database/app_database.dart';

/// Cash position tracking — mirrors News/engine/cash_manager.py.
class CashManager {
  CashManager(this._db) : _settings = AppSettingsStore(_db);

  final AppDatabase _db;
  final AppSettingsStore _settings;

  Future<double> getTotalCash() async {
    final rows = await _db.select(_db.cashPositions).get();
    return rows.fold<double>(0, (s, r) => s + r.amount);
  }

  Future<int> addCash(double amount, {String? description, DateTime? date}) async {
    return _db.into(_db.cashPositions).insert(
          CashPositionsCompanion.insert(
            amount: amount,
            description: Value(description ?? (amount >= 0 ? 'Deposit' : 'Withdrawal')),
            transactionDate: Value(date ?? DateTime.now()),
          ),
        );
  }

  Future<int> withdrawCash(double amount, {String? description}) =>
      addCash(-amount.abs(), description: description ?? 'Withdrawal');

  Future<List<CashPositionData>> getCashHistory({int limit = 50}) async {
    return (_db.select(_db.cashPositions)
          ..orderBy([(t) => OrderingTerm.desc(t.transactionDate)])
          ..limit(limit))
        .get();
  }

  Future<Map<String, dynamic>> getPortfolioTotal(double stockValue) async {
    final cash = await getTotalCash();
    final total = stockValue + cash;
    final cashPct = total > 0 ? (cash / total) * 100 : 0.0;
    return {
      'stock_value': double.parse(stockValue.toStringAsFixed(2)),
      'cash_value': double.parse(cash.toStringAsFixed(2)),
      'total_value': double.parse(total.toStringAsFixed(2)),
      'cash_percentage': double.parse(cashPct.toStringAsFixed(1)),
    };
  }

  Future<Map<String, dynamic>> getCashAllocationRecommendation() async {
    final stockRows = await _db.select(_db.portfolioPositions).get();
    var stockValue = 0.0;
    for (final p in stockRows) {
      stockValue += p.shares * p.currentPrice;
    }
    final totals = await getPortfolioTotal(stockValue);
    final pct = totals['cash_percentage'] as double;
    String status;
    String action;
    if (pct < 5) {
      status = 'CRITICAL';
      action = 'Cash buffer critically low — consider raising liquidity';
    } else if (pct < 10) {
      status = 'WARNING';
      action = 'Cash slightly below target range (10–30%)';
    } else if (pct > 30) {
      status = 'WARNING';
      action = 'High cash allocation — consider deploying capital';
    } else {
      status = 'GOOD';
      action = 'Healthy cash allocation';
    }
    return {'status': status, 'action': action, ...totals};
  }

  Future<void> autoRecordTradeCashFlow({
    required String type,
    required double amountUsd,
    required String symbol,
  }) async {
    final enabled = await _settings.getBool('cash_auto_record', defaultValue: true);
    if (!enabled) return;
    final flow = type.toUpperCase() == 'BUY' ? -amountUsd : amountUsd;
    await addCash(
      flow,
      description: '${type.toUpperCase()} $symbol',
    );
  }
}
