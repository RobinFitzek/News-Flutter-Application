import 'dart:math';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';
import '../../engine/ai_crosscheck.dart';
import '../data/repositories/paper_trading_repository.dart';

/// Automatic paper trading from analysis signals — mirrors auto_paper_trader.py.
class AutoPaperTrader {
  AutoPaperTrader(
    this._db, {
    YahooFinanceClient? yahoo,
    PaperTradingRepository? paperRepo,
  })  : _yahoo = yahoo ?? YahooFinanceClient(),
        _paperRepo = paperRepo;

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;
  final PaperTradingRepository? _paperRepo;

  Future<Map<String, dynamic>> _config() async {
    return {
      'enabled': await _settingBool('auto_trade_enabled', false),
      'signal_filter': await _setting('auto_trade_signal_filter', 'STRONG'),
      'take_profit_pct':
          (await _settingDouble('auto_trade_take_profit_pct', 8.0)) / 100,
      'stop_loss_pct':
          (await _settingDouble('auto_trade_stop_loss_pct', 4.0)) / 100,
      'max_days': await _settingInt('auto_trade_max_days_open', 30),
      'position_size_pct':
          (await _settingDouble('auto_trade_position_size_pct', 5.0)) / 100,
      'max_positions': await _settingInt('auto_trade_max_open_positions', 10),
      'require_confirm': await _settingBool('auto_trade_require_confirm', false),
      'min_trust_trades': await _settingInt('auto_trade_min_trust_trades', 20),
      'min_trust_win_rate':
          await _settingDouble('auto_trade_min_trust_win_rate', 55.0),
    };
  }

