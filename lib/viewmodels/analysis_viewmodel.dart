import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/analysis_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../engine/analysis_pipeline.dart';
import '../../engine/position_sizing.dart';
import '../../models/stage_assignment.dart';

class AnalysisState {
  const AnalysisState({
    this.currentAnalysis,
    this.history = const [],
    this.isLoading = false,
    this.isAnalyzing = false,
    this.errorMessage,
    this.lastPipelineStage,
    this.positionSizing,
  });

  final AnalysisResultData? currentAnalysis;
  final List<AnalysisResultData> history;
  final bool isLoading;
  final bool isAnalyzing;
  final String? errorMessage;
  final String? lastPipelineStage;
  final Map<String, dynamic>? positionSizing;

  AnalysisState copyWith({
    AnalysisResultData? currentAnalysis,
    List<AnalysisResultData>? history,
    bool? isLoading,
    bool? isAnalyzing,
    String? errorMessage,
    String? lastPipelineStage,
    Map<String, dynamic>? positionSizing,
    bool clearError = false,
    bool clearCurrent = false,
    bool clearPositionSizing = false,
  }) {
    return AnalysisState(
      currentAnalysis:
          clearCurrent ? null : (currentAnalysis ?? this.currentAnalysis),
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      errorMessage:
          clearError ? null : (errorMessage ?? this.errorMessage),
      lastPipelineStage: lastPipelineStage ?? this.lastPipelineStage,
      positionSizing: clearPositionSizing
          ? null
          : (positionSizing ?? this.positionSizing),
    );
  }
}

class AnalysisViewModel extends StateNotifier<AnalysisState> {
  AnalysisViewModel({
    required this.analysisRepo,
    required this.providerRepo,
    required this.db,
  }) : super(const AnalysisState()) {
    _pipeline = AnalysisPipeline(db: db, providerRepo: providerRepo);
  }

  final AnalysisRepository analysisRepo;
  final ProviderRepository providerRepo;
  final AppDatabase db;
  late final AnalysisPipeline _pipeline;

  Future<void> analyzeStock(String symbol, {String timeframe = 'daily'}) async {
    state = state.copyWith(
      isAnalyzing: true,
      clearError: true,
      clearCurrent: true,
      lastPipelineStage: 'Stage 1: Quant Screen',
    );

    try {
      final newsProvider = await providerRepo.getByStage(AnalysisStage.newsResearch);
      if (newsProvider == null || newsProvider.apiKey.isEmpty) {
        state = state.copyWith(
          isAnalyzing: false,
          errorMessage:
              'No provider assigned for newsResearch (Stage 2). Set one in Settings.',
        );
        return;
      }

      final synthesisProvider =
          await providerRepo.getByStage(AnalysisStage.finalAnalysis);
      if (synthesisProvider == null || synthesisProvider.apiKey.isEmpty) {
        state = state.copyWith(
          isAnalyzing: false,
          errorMessage:
              'No provider assigned for finalAnalysis (Stage 3). Set one in Settings.',
        );
        return;
      }

      state = state.copyWith(lastPipelineStage: 'Stage 2: News & Intelligence');
      final result = await _pipeline.analyzeSingle(symbol, strategy: 'balanced');
      state = state.copyWith(lastPipelineStage: 'Stage 3: Research Synthesis');

      final saved = await analysisRepo.saveFromPipeline(result, timeframe: timeframe);
      await loadHistory();

      Map<String, dynamic>? sizing;
      try {
        final positions = await db.select(db.portfolioPositions).get();
        final portfolioValue = positions.fold<double>(
          0,
          (s, p) => s + p.shares * p.currentPrice,
        );
        if (portfolioValue > 0) {
          sizing = await PositionSizer().recommend(
            ticker: saved.symbol,
            portfolioValue: portfolioValue,
            confidence: saved.confidence,
            signal: saved.signal,
            existingTickers: positions.map((p) => p.symbol).toList(),
          );
        }
      } catch (_) {}

      state = state.copyWith(
        currentAnalysis: saved,
        isAnalyzing: false,
        lastPipelineStage: 'Complete',
        positionSizing: sizing,
      );
    } catch (e) {
      state = state.copyWith(
        isAnalyzing: false,
        errorMessage: e.toString(),
        lastPipelineStage: 'Failed',
      );
    }
  }

  Future<void> loadHistory() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final history = await analysisRepo.getAll();
      state = state.copyWith(history: history, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteAnalysis(int id) async {
    try {
      await analysisRepo.delete(id);
      await loadHistory();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

final analysisViewModelProvider =
    StateNotifierProvider<AnalysisViewModel, AnalysisState>((ref) {
  final analysisRepo = ref.watch(analysisRepositoryProvider);
  final providerRepo = ref.watch(providerRepositoryProvider);
  final db = ref.watch(databaseProvider);
  return AnalysisViewModel(
    analysisRepo: analysisRepo,
    providerRepo: providerRepo,
    db: db,
  );
});
