import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/backtest_repository.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../engine/mcpt_validator.dart';
import '../../engine/learning_optimizer.dart';
import '../../engine/backtest_engine.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

class BacktestState {
  const BacktestState({
    this.results = const [],
    this.isLoading = false,
    this.isRunning = false,
    this.isValidating = false,
    this.mcptResult,
    this.errorMessage,
  });
  final List<BacktestResultData> results;
  final bool isLoading;
  final bool isRunning;
  final bool isValidating;
  final Map<String, dynamic>? mcptResult;
  final String? errorMessage;
  BacktestState copyWith({
    List<BacktestResultData>? results,
    bool? isLoading,
    bool? isRunning,
    bool? isValidating,
    Map<String, dynamic>? mcptResult,
    String? errorMessage,
  }) =>
      BacktestState(
        results: results ?? this.results,
        isLoading: isLoading ?? this.isLoading,
        isRunning: isRunning ?? this.isRunning,
        isValidating: isValidating ?? this.isValidating,
        mcptResult: mcptResult ?? this.mcptResult,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class BacktestViewModel extends StateNotifier<BacktestState> {
  BacktestViewModel({required this.backtestRepo, required this.db})
      : super(const BacktestState());

  final BacktestRepository backtestRepo;
  final AppDatabase db;

  Future<void> loadResults() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final results = await backtestRepo.getAll();
      final mcpt = await McptValidator(db).getLatestResult();
      state = state.copyWith(
        results: results,
        isLoading: false,
        mcptResult: mcpt,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> runMcptValidation() async {
    state = state.copyWith(isValidating: true, errorMessage: null);
    try {
      final result = await McptValidator(db).runValidation();
      state = state.copyWith(isValidating: false, mcptResult: result);
    } catch (e) {
      state = state.copyWith(isValidating: false, errorMessage: e.toString());
    }
  }

  Future<void> runBacktest({required List<String> symbols, required String strategy, required double capital, required int days}) async {
    state = state.copyWith(isRunning: true, errorMessage: null);
    try {
      await backtestRepo.runBacktest(symbols: symbols, strategy: strategy, initialCapital: capital, days: days);
      await loadResults();
      state = state.copyWith(isRunning: false);
    } catch (e) {
      state = state.copyWith(isRunning: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteResult(int id) async {
    try {
      await backtestRepo.delete(id);
      await loadResults();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<Map<String, dynamic>> applyWeightsFromLatest({bool dryRun = true}) async {
    final learning = LearningOptimizer(db);
    return learning.autoAdjustWeights(dryRun: dryRun);
  }

  Future<Map<String, dynamic>> runRandomBaseline({
    required List<String> symbols,
    required double capital,
    required int days,
  }) async {
    final engine = BacktestEngine(yahooClient: YahooFinanceClient());
    return engine.runRandomBaseline(
      symbols: symbols,
      initialCapital: capital,
      startDaysAgo: days,
    );
  }
}

final backtestViewModelProvider = StateNotifierProvider<BacktestViewModel, BacktestState>((ref) {
  return BacktestViewModel(
    backtestRepo: ref.watch(backtestRepositoryProvider),
    db: ref.watch(databaseProvider),
  );
});
