import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

class PortfolioState {
  const PortfolioState({
    this.positions = const [],
    this.summary,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<PositionData> positions;
  final PortfolioSummary? summary;
  final bool isLoading;
  final String? errorMessage;

  PortfolioState copyWith({
    List<PositionData>? positions,
    PortfolioSummary? summary,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PortfolioState(
      positions: positions ?? this.positions,
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PortfolioViewModel extends StateNotifier<PortfolioState> {
  PortfolioViewModel({
    required this.portfolioRepo,
  }) : super(const PortfolioState()) {
    _yahooClient = YahooFinanceClient();
  }

  final PortfolioRepository portfolioRepo;
  late final YahooFinanceClient _yahooClient;

  Future<void> loadPositions() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final positions = await portfolioRepo.getAllPositions();
      final summary = await portfolioRepo.getSummary();
      state = state.copyWith(
        positions: positions,
        summary: summary,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addPosition(PositionData data) async {
    try {
      await portfolioRepo.addPosition(data);
      await loadPositions();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> updatePosition(PositionData data) async {
    try {
      await portfolioRepo.updatePosition(data);
      await loadPositions();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> deletePosition(int id) async {
    try {
      await portfolioRepo.deletePosition(id);
      await loadPositions();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> refreshPrices() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final positions = await portfolioRepo.getAllPositions();
      for (final p in positions) {
        try {
          final quote = await _yahooClient.getStockQuote(p.symbol);
          final price = (quote['currentPrice'] as num).toDouble();
          await portfolioRepo.updatePrice(p.id, price);
        } catch (_) {}
      }

      final updated = await portfolioRepo.getAllPositions();
      final summary = await portfolioRepo.getSummary();
      state = state.copyWith(
        positions: updated,
        summary: summary,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final portfolioViewModelProvider =
    StateNotifierProvider<PortfolioViewModel, PortfolioState>((ref) {
  final portfolioRepo = ref.watch(portfolioRepositoryProvider);
  return PortfolioViewModel(portfolioRepo: portfolioRepo);
});
