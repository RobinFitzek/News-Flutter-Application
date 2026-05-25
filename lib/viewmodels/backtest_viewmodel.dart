import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/backtest_repository.dart';

class BacktestState {
  const BacktestState({
    this.results = const [],
    this.isLoading = false,
    this.isRunning = false,
    this.errorMessage,
  });
  final List<BacktestResultData> results;
  final bool isLoading;
  final bool isRunning;
  final String? errorMessage;
  BacktestState copyWith({
    List<BacktestResultData>? results, bool? isLoading, bool? isRunning, String? errorMessage,
  }) => BacktestState(
    results: results ?? this.results, isLoading: isLoading ?? this.isLoading,
    isRunning: isRunning ?? this.isRunning, errorMessage: errorMessage ?? this.errorMessage,
  );
}

class BacktestViewModel extends StateNotifier<BacktestState> {
  BacktestViewModel({required this.backtestRepo}) : super(const BacktestState());
  final BacktestRepository backtestRepo;

  Future<void> loadResults() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final results = await backtestRepo.getAll();
      state = state.copyWith(results: results, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
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
}

final backtestViewModelProvider = StateNotifierProvider<BacktestViewModel, BacktestState>((ref) {
  return BacktestViewModel(backtestRepo: ref.watch(backtestRepositoryProvider));
});
