import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class InsiderRepository {
  Future<List<InsiderTransactionData>> getBySymbol(String symbol);
  Future<void> saveAll(List<InsiderTransactionData> transactions);
  Future<void> clearForSymbol(String symbol);
}

class InsiderRepositoryImpl implements InsiderRepository {
  InsiderRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<InsiderTransactionData>> getBySymbol(String symbol) async {
    return (db.select(db.insiderTransactions)
          ..where((t) => t.symbol.equals(symbol.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.transactionDate)]))
        .get();
  }

  @override
  Future<void> saveAll(List<InsiderTransactionData> transactions) async {
    await db.batch((batch) {
      for (final t in transactions) {
        batch.insert(db.insiderTransactions, t, mode: InsertMode.insertOrIgnore);
      }
    });
  }

  @override
  Future<void> clearForSymbol(String symbol) async {
    await (db.delete(db.insiderTransactions)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .go();
  }
}

final insiderRepositoryProvider = Provider<InsiderRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return InsiderRepositoryImpl(db);
});
