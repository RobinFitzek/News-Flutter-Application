import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../data/repositories/stock_cache_repository.dart';
import '../../data/repositories/analysis_repository.dart';

class DashboardState {
  const DashboardState({
    this.topMovers = const [],
    this.recentAnalyses = const [],
    this.watchlistCount = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<WatchlistItemData> topMovers;
  final List<AnalysisResultData> recentAnalyses;
  final int watchlistCount;
  final bool isLoading;
  final String? errorMessage;

  DashboardState copyWith({
    List<WatchlistItemData>? topMovers,
    List<AnalysisResultData>? recentAnalyses,
    int? watchlistCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      topMovers: topMovers ?? this.topMovers,
      recentAnalyses: recentAnalyses ?? this.recentAnalyses,
      watchlistCount: watchlistCount ?? this.watchlistCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel({
    required this.watchlistRepo,
    required this.cacheRepo,
    required this.analysisRepo,
  }) : super(const DashboardState());

  final WatchlistRepository watchlistRepo;
  final StockCacheRepository cacheRepo;
  final AnalysisRepository analysisRepo;

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await watchlistRepo.getAll();

      final withPrices = items.where((i) => i.lastPrice != null).toList()
        ..sort((a, b) {
          final aChange = (a.lastPriceChange ?? 0).abs();
          final bChange = (b.lastPriceChange ?? 0).abs();
          return bChange.compareTo(aChange);
        });

      final analyses = await analysisRepo.getAll();

      state = state.copyWith(
        topMovers: withPrices.take(5).toList(),
        recentAnalyses: analyses.take(3).toList(),
        watchlistCount: items.length,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  final watchlistRepo = ref.watch(watchlistRepositoryProvider);
  final cacheRepo = ref.watch(stockCacheRepositoryProvider);
  final analysisRepo = ref.watch(analysisRepositoryProvider);
  return DashboardViewModel(
    watchlistRepo: watchlistRepo,
    cacheRepo: cacheRepo,
    analysisRepo: analysisRepo,
  );
});
