import 'package:drift/drift.dart';

import 'dart:math';

import '../core/app_settings_store.dart';
import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';
import 'cash_manager.dart';
import 'correlation_analyzer.dart';

/// Rule-based portfolio monitoring — mirrors News/engine/portfolio_manager.py.
class PortfolioManager {
  PortfolioManager(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient(),
        _settings = AppSettingsStore(_db),
        _cash = CashManager(_db);

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;
  final AppSettingsStore _settings;
  final CashManager _cash;

  static const strategyPresets = {
    'balanced': {'growth': 0.5, 'blue_chip': 0.5},
    'growth': {'growth': 0.7, 'blue_chip': 0.3},
    'value': {'growth': 0.3, 'blue_chip': 0.7},
  };

  Future<Map<String, dynamic>> checkAllRules() async {
    final holdings = await _db.select(_db.portfolioPositions).get();
    if (holdings.isEmpty) {
      return {
        'alerts': <Map<String, dynamic>>[],
        'benchmark': null,
        'rebalancing': <Map<String, dynamic>>[],
        'portfolio_value': 0.0,
        'message': 'No active holdings',
        'risk_gate': await getRiskGateStatus(),
      };
    }

    final enriched = await _enrichWithPrices(holdings);
    final cashTotal = await _cash.getTotalCash();
    final stockValue =
        enriched.fold<double>(0, (s, h) => s + (h['current_value'] as double));
    final totalValue = stockValue + cashTotal;

    if (totalValue <= 0) {
      return {
        'alerts': <Map<String, dynamic>>[],
        'benchmark': null,
        'rebalancing': <Map<String, dynamic>>[],
        'portfolio_value': 0.0,
        'risk_gate': await getRiskGateStatus(),
      };
    }

    final maxPos = await _settings.getDouble('portfolio_max_position_pct', 10);
    final stopLoss = await _settings.getDouble('portfolio_stop_loss_pct', 15);
    final maxSector = await _settings.getDouble('portfolio_max_sector_pct', 30);

    final alerts = <Map<String, dynamic>>[];
    alerts.addAll(_checkPositionSize(enriched, totalValue, maxPos));
    alerts.addAll(await _checkStopLoss(enriched, stopLoss));
    alerts.addAll(_checkSectorConcentration(enriched, totalValue, maxSector));

    double? diversificationScore;
    try {
      final corr = CorrelationAnalyzer(yahoo: _yahoo);
      final symbols = enriched.map((h) => h['symbol'] as String).toList();
      final matrix = await corr.getCorrelationMatrix(symbols);
      if (matrix != null && matrix.isNotEmpty) {
        final pairs = corr.getHighCorrelationPairs(matrix, threshold: 0.5);
        diversificationScore =
            (1 - (pairs.length / max(1, symbols.length))).clamp(0.0, 1.0);
      }
      if (diversificationScore != null && diversificationScore < 0.4) {
        alerts.add({
          'type': 'CORRELATION',
          'severity': 'WARNING',
          'message':
              'Low diversification score (${diversificationScore.toStringAsFixed(2)})',
        });
      }
    } catch (_) {}

    return {
      'alerts': alerts,
      'benchmark': await _trackBenchmark(enriched),
      'rebalancing': await _suggestRebalancing(enriched, totalValue),
      'portfolio_value': double.parse(totalValue.toStringAsFixed(2)),
      'stock_value': double.parse(stockValue.toStringAsFixed(2)),
      'cash_value': double.parse(cashTotal.toStringAsFixed(2)),
      'diversification_score': diversificationScore,
      'risk_gate': await getRiskGateStatus(),
      'holdings': enriched,
    };
  }

  Future<Map<String, dynamic>> getRiskGateStatus() async {
    final enabled =
        await _settings.getBool('portfolio_risk_guard_enabled', defaultValue: true);
    final threshold =
        await _settings.getDouble('portfolio_global_loss_limit_pct', 10);
    final cooldownHours =
        await _settings.getDouble('portfolio_risk_cooldown_hours', 24);
    final triggeredAtStr = await _settings.get('portfolio_risk_guard_triggered_at');

    if (!enabled) {
      return {
        'active': false,
        'enabled': false,
        'loss_pct': 0.0,
        'threshold_pct': threshold,
        'cooldown_hours': cooldownHours,
        'triggered_at': triggeredAtStr,
        'reason': 'Risk guard disabled',
      };
    }

    final holdings = await _db.select(_db.portfolioPositions).get();
    if (holdings.isEmpty) {
      return {
        'active': false,
        'enabled': true,
        'loss_pct': 0.0,
        'threshold_pct': threshold,
        'cooldown_hours': cooldownHours,
        'triggered_at': triggeredAtStr,
        'reason': 'No active holdings',
      };
    }

    final enriched = await _enrichWithPrices(holdings);
    final totalInvested = enriched.fold<double>(
      0,
      (s, h) => s + (h['total_invested'] as double),
    );
    final currentValue = enriched.fold<double>(
      0,
      (s, h) => s + (h['current_value'] as double),
    );
    final lossPct = totalInvested > 0
        ? ((currentValue - totalInvested) / totalInvested) * 100
        : 0.0;

    var active = false;
    var reason = 'Risk guard inactive';
    var triggeredAt = triggeredAtStr;

    if (lossPct <= -threshold.abs()) {
      active = true;
      reason =
          'Global loss limit hit (${lossPct.toStringAsFixed(1)}% <= -${threshold.toStringAsFixed(1)}%)';
      if (triggeredAt == null) {
        triggeredAt = DateTime.now().toIso8601String();
        await _settings.set('portfolio_risk_guard_triggered_at', triggeredAt);
      }
    } else if (triggeredAt != null) {
      final triggered = DateTime.tryParse(triggeredAt);
      if (triggered != null &&
          DateTime.now().isBefore(
              triggered.add(Duration(hours: cooldownHours.round())))) {
        active = true;
        reason = 'Risk guard cooldown active';
      } else {
        await _settings.set('portfolio_risk_guard_triggered_at', null);
        triggeredAt = null;
      }
    }

    return {
      'active': active,
      'enabled': true,
      'loss_pct': double.parse(lossPct.toStringAsFixed(2)),
      'threshold_pct': threshold,
      'cooldown_hours': cooldownHours,
      'triggered_at': triggeredAt,
      'reason': reason,
    };
  }

  Future<List<Map<String, dynamic>>> getRebalancingPlan() async {
    final holdings = await _db.select(_db.portfolioPositions).get();
    if (holdings.isEmpty) return [];
    final enriched = await _enrichWithPrices(holdings);
    final cash = await _cash.getTotalCash();
    final stockValue =
        enriched.fold<double>(0, (s, h) => s + (h['current_value'] as double));
    final total = stockValue + cash;
    final driftThreshold =
        await _settings.getDouble('portfolio_rebalance_drift_pct', 5);
    final variant = await _settings.get('analysis_variant') ?? 'balanced';
    final targets =
        strategyPresets[variant] ?? strategyPresets['balanced']!;

    final categoryWeights = <String, double>{'growth': 0, 'blue_chip': 0};
    for (final h in enriched) {
      final cat = _sectorToCategory(h['sector'] as String);
      categoryWeights[cat] =
          (categoryWeights[cat] ?? 0) + (h['current_value'] as double) / total;
    }

    final plan = <Map<String, dynamic>>[];
    for (final entry in targets.entries) {
      final current = (categoryWeights[entry.key] ?? 0) * 100;
      final target = entry.value * 100;
      final drift = current - target;
      if (drift.abs() < driftThreshold) continue;

      if (drift > 0) {
        final toSell = enriched
            .where((h) => _sectorToCategory(h['sector'] as String) == entry.key)
            .toList()
          ..sort((a, b) =>
              (b['current_value'] as double).compareTo(a['current_value'] as double));
        if (toSell.isNotEmpty) {
          final h = toSell.first;
          final trimUsd = total * (drift / 100) * 0.5;
          final shares = (trimUsd / (h['current_price'] as double)).floor();
          if (shares > 0) {
            plan.add({
              'action': 'sell',
              'ticker': h['symbol'],
              'shares': shares,
              'category': entry.key,
              'message':
                  'Trim $shares shares of ${h['symbol']} (${entry.key} overweight)',
            });
          }
        }
      } else {
        plan.add({
          'action': 'buy',
          'category': entry.key,
          'amount_usd': double.parse((total * (-drift / 100)).toStringAsFixed(2)),
          'message':
              'Add \$${(total * (-drift / 100)).toStringAsFixed(0)} to ${entry.key} category',
        });
      }
    }
    return plan;
  }

  Future<List<Map<String, dynamic>>> getAlertsWithAck() async {
    final result = await checkAllRules();
    final alerts = (result['alerts'] as List).cast<Map<String, dynamic>>();
    final acks = await _db.select(_db.portfolioAlertAcks).get();
    final ackKeys = acks.map((a) => a.alertKey).toSet();
    return alerts
        .where((a) => !ackKeys.contains(_alertKey(a)))
        .toList();
  }

  Future<void> acknowledgeAlert(Map<String, dynamic> alert) async {
    final key = _alertKey(alert);
    await _db.into(_db.portfolioAlertAcks).insertOnConflictUpdate(
          PortfolioAlertAcksCompanion.insert(alertKey: key),
        );
  }

  String _alertKey(Map<String, dynamic> alert) =>
      '${alert['type']}_${alert['ticker'] ?? alert['sector'] ?? 'global'}';

  Future<List<Map<String, dynamic>>> _enrichWithPrices(
      List<PositionData> holdings) async {
    final enriched = <Map<String, dynamic>>[];
    for (final h in holdings) {
      var price = h.currentPrice;
      var sector = 'Unknown';
      try {
        final q = await _yahoo.getStockQuote(h.symbol);
        price = (q['currentPrice'] as num?)?.toDouble() ?? price;
        sector = q['sector']?.toString() ?? 'Unknown';
      } catch (_) {}

      final override = await (_db.select(_db.appSettings)
            ..where((t) => t.key.equals('risk_override_${h.symbol}')))
          .getSingleOrNull();
      final riskOverride = override?.value;

      final currentValue = h.shares * price;
      final invested = h.shares * h.avgCostBasis;
      final pnlPct = h.avgCostBasis > 0
          ? ((price - h.avgCostBasis) / h.avgCostBasis) * 100
          : 0.0;

      enriched.add({
        'symbol': h.symbol,
        'shares': h.shares,
        'avg_price': h.avgCostBasis,
        'current_price': price,
        'current_value': currentValue,
        'total_invested': invested,
        'sector': sector,
        'pnl_pct': double.parse(pnlPct.toStringAsFixed(2)),
        'risk_override': riskOverride,
      });
    }
    return enriched;
  }

  List<Map<String, dynamic>> _checkPositionSize(
    List<Map<String, dynamic>> holdings,
    double totalValue,
    double maxPct,
  ) {
    final alerts = <Map<String, dynamic>>[];
    for (final h in holdings) {
      if (h['risk_override'] == 'ignore_position_size') continue;
      final pct = (h['current_value'] as double) / totalValue * 100;
      if (pct > maxPct) {
        alerts.add({
          'type': 'POSITION_SIZE',
          'ticker': h['symbol'],
          'severity': pct > maxPct * 1.5 ? 'CRITICAL' : 'WARNING',
          'current_pct': double.parse(pct.toStringAsFixed(1)),
          'limit_pct': maxPct,
          'message':
              '${h['symbol']} is ${pct.toStringAsFixed(1)}% of portfolio (limit $maxPct%)',
        });
      }
    }
    return alerts;
  }

  Future<List<Map<String, dynamic>>> _checkStopLoss(
    List<Map<String, dynamic>> holdings,
    double stopLossPct,
  ) async {
    final alerts = <Map<String, dynamic>>[];
    for (final h in holdings) {
      if (h['risk_override'] == 'ignore_stop_loss') continue;
      final pnl = h['pnl_pct'] as double;
      if (pnl <= -stopLossPct) {
        alerts.add({
          'type': 'STOP_LOSS',
          'ticker': h['symbol'],
          'severity': pnl <= -stopLossPct * 1.5 ? 'CRITICAL' : 'WARNING',
          'pnl_pct': pnl,
          'limit_pct': stopLossPct,
          'message':
              '${h['symbol']} down ${pnl.abs().toStringAsFixed(1)}% (stop ${stopLossPct}%)',
        });
      }
    }
    return alerts;
  }

  List<Map<String, dynamic>> _checkSectorConcentration(
    List<Map<String, dynamic>> holdings,
    double totalValue,
    double maxSectorPct,
  ) {
    final sectorTotals = <String, double>{};
    for (final h in holdings) {
      final sector = h['sector'] as String;
      sectorTotals[sector] =
          (sectorTotals[sector] ?? 0) + (h['current_value'] as double);
    }
    final alerts = <Map<String, dynamic>>[];
    for (final entry in sectorTotals.entries) {
      final pct = entry.value / totalValue * 100;
      if (pct > maxSectorPct) {
        alerts.add({
          'type': 'SECTOR_CONCENTRATION',
          'sector': entry.key,
          'severity': 'WARNING',
          'current_pct': double.parse(pct.toStringAsFixed(1)),
          'limit_pct': maxSectorPct,
          'message':
              '${entry.key} sector is ${pct.toStringAsFixed(1)}% (limit $maxSectorPct%)',
        });
      }
    }
    return alerts;
  }

  Future<Map<String, dynamic>?> _trackBenchmark(
      List<Map<String, dynamic>> holdings) async {
    if (holdings.isEmpty) return null;
    try {
      final spy = await _yahoo.getOhlcvHistory('SPY', range: '1y');
      if (spy.length < 2) return null;
      final spyStart = (spy.first['close'] as num).toDouble();
      final spyEnd = (spy.last['close'] as num).toDouble();
      final spyReturn =
          spyStart > 0 ? ((spyEnd - spyStart) / spyStart) * 100 : 0.0;

      final invested = holdings.fold<double>(
        0,
        (s, h) => s + (h['total_invested'] as double),
      );
      final current = holdings.fold<double>(
        0,
        (s, h) => s + (h['current_value'] as double),
      );
      final portReturn =
          invested > 0 ? ((current - invested) / invested) * 100 : 0.0;

      return {
        'portfolio_return': double.parse(portReturn.toStringAsFixed(2)),
        'spy_return': double.parse(spyReturn.toStringAsFixed(2)),
        'alpha': double.parse((portReturn - spyReturn).toStringAsFixed(2)),
        'period_days': spy.length,
      };
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> _suggestRebalancing(
    List<Map<String, dynamic>> holdings,
    double totalValue,
  ) async {
    final driftThreshold =
        await _settings.getDouble('portfolio_rebalance_drift_pct', 5);
    final variant = await _settings.get('analysis_variant') ?? 'balanced';
    final targets =
        strategyPresets[variant] ?? strategyPresets['balanced']!;

    final categoryWeights = <String, double>{'growth': 0, 'blue_chip': 0};
    for (final h in holdings) {
      final cat = _sectorToCategory(h['sector'] as String);
      categoryWeights[cat] =
          (categoryWeights[cat] ?? 0) + (h['current_value'] as double) / totalValue;
    }

    final suggestions = <Map<String, dynamic>>[];
    for (final entry in targets.entries) {
      final current = (categoryWeights[entry.key] ?? 0) * 100;
      final target = entry.value * 100;
      final drift = current - target;
      if (drift.abs() < driftThreshold) continue;
      suggestions.add({
        'category': entry.key,
        'current_pct': double.parse(current.toStringAsFixed(1)),
        'target_pct': double.parse(target.toStringAsFixed(1)),
        'drift': double.parse(drift.toStringAsFixed(1)),
        'action': drift > 0 ? 'reduce' : 'increase',
        'message': drift > 0
            ? 'Reduce ${entry.key} by ${drift.abs().toStringAsFixed(1)}%'
            : 'Increase ${entry.key} by ${drift.abs().toStringAsFixed(1)}%',
      });
    }
    return suggestions;
  }

  String _sectorToCategory(String sector) {
    const growth = {
      'Technology',
      'Communication Services',
      'Consumer Cyclical',
    };
    if (growth.contains(sector)) return 'growth';
    return 'blue_chip';
  }

  Future<void> setRiskOverride(String ticker, String? override) async {
    final key = 'risk_override_${ticker.toUpperCase()}';
    if (override == null || override.isEmpty) {
      await (_db.delete(_db.appSettings)..where((t) => t.key.equals(key))).go();
    } else {
      await _settings.set(key, override);
    }
  }
}
