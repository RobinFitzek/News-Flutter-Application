import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../database/app_database.dart';

class StockCacheRepository {
  StockCacheRepository(this.db);

  final AppDatabase db;

  Future<StockCacheData?> getCached(String symbol) async {
    return (db.select(db.stockCache)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .getSingleOrNull();
  }

  Future<void> cache(StockCacheData data) async {
    await db.into(db.stockCache).insertOnConflictUpdate(data.toCompanion(true));
  }

  Future<bool> isStale(String symbol, Duration maxAge) async {
    final cached = await getCached(symbol);
    if (cached == null) return true;
    final age = DateTime.now().difference(cached.cachedAt);
    return age > maxAge;
  }

  Future<StockCacheData> cacheFromQuote(
    Map<String, dynamic> quote,
  ) async {
    final companion = StockCacheCompanion(
      symbol: Value(quote['symbol'] as String),
      companyName: Value(quote['companyName'] as String? ?? ''),
      currentPrice: Value((quote['currentPrice'] as num).toDouble()),
      previousClose: Value((quote['previousClose'] as num).toDouble()),
      change: Value((quote['change'] as num).toDouble()),
      changePercent: Value((quote['changePercent'] as num).toDouble()),
      dayHigh: Value((quote['dayHigh'] as num).toDouble()),
      dayLow: Value((quote['dayLow'] as num).toDouble()),
      volume: Value(quote['volume'] as int),
      marketCap: Value(quote['marketCap'] as double?),
      timestamp: Value(DateTime.parse(quote['timestamp'] as String)),
      cachedAt: Value(DateTime.now()),
    );
    final id = await db.into(db.stockCache).insertOnConflictUpdate(companion);
    return (db.select(db.stockCache)..where((t) => t.id.equals(id)))
        .getSingle();
  }
}

final stockCacheRepositoryProvider =
    Provider<StockCacheRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return StockCacheRepository(db);
});
