import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';
import '../../engine/backtest_engine.dart';
import '../../engine/quant_backtest_engine.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

abstract class BacktestRepository {
  Future<List<BacktestResultData>> getAll();
  Future<void> save(BacktestResultData data);
  Future<void> delete(int id);
  Future<BacktestResultData> runBacktest({
    required List<String> symbols,
    required String strategy,
    required double initialCapital,
    required int days,
  });
}

class BacktestRepositoryImpl implements BacktestRepository {
  BacktestRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<BacktestResultData>> getAll() async {
    return (db.select(db.backtestResults)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  @override
  Future<void> save(BacktestResultData data) async {
    await db.into(db.backtestResults).insert(data.toCompanion(true));
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.backtestResults)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<BacktestResultData> runBacktest({
    required List<String> symbols,
    required String strategy,
    required double initialCapital,
    required int days,
  }) async {
    final Map<String, dynamic> result;

    if (strategy == 'quant_walkforward') {
      final engine = QuantBacktestEngine(yahoo: YahooFinanceClient());
      result = await engine.runWalkForward(
        symbols: symbols,
        lookbackMonths: (days / 30).round().clamp(6, 24),
      );
      if (result.containsKey('error')) {
        throw Exception(result['error'] as String);
      }
    } else {
      final engine = BacktestEngine(yahooClient: YahooFinanceClient());
      result = await engine.run(
        symbols: symbols,
        strategy: strategy,
        initialCapital: initialCapital,
        startDaysAgo: days,
      );
    }

    final data = BacktestResultData(
      id: 0,
      strategy: result['strategy'] as String,
      startDate: DateTime.parse(result['startDate'] as String),
      endDate: DateTime.parse(result['endDate'] as String),
      initialCapital: result['initialCapital'] as double,
      finalCapital: result['finalCapital'] as double,
      totalReturn: result['totalReturn'] as double,
      totalReturnPercent: result['totalReturnPercent'] as double,
      maxDrawdown: result['maxDrawdown'] as double,
      maxDrawdownPercent: result['maxDrawdownPercent'] as double,
      totalTrades: result['totalTrades'] as int,
      winningTrades: result['winningTrades'] as int,
      losingTrades: result['losingTrades'] as int,
      winRate: result['winRate'] as double,
      avgWin: result['avgWin'] as double,
      avgLoss: result['avgLoss'] as double,
      profitFactor: result['profitFactor'] as double,
      symbols: result['symbols'] as String,
      createdAt: DateTime.now(),
    );
    await save(data);
    return data;
  }
}

final backtestRepositoryProvider = Provider<BacktestRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return BacktestRepositoryImpl(db);
});
