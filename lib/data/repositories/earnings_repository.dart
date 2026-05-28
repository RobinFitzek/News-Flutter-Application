import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class EarningsRepository {
  Future<List<EarningsEventData>> getBySymbol(String symbol);
  Future<void> saveAll(List<EarningsEventData> events);
  Future<void> clearForSymbol(String symbol);
}

class EarningsRepositoryImpl implements EarningsRepository {
  EarningsRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<EarningsEventData>> getBySymbol(String symbol) async {
    return (db.select(db.earningsEvents)
          ..where((t) => t.symbol.equals(symbol.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.reportDate)]))
        .get();
  }

  @override
  Future<void> saveAll(List<EarningsEventData> events) async {
    await db.batch((batch) {
      for (final e in events) {
        batch.insert(db.earningsEvents, e, mode: InsertMode.insertOrIgnore);
      }
    });
  }

  @override
  Future<void> clearForSymbol(String symbol) async {
    await (db.delete(db.earningsEvents)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .go();
  }
}

final earningsRepositoryProvider = Provider<EarningsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return EarningsRepositoryImpl(db);
});
