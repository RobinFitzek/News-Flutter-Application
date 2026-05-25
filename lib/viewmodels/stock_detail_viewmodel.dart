import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/stock_cache_repository.dart';
import '../../data/repositories/financial_repository.dart';
import '../../data/repositories/earnings_repository.dart';
import '../../data/repositories/corporate_action_repository.dart';
import '../../data/repositories/insider_repository.dart';
import '../../data/repositories/institutional_repository.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../data/datasources/remote/sec_edgar_client.dart';
import '../../models/chart_data.dart';
import '../../models/chart_data_point.dart';

class StockDetailState {
  const StockDetailState({
    this.quote,
    this.chartData,
    this.financialRatios,
    this.earnings = const [],
    this.corporateActions = const [],
    this.insiderTransactions = const [],
    this.institutionalHolders = const [],
    this.isLoadingQuote = false,
    this.isLoadingChart = false,
    this.isLoadingDetails = false,
    this.errorMessage,
  });

  final StockCacheData? quote;
  final ChartData? chartData;
  final FinancialRatioData? financialRatios;
  final List<EarningsEventData> earnings;
  final List<CorporateActionData> corporateActions;
  final List<InsiderTransactionData> insiderTransactions;
  final List<InstitutionalHolderData> institutionalHolders;
  final bool isLoadingQuote;
  final bool isLoadingChart;
  final bool isLoadingDetails;
  final String? errorMessage;

