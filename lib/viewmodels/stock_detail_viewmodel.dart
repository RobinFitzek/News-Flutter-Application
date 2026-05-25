import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/stock_cache_repository.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../models/chart_data.dart';
import '../../models/chart_data_point.dart';

class StockDetailState {
  const StockDetailState({
    this.quote,
    this.chartData,
    this.isLoadingQuote = false,
    this.isLoadingChart = false,
    this.errorMessage,
  });

  final StockCacheData? quote;
  final ChartData? chartData;
  final bool isLoadingQuote;
  final bool isLoadingChart;
  final String? errorMessage;

  StockDetailState copyWith({
    StockCacheData? quote,
    ChartData? chartData,
    bool? isLoadingQuote,
    bool? isLoadingChart,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StockDetailState(
      quote: quote ?? this.quote,
      chartData: chartData ?? this.chartData,
      isLoadingQuote: isLoadingQuote ?? this.isLoadingQuote,
      isLoadingChart: isLoadingChart ?? this.isLoadingChart,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class StockDetailViewModel extends StateNotifier<StockDetailState> {
  StockDetailViewModel({
    required this.symbol,
    required this.cacheRepo,
    required this.yahooClient,
  }) : super(const StockDetailState());

  final String symbol;
  final StockCacheRepository cacheRepo;
  final YahooFinanceClient yahooClient;

  Future<void> loadStock() async {
    state = state.copyWith(
      isLoadingQuote: true,
      isLoadingChart: true,
      clearError: true,
    );

    try {
      final quote = await yahooClient.getStockQuote(symbol);
      final cached = await cacheRepo.cacheFromQuote(quote);
      state = state.copyWith(quote: cached, isLoadingQuote: false);
    } catch (e) {
      final cached = await cacheRepo.getCached(symbol);
      state = state.copyWith(
        quote: cached,
        isLoadingQuote: false,
        errorMessage: e.toString(),
      );
    }

    try {
      final rawChart = await yahooClient.getHistoricalData(
        symbol,
        interval: '1d',
        range: '1mo',
      );

      final dataPoints = (rawChart['dataPoints'] as List<dynamic>)
          .map((dp) => ChartDataPoint(
                timestamp: DateTime.parse(dp['timestamp'] as String),
                open: (dp['open'] as num).toDouble(),
                high: (dp['high'] as num).toDouble(),
                low: (dp['low'] as num).toDouble(),
                close: (dp['close'] as num).toDouble(),
                volume: dp['volume'] as int,
              ))
          .toList();

      state = state.copyWith(
        chartData: ChartData(symbol: symbol, dataPoints: dataPoints),
        isLoadingChart: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingChart: false,
        errorMessage: state.errorMessage ?? e.toString(),
      );
    }
  }

  Future<void> refreshQuote() async {
    state = state.copyWith(isLoadingQuote: true, clearError: true);
    try {
      final quote = await yahooClient.getStockQuote(symbol);
      final cached = await cacheRepo.cacheFromQuote(quote);
      state = state.copyWith(quote: cached, isLoadingQuote: false);
    } catch (e) {
      state = state.copyWith(
        isLoadingQuote: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final stockDetailViewModelProvider = StateNotifierProvider.family<
    StockDetailViewModel, StockDetailState, String>(
  (ref, symbol) {
    final cacheRepo = ref.watch(stockCacheRepositoryProvider);
    final yahooClient = YahooFinanceClient();
    return StockDetailViewModel(
      symbol: symbol,
      cacheRepo: cacheRepo,
      yahooClient: yahooClient,
    );
  },
);
