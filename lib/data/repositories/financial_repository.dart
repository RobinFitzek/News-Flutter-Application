import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class FinancialRepository {
  Future<FinancialRatioData?> getBySymbol(String symbol);
  Future<void> save(FinancialRatioData data);
}

class FinancialRepositoryImpl implements FinancialRepository {
  FinancialRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<FinancialRatioData?> getBySymbol(String symbol) async {
    return (db.select(db.financialRatios)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .getSingleOrNull();
  }

  @override
  Future<void> save(FinancialRatioData data) async {
    await db.into(db.financialRatios).insertOnConflictUpdate(data.toCompanion(true));
  }
}

final financialRepositoryProvider = Provider<FinancialRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return FinancialRepositoryImpl(db);
});
