import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class PaperTradingRepository {
  Future<List<PaperTradeData>> getAllTrades();
  Future<List<PaperTradeData>> getOpenTrades();
  Future<List<PaperTradeData>> getClosedTrades();
  Future<PaperTradeData> openTrade({
    required String symbol,
    required String type,
    required double shares,
    required double price,
  });
  Future<void> closeTrade(int id,
      {required double exitPrice, required String reason});
  Future<double> getCashBalance();
  Future<PaperSettingsData?> getSettings();
  Future<void> updateSettings(PaperSettingsData data);
  Future<void> resetPortfolio();
}

class PaperTradingRepositoryImpl implements PaperTradingRepository {
  PaperTradingRepositoryImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<PaperTradeData>> getAllTrades() async {
    final query = db.select(db.paperTrades)
      ..orderBy([(t) => OrderingTerm.desc(t.executedAt)]);
    return query.get();
  }

  @override
  Future<List<PaperTradeData>> getOpenTrades() async {
    return (db.select(db.paperTrades)
          ..where((t) => t.status.equals('OPEN'))
          ..orderBy([(t) => OrderingTerm.desc(t.executedAt)]))
        .get();
  }

  @override
  Future<List<PaperTradeData>> getClosedTrades() async {
    final query = db.select(db.paperTrades)
      ..where((t) => t.status.equals('CLOSED'));
    final result = await query.get();
    result.sort((a, b) => b.closedAt!.compareTo(a.closedAt!));
    return result;
  }

  @override
  Future<PaperTradeData> openTrade({
    required String symbol,
    required String type,
    required double shares,
    required double price,
  }) async {
    final cash = await getCashBalance();

    if (type == 'BUY') {
      final cost = shares * price;
      if (cost > cash) {
        throw Exception(
            'Insufficient cash. Need \$${cost.toStringAsFixed(2)}, have \$${cash.toStringAsFixed(2)}');
      }
    }

    final id = await db.into(db.paperTrades).insert(
          PaperTradesCompanion(
            symbol: Value(symbol.toUpperCase()),
            type: Value(type),
            shares: Value(shares),
            price: Value(price),
            executedAt: Value(DateTime.now()),
            status: const Value('OPEN'),
          ),
        );
    return (db.select(db.paperTrades)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  @override
  Future<void> closeTrade(int id,
      {required double exitPrice, required String reason}) async {
    final trade = await (db.select(db.paperTrades)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (trade == null) throw Exception('Trade not found');

    double realizedPnl;
    if (trade.type == 'BUY') {
      realizedPnl = (exitPrice - trade.price) * trade.shares;
    } else {
      realizedPnl = (trade.price - exitPrice) * trade.shares;
    }

    await (db.update(db.paperTrades)..where((t) => t.id.equals(id))).write(
          PaperTradesCompanion(
            status: const Value('CLOSED'),
            exitReason: Value(reason),
            exitPrice: Value(exitPrice),
            closedAt: Value(DateTime.now()),
            realizedPnl: Value(realizedPnl),
          ),
        );
  }

  @override
  Future<double> getCashBalance() async {
    final settings =
        await (db.select(db.paperSettings)).getSingleOrNull();
    if (settings == null) return 100000.0;

    final allTrades = await getAllTrades();
    double cash = settings.startingCapital;

    for (final t in allTrades) {
      if (t.type == 'BUY') {
        cash -= t.shares * t.price;
        if (t.status == 'CLOSED' && t.realizedPnl != null) {
          cash += t.shares * (t.exitPrice ?? t.price);
        }
      } else {
        cash += t.shares * t.price;
        if (t.status == 'CLOSED' && t.realizedPnl != null) {
          cash -= t.shares * (t.exitPrice ?? t.price);
        }
      }
    }

    return cash;
  }

  @override
  Future<PaperSettingsData?> getSettings() async {
    return (db.select(db.paperSettings)).getSingleOrNull();
  }

  @override
  Future<void> updateSettings(PaperSettingsData data) async {
    if (data.id > 0) {
      await (db.update(db.paperSettings)
            ..where((t) => t.id.equals(data.id)))
          .write(PaperSettingsCompanion(
            startingCapital: Value(data.startingCapital),
            takeProfitPercent: Value(data.takeProfitPercent),
            stopLossPercent: Value(data.stopLossPercent),
            maxOpenTrades: Value(data.maxOpenTrades),
            positionSizePercent: Value(data.positionSizePercent),
          ));
    } else {
      await db.into(db.paperSettings).insert(
            PaperSettingsCompanion(
              startingCapital: Value(data.startingCapital),
              takeProfitPercent: Value(data.takeProfitPercent),
              stopLossPercent: Value(data.stopLossPercent),
              maxOpenTrades: Value(data.maxOpenTrades),
              positionSizePercent: Value(data.positionSizePercent),
            ),
          );
    }
  }

  @override
  Future<void> resetPortfolio() async {
    await db.delete(db.paperTrades).go();
    final settings =
        await (db.select(db.paperSettings)).getSingleOrNull();
    if (settings != null && settings.id > 0) {
      await (db.update(db.paperSettings)
            ..where((t) => t.id.equals(settings.id)))
          .write(const PaperSettingsCompanion());
    }
  }
}

final paperTradingRepositoryProvider =
    Provider<PaperTradingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return PaperTradingRepositoryImpl(db);
});
