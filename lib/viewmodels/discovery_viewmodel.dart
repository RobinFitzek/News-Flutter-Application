import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/discovery_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../engine/discovery_engine.dart';
import '../../models/stage_assignment.dart';

class DiscoveryState {
  const DiscoveryState({
    this.discoveries = const [],
    this.isLoading = false,
    this.isDiscovering = false,
    this.errorMessage,
    this.lastStrategy,
  });

  final List<DiscoveryData> discoveries;
  final bool isLoading;
  final bool isDiscovering;
  final String? errorMessage;
  final String? lastStrategy;

  DiscoveryState copyWith({
    List<DiscoveryData>? discoveries,
    bool? isLoading,
    bool? isDiscovering,
    String? errorMessage,
    String? lastStrategy,
  }) {
    return DiscoveryState(
      discoveries: discoveries ?? this.discoveries,
      isLoading: isLoading ?? this.isLoading,
      isDiscovering: isDiscovering ?? this.isDiscovering,
      errorMessage: errorMessage ?? this.errorMessage,
      lastStrategy: lastStrategy ?? this.lastStrategy,
    );
  }
}

class DiscoveryViewModel extends StateNotifier<DiscoveryState> {
  DiscoveryViewModel({
    required this.discoveryRepo,
    required this.providerRepo,
    required this.watchlistRepo,
    required this.db,
  }) : super(const DiscoveryState()) {
    _engine = DiscoveryEngine();
  }

  final DiscoveryRepository discoveryRepo;
  final ProviderRepository providerRepo;
  final WatchlistRepository watchlistRepo;
  final AppDatabase db;
  late final DiscoveryEngine _engine;

  Future<void> loadDiscoveries() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final discoveries = await discoveryRepo.getActive();
      state = state.copyWith(discoveries: discoveries, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> runDiscovery() async {
    state = state.copyWith(isDiscovering: true, errorMessage: null);
    try {
      final watchlist = await watchlistRepo.getAll();
      final watchlistSymbols =
          watchlist.map((w) => w.symbol.toUpperCase()).toSet();

      final aiProvider = await providerRepo.getByStage(AnalysisStage.newsResearch);

      // Primary: quant momentum discovery (zero API cost)
      var discoveries = await _engine.discoverTrending(
        watchlistSymbols: watchlistSymbols,
        limit: 8,
      );
      var strategy = 'momentum (quant screener)';

      // Enrich with AI if provider available and momentum found few results
      if (discoveries.length < 3 &&
          aiProvider != null &&
          aiProvider.apiKey.isNotEmpty) {
        final aiDiscoveries = await _engine.discoverTrending(
          watchlistSymbols: watchlistSymbols,
          limit: 5,
          aiProvider: aiProvider,
        );
        if (aiDiscoveries.isNotEmpty) {
          discoveries = aiDiscoveries;
          strategy = 'ai + momentum fallback';
        }
      }

      if (discoveries.isEmpty) {
        state = state.copyWith(
          isDiscovering: false,
          errorMessage: 'No new discoveries found. Try expanding your criteria.',
        );
        return;
      }

      await discoveryRepo.clearAll();
      await discoveryRepo.saveAll(discoveries);

      final active = await discoveryRepo.getActive();
      state = state.copyWith(
        discoveries: active,
        isDiscovering: false,
        lastStrategy: strategy,
      );
    } catch (e) {
      state = state.copyWith(isDiscovering: false, errorMessage: e.toString());
    }
  }

  Future<void> promoteToWatchlist(int id) async {
    try {
      await discoveryRepo.promote(id);
      await loadDiscoveries();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> dismissDiscovery(int id) async {
    try {
      await discoveryRepo.dismiss(id);
      await loadDiscoveries();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

final discoveryViewModelProvider =
    StateNotifierProvider<DiscoveryViewModel, DiscoveryState>((ref) {
  return DiscoveryViewModel(
    discoveryRepo: ref.watch(discoveryRepositoryProvider),
    providerRepo: ref.watch(providerRepositoryProvider),
    watchlistRepo: ref.watch(watchlistRepositoryProvider),
    db: ref.watch(databaseProvider),
  );
});
