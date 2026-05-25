import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class WatchlistRepository {
  Future<List<WatchlistItemData>> getAll();
  Future<WatchlistItemData?> getBySymbol(String symbol);
  Future<WatchlistItemData> add(String symbol,
      {String tier = 'core', String? groupName});
  Future<void> remove(int id);
  Future<void> updateTier(int id, String tier);
  Future<void> updateNote(int id, String? note);
  Future<void> updateGroup(int id, String? groupName);
  Future<void> updatePrice(int id, double price, double change);
  Future<void> archive(String symbol);
}

class WatchlistRepositoryImpl implements WatchlistRepository {
  WatchlistRepositoryImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<WatchlistItemData>> getAll() async {
    return db.select(db.watchlistItems).get();
  }

  @override
  Future<WatchlistItemData?> getBySymbol(String symbol) async {
    return (db.select(db.watchlistItems)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .getSingleOrNull();
  }

  @override
  Future<WatchlistItemData> add(String symbol,
      {String tier = 'core', String? groupName}) async {
    final id = await db.into(db.watchlistItems).insert(
          WatchlistItemsCompanion(
            symbol: Value(symbol.toUpperCase()),
            tier: Value(tier),
            groupName: Value(groupName),
          ),
        );
    return (db.select(db.watchlistItems)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  @override
  Future<void> remove(int id) async {
    await (db.delete(db.watchlistItems)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> updateTier(int id, String tier) async {
    await (db.update(db.watchlistItems)..where((t) => t.id.equals(id)))
        .write(WatchlistItemsCompanion(tier: Value(tier)));
  }

  @override
  Future<void> updateNote(int id, String? note) async {
    await (db.update(db.watchlistItems)..where((t) => t.id.equals(id)))
        .write(WatchlistItemsCompanion(note: Value(note)));
  }

  @override
  Future<void> updateGroup(int id, String? groupName) async {
    await (db.update(db.watchlistItems)..where((t) => t.id.equals(id)))
        .write(WatchlistItemsCompanion(groupName: Value(groupName)));
  }

  @override
  Future<void> updatePrice(int id, double price, double change) async {
    await (db.update(db.watchlistItems)..where((t) => t.id.equals(id))).write(
          WatchlistItemsCompanion(
            lastPrice: Value(price),
            lastPriceChange: Value(change),
          ),
        );
  }

  @override
  Future<void> archive(String symbol) async {
    await (db.delete(db.watchlistItems)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .go();
  }
}

final watchlistRepositoryProvider = Provider<WatchlistRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return WatchlistRepositoryImpl(db);
});
