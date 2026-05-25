import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class AnalysisRepository {
  Future<List<AnalysisResultData>> getAll();
  Future<List<AnalysisResultData>> getBySymbol(String symbol);
  Future<AnalysisResultData?> getById(int id);
  Future<AnalysisResultData> save(AnalysisResultData analysis);
  Future<void> delete(int id);
}

class AnalysisRepositoryImpl implements AnalysisRepository {
  AnalysisRepositoryImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<AnalysisResultData>> getAll() async {
    final query = db.select(db.analysisResults)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.get();
  }

  @override
  Future<List<AnalysisResultData>> getBySymbol(String symbol) async {
    return (db.select(db.analysisResults)
          ..where((t) => t.symbol.equals(symbol.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  @override
  Future<AnalysisResultData?> getById(int id) async {
    return (db.select(db.analysisResults)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<AnalysisResultData> save(AnalysisResultData analysis) async {
    if (analysis.id > 0) {
      await (db.update(db.analysisResults)
            ..where((t) => t.id.equals(analysis.id)))
          .write(AnalysisResultsCompanion(
            symbol: Value(analysis.symbol),
            predictedPrice: Value(analysis.predictedPrice),
            confidence: Value(analysis.confidence),
            recommendation: Value(analysis.recommendation),
            reasoning: Value(analysis.reasoning),
            newsSummary: Value(analysis.newsSummary),
            timeframe: Value(analysis.timeframe),
            currentPrice: Value(analysis.currentPrice),
          ));
      return (await getById(analysis.id))!;
    }

    final id = await db.into(db.analysisResults).insert(
          AnalysisResultsCompanion(
            symbol: Value(analysis.symbol),
            predictedPrice: Value(analysis.predictedPrice),
            confidence: Value(analysis.confidence),
            recommendation: Value(analysis.recommendation),
            reasoning: Value(analysis.reasoning),
            newsSummary: Value(analysis.newsSummary),
            timeframe: Value(analysis.timeframe),
            currentPrice: Value(analysis.currentPrice),
          ),
        );
    return (await getById(id))!;
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.analysisResults)..where((t) => t.id.equals(id))).go();
  }
}

final analysisRepositoryProvider = Provider<AnalysisRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AnalysisRepositoryImpl(db);
});
