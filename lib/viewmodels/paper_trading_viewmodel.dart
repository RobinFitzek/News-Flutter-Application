import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/paper_trading_repository.dart';
import '../../data/repositories/portfolio_repository.dart';

class PaperTradingState {
  const PaperTradingState({
    this.trades = const [],
    this.openTrades = const [],
    this.cashBalance = 100000.0,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<PaperTradeData> trades;
  final List<PaperTradeData> openTrades;
  final double cashBalance;
  final bool isLoading;
  final String? errorMessage;

  PaperTradingState copyWith({
    List<PaperTradeData>? trades,
    List<PaperTradeData>? openTrades,
    double? cashBalance,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaperTradingState(
      trades: trades ?? this.trades,
      openTrades: openTrades ?? this.openTrades,
      cashBalance: cashBalance ?? this.cashBalance,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PaperTradingViewModel extends StateNotifier<PaperTradingState> {
  PaperTradingViewModel({
    required this.paperRepo,
    required this.portfolioRepo,
  }) : super(const PaperTradingState());

  final PaperTradingRepository paperRepo;
  final PortfolioRepository portfolioRepo;

  Future<void> loadTrades() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final trades = await paperRepo.getAllTrades();
      final openTrades = await paperRepo.getOpenTrades();
      final cash = await paperRepo.getCashBalance();
      state = state.copyWith(
        trades: trades,
        openTrades: openTrades,
        cashBalance: cash,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> openTrade({
    required String symbol,
    required String type,
    required double shares,
    required double price,
  }) async {
    try {
      await paperRepo.openTrade(
        symbol: symbol,
        type: type,
        shares: shares,
        price: price,
      );
      await loadTrades();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> closeTrade(int id,
      {required double exitPrice, required String reason}) async {
    try {
      await paperRepo.closeTrade(id, exitPrice: exitPrice, reason: reason);
      await loadTrades();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> resetPortfolio() async {
    try {
      await paperRepo.resetPortfolio();
      await loadTrades();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<PaperSettingsData?> getSettings() async {
    return paperRepo.getSettings();
  }

  Future<void> updateSettings(PaperSettingsData data) async {
    try {
      await paperRepo.updateSettings(data);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

final paperTradingViewModelProvider =
    StateNotifierProvider<PaperTradingViewModel, PaperTradingState>((ref) {
  final paperRepo = ref.watch(paperTradingRepositoryProvider);
  final portfolioRepo = ref.watch(portfolioRepositoryProvider);
  return PaperTradingViewModel(
    paperRepo: paperRepo,
    portfolioRepo: portfolioRepo,
  );
});
