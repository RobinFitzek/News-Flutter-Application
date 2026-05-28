import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class CorporateActionRepository {
  Future<List<CorporateActionData>> getBySymbol(String symbol);
  Future<void> saveAll(List<CorporateActionData> actions);
  Future<void> clearForSymbol(String symbol);
}

class CorporateActionRepositoryImpl implements CorporateActionRepository {
  CorporateActionRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<CorporateActionData>> getBySymbol(String symbol) async {
    return (db.select(db.corporateActions)
          ..where((t) => t.symbol.equals(symbol.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  @override
  Future<void> saveAll(List<CorporateActionData> actions) async {
    await db.batch((batch) {
      for (final a in actions) {
        batch.insert(db.corporateActions, a, mode: InsertMode.insertOrIgnore);
      }
    });
  }

  @override
  Future<void> clearForSymbol(String symbol) async {
    await (db.delete(db.corporateActions)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .go();
  }
}

final corporateActionRepositoryProvider =
    Provider<CorporateActionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CorporateActionRepositoryImpl(db);
});
