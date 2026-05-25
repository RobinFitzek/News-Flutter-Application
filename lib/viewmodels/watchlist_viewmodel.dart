import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../data/repositories/stock_cache_repository.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

class WatchlistState {
  const WatchlistState({
    this.items = const [],
    this.quotes = const {},
    this.isLoading = false,
    this.errorMessage,
  });

  final List<WatchlistItemData> items;
  final Map<String, StockCacheData?> quotes;
  final bool isLoading;
  final String? errorMessage;

  WatchlistState copyWith({
    List<WatchlistItemData>? items,
    Map<String, StockCacheData?>? quotes,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WatchlistState(
      items: items ?? this.items,
      quotes: quotes ?? this.quotes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class WatchlistViewModel extends StateNotifier<WatchlistState> {
  WatchlistViewModel({
    required this.watchlistRepo,
    required this.cacheRepo,
    required this.yahooClient,
  }) : super(const WatchlistState());

  final WatchlistRepository watchlistRepo;
  final StockCacheRepository cacheRepo;
  final YahooFinanceClient yahooClient;

  Future<void> loadWatchlist() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await watchlistRepo.getAll();
      final quotes = <String, StockCacheData?>{};
      for (final item in items) {
        quotes[item.symbol] = await cacheRepo.getCached(item.symbol);
      }
      state = state.copyWith(items: items, quotes: quotes, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addTicker(String symbol) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final existing = await watchlistRepo.getBySymbol(symbol);
      if (existing != null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '$symbol is already in your watchlist',
        );
        return;
      }

      final quote = await yahooClient.getStockQuote(symbol);
      await cacheRepo.cacheFromQuote(quote);

      await watchlistRepo.add(symbol);

      final items = await watchlistRepo.getAll();
      final quotes = <String, StockCacheData?>{};
      for (final item in items) {
        quotes[item.symbol] = await cacheRepo.getCached(item.symbol);
      }

      state = state.copyWith(
        items: items,
        quotes: quotes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to add $symbol: ${e.toString().replaceFirst('Exception: ', '')}',
      );
    }
  }

  Future<void> removeTicker(int id) async {
    try {
      await watchlistRepo.remove(id);
      final items = await watchlistRepo.getAll();
      final quotes = Map<String, StockCacheData?>.from(state.quotes);
      final removed = state.items.where((i) => i.id == id).firstOrNull;
      if (removed != null) {
        quotes.remove(removed.symbol);
      }
      state = state.copyWith(items: items, quotes: quotes);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> changeTier(int id, String tier) async {
    try {
      await watchlistRepo.updateTier(id, tier);
      final items = await watchlistRepo.getAll();
      state = state.copyWith(items: items);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> refreshAllQuotes() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await watchlistRepo.getAll();
      final quotes = <String, StockCacheData?>{};

      for (final item in items) {
        try {
          final isStale = await cacheRepo.isStale(
            item.symbol,
            const Duration(minutes: 5),
          );
          if (isStale) {
            final quote = await yahooClient.getStockQuote(item.symbol);
            final cached = await cacheRepo.cacheFromQuote(quote);
            quotes[item.symbol] = cached;
            await watchlistRepo.updatePrice(
              item.id,
              cached.currentPrice,
              cached.change,
            );
          } else {
            quotes[item.symbol] = await cacheRepo.getCached(item.symbol);
          }
        } catch (_) {
          quotes[item.symbol] = await cacheRepo.getCached(item.symbol);
        }
      }

      final refreshedItems = await watchlistRepo.getAll();
      state = state.copyWith(
        items: refreshedItems,
        quotes: quotes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final watchlistViewModelProvider =
    StateNotifierProvider<WatchlistViewModel, WatchlistState>((ref) {
  final watchlistRepo = ref.watch(watchlistRepositoryProvider);
  final cacheRepo = ref.watch(stockCacheRepositoryProvider);
  final yahooClient = YahooFinanceClient();
  return WatchlistViewModel(
    watchlistRepo: watchlistRepo,
    cacheRepo: cacheRepo,
    yahooClient: yahooClient,
  );
});