  Future<int> processNewSignals() async {
    final cfg = await _config();
    if (cfg['enabled'] != true) return 0;

    final cutoff = DateTime.now().subtract(const Duration(hours: 24));
    final analyses = await (_db.select(_db.analysisResults)
          ..where((t) => t.createdAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();

    final existingIds = await _existingAnalysisIds();
    var openCount = await _openCount();
    var processed = 0;

    for (final a in analyses) {
      if (openCount >= (cfg['max_positions'] as int)) break;
      if (existingIds.contains(a.id)) continue;

      final direction = _mapDirection(a);
      if (direction == null) continue;
      if (!_passesFilter(a, cfg['signal_filter'] as String)) continue;

      try {
        final quote = await _yahoo.getStockQuote(a.symbol);
        final entryPrice = (quote['currentPrice'] as num).toDouble();
        if (entryPrice <= 0) continue;

        final portfolioValue = await _portfolioValue();
        final sizeUsd = portfolioValue * (cfg['position_size_pct'] as double);
        final shares = sizeUsd / entryPrice;

        if (await _hasOpenPosition(a.symbol)) {
          await _insertBlocked(a, direction, entryPrice, 'Already open');
          continue;
        }

        final analysisText =
            '${a.reasoning} ${a.fundamental} ${a.technical} ${a.newsSummary}';
        if (analysisText.trim().length > 50) {
          final crosscheck =
              await AiCrosscheck(yahoo: _yahoo).checkAnalysis(
            a.symbol,
            analysisText,
          );
          final trust = crosscheck['trust_score'] as double? ?? 1.0;
          if (trust < AiCrosscheck.minTrustScore) {
            await _insertBlocked(
              a,
              direction,
              entryPrice,
              'AI trust score ${(trust * 100).toStringAsFixed(0)}% too low',
            );
            continue;
          }
        }

        if (cfg['require_confirm'] == true) {
          await _createPending(a, direction, entryPrice, shares, sizeUsd, cfg);
          processed++;
          continue;
        }

        await _enterTrade(a, direction, entryPrice, shares);
        openCount++;
        processed++;
      } catch (_) {
        continue;
      }
    }
    return processed;
  }

  Future<int> checkOpenPositions() async {
    final cfg = await _config();
    final open = await (_db.select(_db.autoPaperTrades)
          ..where((t) => t.status.equals('open')))
        .get();

    var closed = 0;
    for (final trade in open) {
      try {
        final quote = await _yahoo.getStockQuote(trade.ticker);
        final price = (quote['currentPrice'] as num).toDouble();
        final entry = trade.entryPrice ?? price;
        final pnlPct = trade.direction == 'LONG'
            ? (price - entry) / entry
            : (entry - price) / entry;

        String? reason;
        if (pnlPct >= (cfg['take_profit_pct'] as double)) {
          reason = 'take_profit';
        } else if (pnlPct <= -(cfg['stop_loss_pct'] as double)) {
          reason = 'stop_loss';
        } else if (trade.entryDate != null &&
            DateTime.now().difference(trade.entryDate!).inDays >=
                (cfg['max_days'] as int)) {
          reason = 'time_limit';
        }

        if (reason != null) {
          await _closeTrade(trade, price, reason, pnlPct);
          closed++;
        }
      } catch (_) {}
    }
    return closed;
  }

  Future<Map<String, dynamic>> getStatus() async {
    final cfg = await _config();
    final closed = await (_db.select(_db.autoPaperTrades)
          ..where((t) => t.status.equals('closed')))
        .get();
    final open = await (_db.select(_db.autoPaperTrades)
          ..where((t) => t.status.equals('open')))
        .get();
    final pending = await (_db.select(_db.autoTradePending)
          ..where((t) => t.status.equals('pending')))
        .get();

    final wins = closed.where((t) => (t.pnlPct ?? 0) > 0).length;
    final winRate = closed.isEmpty ? 0.0 : wins / closed.length * 100;
    final totalPnl = closed.fold<double>(0, (s, t) => s + (t.pnlPct ?? 0));

    return {
      'enabled': cfg['enabled'],
      'mode': 'paper',
      'require_confirm': cfg['require_confirm'],
      'open_positions': open.length,
      'total_trades': closed.length + open.length,
      'win_rate': double.parse(winRate.toStringAsFixed(1)),
      'total_pnl_pct': double.parse((totalPnl * 100).toStringAsFixed(2)),
      'pending_count': pending.length,
      'trust_gate': await _trustGate(cfg),
      'last_trade_date': closed.isNotEmpty
          ? closed.map((t) => t.exitDate).whereType<DateTime>().reduce(
              (a, b) => a.isAfter(b) ? a : b,
            ).toIso8601String()
          : null,
    };
  }

  Future<bool> confirmPending(String token) async {
    final pending = await (_db.select(_db.autoTradePending)
          ..where((t) =>
              t.token.equals(token) & t.status.equals('pending')))
        .getSingleOrNull();
    if (pending == null) return false;
    if (DateTime.now().isAfter(pending.expiresAt)) {
      await (_db.update(_db.autoTradePending)
            ..where((t) => t.id.equals(pending.id)))
          .write(const AutoTradePendingCompanion(status: Value('expired')));
      return false;
    }

    final analysis = await (_db.select(_db.analysisResults)
          ..where((t) => t.id.equals(pending.analysisId)))
        .getSingleOrNull();

    if (analysis != null) {
      await _enterTrade(
        analysis,
        pending.direction,
        pending.proposedEntryPrice,
        pending.proposedShares,
      );
    }

    await (_db.update(_db.autoTradePending)
          ..where((t) => t.id.equals(pending.id)))
        .write(AutoTradePendingCompanion(
      status: const Value('confirmed'),
      decidedAt: Value(DateTime.now()),
    ));
    return true;
  }

  Future<void> skipPending(String token) async {
    await (_db.update(_db.autoTradePending)
          ..where((t) => t.token.equals(token)))
        .write(AutoTradePendingCompanion(
      status: const Value('skipped'),
      decidedAt: Value(DateTime.now()),
    ));
  }

  Future<List<AutoTradePendingData>> getPendingConfirmations() async {
    await _expirePending();
    return (_db.select(_db.autoTradePending)
          ..where((t) => t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<void> setEnabled(bool enabled) async {
    await _setSetting('auto_trade_enabled', enabled.toString());
    if (enabled) {
      await _setSetting('auto_trade_require_confirm', 'true');
    }
  }

  String? _mapDirection(AnalysisResultData a) {
    final rec = a.recommendation.toUpperCase();
    final sig = a.signal;
    if (rec.contains('STRONG_BUY') ||
        rec == 'BUY' ||
        sig == 'Opportunity' ||
        sig.contains('Buy')) {
      return 'LONG';
    }
    if (rec.contains('STRONG_SELL') ||
        rec == 'SELL' ||
        sig == 'Caution' ||
        sig.contains('Sell')) {
      return 'SHORT';
    }
    return null;
  }

  bool _passesFilter(AnalysisResultData a, String filter) {
    if (filter != 'STRONG') return true;
    final score = a.quantScore ?? (a.confidence * 100).round();
    if (a.signal == 'Opportunity' || a.recommendation.contains('BUY')) {
      return score >= 70;
    }
    if (a.signal == 'Caution' || a.recommendation.contains('SELL')) {
      return score <= 30 || score >= 70;
    }
    return false;
  }

  Future<void> _enterTrade(
    AnalysisResultData a,
    String direction,
    double entryPrice,
    double shares,
  ) async {
    await _db.into(_db.autoPaperTrades).insert(
          AutoPaperTradesCompanion.insert(
            analysisId: Value(a.id),
            ticker: a.symbol,
            direction: direction,
            entryDate: Value(DateTime.now()),
            entryPrice: Value(entryPrice),
            status: const Value('open'),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    if (_paperRepo != null && direction == 'LONG') {
      try {
        await _paperRepo.openTrade(
          symbol: a.symbol,
          type: 'BUY',
          shares: shares,
          price: entryPrice,
        );
      } catch (_) {}
    }
  }

  Future<void> _closeTrade(
    AutoPaperTradeData trade,
    double exitPrice,
    String reason,
    double pnlPct,
  ) async {
    await (_db.update(_db.autoPaperTrades)
          ..where((t) => t.id.equals(trade.id)))
        .write(AutoPaperTradesCompanion(
      exitDate: Value(DateTime.now()),
      exitPrice: Value(exitPrice),
      status: const Value('closed'),
      closeReason: Value(reason),
      pnlPct: Value(pnlPct),
    ));

    if (_paperRepo != null && trade.direction == 'LONG') {
      try {
        final paperTrades = await _paperRepo.getOpenTrades();
        final match = paperTrades
            .where((t) => t.symbol == trade.ticker && t.type == 'BUY')
            .firstOrNull;
        if (match != null) {
          await _paperRepo.closeTrade(match.id,
              exitPrice: exitPrice, reason: reason);
        }
      } catch (_) {}
    }
  }

  Future<void> _createPending(
    AnalysisResultData a,
    String direction,
    double entryPrice,
    double shares,
    double sizeUsd,
    Map<String, dynamic> cfg,
  ) async {
    final token = _randomToken();
    final now = DateTime.now();
    final tpPct = cfg['take_profit_pct'] as double;
    final slPct = cfg['stop_loss_pct'] as double;
    final tp = direction == 'LONG'
        ? entryPrice * (1 + tpPct)
        : entryPrice * (1 - tpPct);
    final sl = direction == 'LONG'
        ? entryPrice * (1 - slPct)
        : entryPrice * (1 + slPct);

    await _db.into(_db.autoTradePending).insert(
          AutoTradePendingCompanion.insert(
            token: token,
            analysisId: a.id,
            ticker: a.symbol,
            direction: direction,
            signal: a.signal,
            score: Value(a.quantScore),
            proposedEntryPrice: entryPrice,
            proposedShares: shares,
            proposedSizeUsd: sizeUsd,
            riskTpPrice: tp,
            riskSlPrice: sl,
            createdAt: now,
            expiresAt: now.add(const Duration(minutes: 5)),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> _insertBlocked(
    AnalysisResultData a,
    String direction,
    double entryPrice,
    String reason,
  ) async {
    await _db.into(_db.autoPaperTrades).insert(
          AutoPaperTradesCompanion.insert(
            analysisId: Value(a.id),
            ticker: a.symbol,
            direction: direction,
            entryDate: Value(DateTime.now()),
            entryPrice: Value(entryPrice),
            status: const Value('blocked'),
            blockedReason: Value(reason),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<Set<int>> _existingAnalysisIds() async {
    final trades = await _db.select(_db.autoPaperTrades).get();
    final pending = await _db.select(_db.autoTradePending).get();
    return {
      ...trades.map((t) => t.analysisId).whereType<int>(),
      ...pending.map((p) => p.analysisId),
    };
  }

  Future<int> _openCount() async {
    final rows = await (_db.select(_db.autoPaperTrades)
          ..where((t) => t.status.equals('open')))
        .get();
    return rows.length;
  }

  Future<bool> _hasOpenPosition(String ticker) async {
    final row = await (_db.select(_db.autoPaperTrades)
          ..where((t) =>
              t.ticker.equals(ticker.toUpperCase()) &
              t.status.equals('open')))
        .getSingleOrNull();
    return row != null;
  }

  Future<double> _portfolioValue() async {
    if (_paperRepo != null) {
      final cash = await _paperRepo.getCashBalance();
      final open = await _paperRepo.getOpenTrades();
      var holdings = 0.0;
      for (final t in open) {
        holdings += t.shares * t.price;
      }
      return cash + holdings;
    }
    final settings = await (_db.select(_db.paperSettings)).getSingleOrNull();
    return settings?.startingCapital ?? 100000;
  }

  Future<Map<String, dynamic>> _trustGate(Map<String, dynamic> cfg) async {
    final closed = await (_db.select(_db.autoPaperTrades)
          ..where((t) => t.status.equals('closed')))
        .get();
    final wins =
        closed.where((t) => (t.pnlPct ?? 0) > 0).length;
    final winRate =
        closed.isEmpty ? 0.0 : wins / closed.length * 100;
    final minTrades = cfg['min_trust_trades'] as int;
    final minWin = cfg['min_trust_win_rate'] as double;
    return {
      'trusted': closed.length >= minTrades && winRate >= minWin,
      'closed': closed.length,
      'win_rate_pct': double.parse(winRate.toStringAsFixed(1)),
      'needed_trades': minTrades,
      'needed_win_rate': minWin,
    };
  }

  Future<void> _expirePending() async {
    await (_db.update(_db.autoTradePending)
          ..where((t) =>
              t.status.equals('pending') &
              t.expiresAt.isSmallerThanValue(DateTime.now())))
        .write(const AutoTradePendingCompanion(status: Value('expired')));
  }

  Future<String> _setting(String key, String defaultValue) async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value ?? defaultValue;
  }

  Future<bool> _settingBool(String key, bool defaultValue) async {
    final v = await _setting(key, defaultValue.toString());
    return v == 'true' || v == '1';
  }

  Future<int> _settingInt(String key, int defaultValue) async {
    return int.tryParse(await _setting(key, defaultValue.toString())) ??
        defaultValue;
  }

  Future<double> _settingDouble(String key, double defaultValue) async {
    return double.tryParse(await _setting(key, defaultValue.toString())) ??
        defaultValue;
  }

  Future<void> _setSetting(String key, String value) async {
    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.appSettings)..where((t) => t.key.equals(key)))
          .write(AppSettingsCompanion(value: Value(value)));
    } else {
      await _db.into(_db.appSettings).insert(
            AppSettingsCompanion.insert(key: key, value: value),
          );
    }
  }

  String _randomToken() {
    final r = Random.secure();
    return List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0'))
        .join();
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
