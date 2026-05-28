import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../data/repositories/analysis_repository.dart';
import '../../data/repositories/paper_trading_repository.dart';
import '../../data/repositories/geopolitical_repository.dart';
import '../../engine/auto_paper_trader.dart';
import '../../engine/economic_calendar.dart';
import '../../engine/fear_greed_tracker.dart';
import '../../engine/learning_optimizer.dart';
import '../../engine/market_regime.dart';
import '../../engine/nlp_scorer.dart';
import '../../engine/portfolio_benchmark.dart';
import '../../engine/signal_grader.dart';
import '../../data/repositories/portfolio_repository.dart';

class DashboardState {
  const DashboardState({
    this.topMovers = const [],
    this.recentAnalyses = const [],
    this.watchlistCount = 0,
    this.marketRegime,
    this.fearGreed,
    this.intelStats = const {},
    this.geoScan,
    this.geoExposures = const [],
    this.autoTradeStatus,
    this.paperSummary = const {},
    this.benchmark,
    this.calendarEvents = const [],
    this.pendingAutoTrades = const [],
    this.sentimentMovers = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<WatchlistItemData> topMovers;
  final List<AnalysisResultData> recentAnalyses;
  final int watchlistCount;
  final Map<String, dynamic>? marketRegime;
  final Map<String, dynamic>? fearGreed;
  final Map<String, dynamic> intelStats;
  final GeopoliticalEventData? geoScan;
  final List<Map<String, dynamic>> geoExposures;
  final Map<String, dynamic>? autoTradeStatus;
  final Map<String, dynamic> paperSummary;
  final Map<String, dynamic>? benchmark;
  final List<Map<String, dynamic>> calendarEvents;
  final List<AutoTradePendingData> pendingAutoTrades;
  final List<Map<String, dynamic>> sentimentMovers;
  final bool isLoading;
  final String? errorMessage;

  DashboardState copyWith({
    List<WatchlistItemData>? topMovers,
    List<AnalysisResultData>? recentAnalyses,
    int? watchlistCount,
    Map<String, dynamic>? marketRegime,
    Map<String, dynamic>? fearGreed,
    Map<String, dynamic>? intelStats,
    GeopoliticalEventData? geoScan,
    List<Map<String, dynamic>>? geoExposures,
    Map<String, dynamic>? autoTradeStatus,
    Map<String, dynamic>? paperSummary,
    Map<String, dynamic>? benchmark,
    List<Map<String, dynamic>>? calendarEvents,
    List<AutoTradePendingData>? pendingAutoTrades,
    List<Map<String, dynamic>>? sentimentMovers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      topMovers: topMovers ?? this.topMovers,
      recentAnalyses: recentAnalyses ?? this.recentAnalyses,
      watchlistCount: watchlistCount ?? this.watchlistCount,
      marketRegime: marketRegime ?? this.marketRegime,
      fearGreed: fearGreed ?? this.fearGreed,
      intelStats: intelStats ?? this.intelStats,
      geoScan: geoScan ?? this.geoScan,
      geoExposures: geoExposures ?? this.geoExposures,
      autoTradeStatus: autoTradeStatus ?? this.autoTradeStatus,
      paperSummary: paperSummary ?? this.paperSummary,
      benchmark: benchmark ?? this.benchmark,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      pendingAutoTrades: pendingAutoTrades ?? this.pendingAutoTrades,
      sentimentMovers: sentimentMovers ?? this.sentimentMovers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel({
    required this.db,
    required this.watchlistRepo,
    required this.analysisRepo,
    required this.paperRepo,
    required this.geoRepo,
    required this.portfolioRepo,
  }) : super(const DashboardState());

  final AppDatabase db;
  final WatchlistRepository watchlistRepo;
  final AnalysisRepository analysisRepo;
  final PaperTradingRepository paperRepo;
  final GeopoliticalRepository geoRepo;
  final PortfolioRepository portfolioRepo;

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await watchlistRepo.getAll();
      final symbols = items.map((i) => i.symbol).toList();

      final withPrices = items.where((i) => i.lastPrice != null).toList()
        ..sort((a, b) {
          final aChange = (a.lastPriceChange ?? 0).abs();
          final bChange = (b.lastPriceChange ?? 0).abs();
          return bChange.compareTo(aChange);
        });

      final analyses = await analysisRepo.getAll();

      final regime = await MarketRegime().getCurrentRegime();
      final fg = await FearGreedTracker().getCurrentSnapshot();

      final learning = LearningOptimizer(db);
      final learningStats = await learning.getLearningStats();
      final gradeStats = await SignalGrader(db).getGradeStats();

      final discoveries7d = await _discoveriesLast7Days();

      final geoScan = await geoRepo.getLatestScan();
      final geoExposures = await geoRepo.getWatchlistExposure(symbols);

      final autoTrader = AutoPaperTrader(db, paperRepo: paperRepo);
      final autoStatus = await autoTrader.getStatus();
      final pendingAuto = await autoTrader.getPendingConfirmations();

      final positions = await portfolioRepo.getAllPositions();
      final openPaper = await paperRepo.getOpenTrades();
      final closedPaper = await paperRepo.getClosedTrades();
      final cash = await paperRepo.getCashBalance();

      final benchmark = await PortfolioBenchmark().calculate(
        positions: positions,
        paperTrades: openPaper,
      );

      final calendarEvents = await EconomicCalendar().getUpcomingEvents(
        watchlistSymbols: symbols,
      );

      final sentimentMovers = await NlpScorer(db).getSentimentMovers();

      state = state.copyWith(
        topMovers: withPrices.take(5).toList(),
        recentAnalyses: analyses.take(3).toList(),
        watchlistCount: items.length,
        marketRegime: regime,
        fearGreed: fg,
        intelStats: {
          'hit_rate': gradeStats['hit_rate'] ?? learningStats['hit_rate'] ?? 0,
          'verified': learningStats['total_verified'] ?? 0,
          'pending': learningStats['pending_verification'] ?? 0,
          'discoveries_7d': discoveries7d,
        },
        geoScan: geoScan,
        geoExposures: geoExposures,
        autoTradeStatus: autoStatus,
        pendingAutoTrades: pendingAuto,
        benchmark: benchmark,
        calendarEvents: calendarEvents,
        sentimentMovers: sentimentMovers,
        paperSummary: {
          'cash': cash,
          'open_trades': openPaper.length,
          'closed_trades': closedPaper.length,
          'realized_pnl':
              closedPaper.fold<double>(0, (s, t) => s + (t.realizedPnl ?? 0)),
        },
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<int> _discoveriesLast7Days() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    final rows = await (db.select(db.discoveries)
          ..where((t) => t.discoveredAt.isBiggerOrEqualValue(cutoff)))
        .get();
    return rows.length;
  }
}

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  return DashboardViewModel(
    db: ref.watch(databaseProvider),
    watchlistRepo: ref.watch(watchlistRepositoryProvider),
    analysisRepo: ref.watch(analysisRepositoryProvider),
    paperRepo: ref.watch(paperTradingRepositoryProvider),
    geoRepo: ref.watch(geopoliticalRepositoryProvider),
    portfolioRepo: ref.watch(portfolioRepositoryProvider),
  );
});