  StockDetailState copyWith({
    StockCacheData? quote,
    ChartData? chartData,
    FinancialRatioData? financialRatios,
    List<EarningsEventData>? earnings,
    List<CorporateActionData>? corporateActions,
    List<InsiderTransactionData>? insiderTransactions,
    List<InstitutionalHolderData>? institutionalHolders,
    bool? isLoadingQuote,
    bool? isLoadingChart,
    bool? isLoadingDetails,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StockDetailState(
      quote: quote ?? this.quote,
      chartData: chartData ?? this.chartData,
      financialRatios: financialRatios ?? this.financialRatios,
      earnings: earnings ?? this.earnings,
      corporateActions: corporateActions ?? this.corporateActions,
      insiderTransactions: insiderTransactions ?? this.insiderTransactions,
      institutionalHolders: institutionalHolders ?? this.institutionalHolders,
      isLoadingQuote: isLoadingQuote ?? this.isLoadingQuote,
      isLoadingChart: isLoadingChart ?? this.isLoadingChart,
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class StockDetailViewModel extends StateNotifier<StockDetailState> {
  StockDetailViewModel({
    required this.symbol,
    required this.cacheRepo,
    required this.financialRepo,
    required this.earningsRepo,
    required this.corporateActionRepo,
    required this.insiderRepo,
    required this.institutionalRepo,
    required this.yahooClient,
  }) : super(const StockDetailState());

  final String symbol;
  final StockCacheRepository cacheRepo;
  final FinancialRepository financialRepo;
  final EarningsRepository earningsRepo;
  final CorporateActionRepository corporateActionRepo;
  final InsiderRepository insiderRepo;
  final InstitutionalRepository institutionalRepo;
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

      final ratioData = FinancialRatioData(
        id: 0,
        symbol: symbol.toUpperCase(),
        peRatio: quote['trailingPE'] as double?,
        pbRatio: quote['priceToBook'] as double?,
        eps: quote['eps'] as double?,
        dividendYield: quote['dividendYield'] as double?,
        beta: quote['beta'] as double?,
        week52High: quote['fiftyTwoWeekHigh']?.toString() ?? '',
        week52Low: quote['fiftyTwoWeekLow']?.toString() ?? '',
        marketCap: quote['marketCap'] as double?,
        updatedAt: DateTime.now(),
      );
      await financialRepo.save(ratioData);

      state = state.copyWith(
        quote: cached,
        financialRatios: ratioData,
        isLoadingQuote: false,
      );
    } catch (e) {
      final cached = await cacheRepo.getCached(symbol);
      final ratios = await financialRepo.getBySymbol(symbol);
      state = state.copyWith(
        quote: cached,
        financialRatios: ratios,
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

    _loadDetails();
  }

  Future<void> _loadDetails() async {
    state = state.copyWith(isLoadingDetails: true);

    try {
      final rawEarnings = await yahooClient.getEarningsHistory(symbol);
      await earningsRepo.clearForSymbol(symbol);
      if (rawEarnings.isNotEmpty) {
        final earningsData = rawEarnings.map((e) => EarningsEventData(
              id: 0,
              symbol: symbol.toUpperCase(),
              reportDate: DateTime.parse(e['reportDate'] as String),
              estimatedEps: e['estimatedEps'] as double?,
              actualEps: e['actualEps'] as double?,
              surprise: e['surprise'] as double?,
              surprisePercent: e['surprisePercent'] as double?,
              period: e['period'] as String? ?? '',
            )).toList();
        await earningsRepo.saveAll(earningsData);
      }
      state = state.copyWith(
        earnings: await earningsRepo.getBySymbol(symbol),
      );
    } catch (_) {}

    try {
      final rawActions = await yahooClient.getCorporateActions(symbol);
      await corporateActionRepo.clearForSymbol(symbol);
      if (rawActions.isNotEmpty) {
        final actionData = rawActions.map((a) => CorporateActionData(
              id: 0,
              symbol: symbol.toUpperCase(),
              type: a['type'] as String,
              date: DateTime.parse(a['date'] as String),
              description: a['description'] as String?,
              amount: a['amount'] as double?,
              currency: a['currency'] as String? ?? 'USD',
            )).toList();
        await corporateActionRepo.saveAll(actionData);
      }
      state = state.copyWith(
        corporateActions: await corporateActionRepo.getBySymbol(symbol),
      );
    } catch (_) {}

    try {
      final secClient = SecEdgarClient();
      final rawInsider = await secClient.getInsiderTransactions(symbol);
      if (rawInsider.isNotEmpty) {
        await insiderRepo.clearForSymbol(symbol);
        final insiderData = rawInsider.map((t) => InsiderTransactionData(
              id: 0, symbol: symbol.toUpperCase(),
              insiderName: t['insiderName'] as String,
              title: t['title'] as String,
              type: t['type'] as String,
              shares: (t['shares'] as num).toDouble(),
              price: (t['price'] as num).toDouble(),
              totalValue: (t['totalValue'] as num).toDouble(),
              filingDate: t['filingDate'] as DateTime,
              transactionDate: t['transactionDate'] as DateTime,
            )).toList();
        await insiderRepo.saveAll(insiderData);
      }
      state = state.copyWith(
        insiderTransactions: await insiderRepo.getBySymbol(symbol),
      );
    } catch (_) {
      state = state.copyWith(
        insiderTransactions: await insiderRepo.getBySymbol(symbol),
      );
    }

    try {
      state = state.copyWith(
        institutionalHolders: await institutionalRepo.getBySymbol(symbol),
      );
    } catch (_) {}

    state = state.copyWith(isLoadingDetails: false);
  }

  Future<void> loadChart({String interval = '1d', String range = '1mo'}) async {
    state = state.copyWith(isLoadingChart: true);
    try {
      final rawChart = await yahooClient.getHistoricalData(symbol, interval: interval, range: range);
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
      state = state.copyWith(chartData: ChartData(symbol: symbol, dataPoints: dataPoints), isLoadingChart: false);
    } catch (e) {
      state = state.copyWith(isLoadingChart: false, errorMessage: e.toString());
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
    final financialRepo = ref.watch(financialRepositoryProvider);
    final earningsRepo = ref.watch(earningsRepositoryProvider);
    final corporateActionRepo = ref.watch(corporateActionRepositoryProvider);
    final insiderRepo = ref.watch(insiderRepositoryProvider);
    final institutionalRepo = ref.watch(institutionalRepositoryProvider);
    final yahooClient = YahooFinanceClient();
    return StockDetailViewModel(
      symbol: symbol,
      cacheRepo: cacheRepo,
      financialRepo: financialRepo,
      earningsRepo: earningsRepo,
      corporateActionRepo: corporateActionRepo,
      insiderRepo: insiderRepo,
      institutionalRepo: institutionalRepo,
      yahooClient: yahooClient,
    );
  },
);
