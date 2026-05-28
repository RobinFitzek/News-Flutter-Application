import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class InstitutionalRepository {
  Future<List<InstitutionalHolderData>> getBySymbol(String symbol);
  Future<List<InstitutionalHolderData>> getForSymbols(List<String> symbols);
  Future<void> saveAll(List<InstitutionalHolderData> holders);
  Future<void> clearForSymbol(String symbol);
}

class InstitutionalRepositoryImpl implements InstitutionalRepository {
  InstitutionalRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<InstitutionalHolderData>> getBySymbol(String symbol) async {
    return (db.select(db.institutionalHolders)
          ..where((t) => t.symbol.equals(symbol.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.reportDate)]))
        .get();
  }

  @override
  Future<List<InstitutionalHolderData>> getForSymbols(List<String> symbols) async {
    if (symbols.isEmpty) return [];
    final upper = symbols.map((s) => s.toUpperCase()).toList();
    return (db.select(db.institutionalHolders)
          ..where((t) => t.symbol.isIn(upper))
          ..orderBy([(t) => OrderingTerm.desc(t.value)]))
        .get();
  }

  @override
  Future<void> saveAll(List<InstitutionalHolderData> holders) async {
    await db.batch((batch) {
      for (final h in holders) {
        batch.insert(db.institutionalHolders, h, mode: InsertMode.insertOrIgnore);
      }
    });
  }

  @override
  Future<void> clearForSymbol(String symbol) async {
    await (db.delete(db.institutionalHolders)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .go();
  }
}

final institutionalRepositoryProvider =
    Provider<InstitutionalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return InstitutionalRepositoryImpl(db);
});
