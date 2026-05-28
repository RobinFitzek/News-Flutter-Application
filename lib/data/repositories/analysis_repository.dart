import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../engine/learning_optimizer.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class AnalysisRepository {
  Future<List<AnalysisResultData>> getAll();
  Future<List<AnalysisResultData>> getBySymbol(String symbol);
  Future<AnalysisResultData?> getById(int id);
  Future<AnalysisResultData> save(AnalysisResultData analysis);
  Future<AnalysisResultData> saveFromPipeline(Map<String, dynamic> result, {String timeframe = 'daily'});
  Future<void> delete(int id);
}

class AnalysisRepositoryImpl implements AnalysisRepository {
  AnalysisRepositoryImpl(this.db);

  final AppDatabase db;

  LearningOptimizer get _learning => LearningOptimizer(db);

  AnalysisResultsCompanion _companion(AnalysisResultData analysis) {
    return AnalysisResultsCompanion(
      symbol: Value(analysis.symbol),
      predictedPrice: Value(analysis.predictedPrice),
      confidence: Value(analysis.confidence),
      recommendation: Value(analysis.recommendation),
      reasoning: Value(analysis.reasoning),
      newsSummary: Value(analysis.newsSummary),
      timeframe: Value(analysis.timeframe),
      currentPrice: Value(analysis.currentPrice),
      signal: Value(analysis.signal),
      riskScore: Value(analysis.riskScore),
      geoRiskScore: Value(analysis.geoRiskScore),
      quantScore: Value(analysis.quantScore),
      bullCase: Value(analysis.bullCase),
      bearCase: Value(analysis.bearCase),
      sources: Value(analysis.sources),
      fundamental: Value(analysis.fundamental),
      technical: Value(analysis.technical),
      geopoliticalContext: Value(analysis.geopoliticalContext),
      stage1Reason: Value(analysis.stage1Reason),
      quantMetricsJson: Value(analysis.quantMetricsJson),
    );
  }

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
    return (db.select(db.analysisResults)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<AnalysisResultData> save(AnalysisResultData analysis) async {
    if (analysis.id > 0) {
      await (db.update(db.analysisResults)..where((t) => t.id.equals(analysis.id)))
          .write(_companion(analysis));
      return (await getById(analysis.id))!;
    }

    final id = await db.into(db.analysisResults).insert(_companion(analysis));
    return (await getById(id))!;
  }

  @override
  Future<AnalysisResultData> saveFromPipeline(
    Map<String, dynamic> result, {
    String timeframe = 'daily',
  }) async {
    final ticker = result['ticker']?.toString().toUpperCase() ?? '';
    final data = result['data'] as Map<String, dynamic>? ?? {};
    final currentPrice =
        (data['current_price'] as num?)?.toDouble() ??
        (result['current_price'] as num?)?.toDouble() ??
        0.0;

    final quantScore = result['composite_score'] as int? ??
        result['score'] as int? ??
        (result['quant_metrics'] as Map?)?['composite_score'] as int?;

    final summary = result['summary']?.toString() ??
        result['recommendation']?.toString() ??
        '';

    final analysis = AnalysisResultData(
      id: 0,
      symbol: ticker,
      predictedPrice: currentPrice,
      confidence: _signalToConfidence(result['signal']?.toString() ?? 'Neutral'),
      recommendation: result['signal']?.toString() ?? 'Neutral',
      reasoning: summary,
      newsSummary: result['news']?.toString() ?? '',
      timeframe: timeframe,
      currentPrice: currentPrice,
      signal: result['signal']?.toString() ?? 'Neutral',
      riskScore: result['risk_score'] as int? ?? 5,
      geoRiskScore: result['geo_risk_score'] as int?,
      quantScore: quantScore,
      bullCase: result['bull_case']?.toString() ?? '',
      bearCase: result['bear_case']?.toString() ?? '',
      sources: result['sources']?.toString() ?? '',
      fundamental: result['fundamental']?.toString() ?? '',
      technical: result['technical']?.toString() ?? '',
      geopoliticalContext: result['geopolitical_context']?.toString(),
      stage1Reason: result['stage1_reason']?.toString() ?? result['initial_reason']?.toString() ?? '',
      quantMetricsJson: jsonEncode(result['quant_metrics'] ?? {}),
      createdAt: DateTime.now(),
    );

    final saved = await save(analysis);

    await _markWatchlistScanned(ticker);

    await _learning.recordPrediction(
      symbol: ticker,
      signal: analysis.signal,
      confidence: (analysis.confidence * 100).round().clamp(0, 100),
      currentPrice: currentPrice,
      momentumScore: _extractScore(result, 'momentum'),
      valuationScore: _extractScore(result, 'valuation'),
      analysisId: saved.id,
    );

    return saved;
  }

  Future<void> _markWatchlistScanned(String symbol) async {
    await (db.update(db.watchlistItems)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .write(WatchlistItemsCompanion(lastScannedAt: Value(DateTime.now())));
  }

  int? _extractScore(Map<String, dynamic> result, String key) {
    final qm = result['quant_metrics'] as Map<String, dynamic>?;
    final scores = qm?['scores'] as Map<String, dynamic>? ??
        result['scores'] as Map<String, dynamic>?;
    return (scores?[key] as num?)?.toInt();
  }

  double _signalToConfidence(String signal) {
    switch (signal) {
      case 'Opportunity':
        return 0.75;
      case 'Caution':
        return 0.35;
      default:
        return 0.5;
    }
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
