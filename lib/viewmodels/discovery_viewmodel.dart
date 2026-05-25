import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/discovery_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/datasources/remote/provider_factory.dart';
import '../../models/stage_assignment.dart';
import 'dart:convert';

class DiscoveryState {
  const DiscoveryState({
    this.discoveries = const [],
    this.isLoading = false,
    this.isDiscovering = false,
    this.errorMessage,
  });

  final List<DiscoveryData> discoveries;
  final bool isLoading;
  final bool isDiscovering;
  final String? errorMessage;

  DiscoveryState copyWith({
    List<DiscoveryData>? discoveries,
    bool? isLoading,
    bool? isDiscovering,
    String? errorMessage,
  }) {
    return DiscoveryState(
      discoveries: discoveries ?? this.discoveries,
      isLoading: isLoading ?? this.isLoading,
      isDiscovering: isDiscovering ?? this.isDiscovering,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DiscoveryViewModel extends StateNotifier<DiscoveryState> {
  DiscoveryViewModel({
    required this.discoveryRepo,
    required this.providerRepo,
  }) : super(const DiscoveryState());

  final DiscoveryRepository discoveryRepo;
  final ProviderRepository providerRepo;

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
      final provider = await providerRepo.getByStage(AnalysisStage.newsResearch);
      if (provider == null || provider.apiKey.isEmpty) {
        state = state.copyWith(
          isDiscovering: false,
          errorMessage: 'No AI provider configured for discovery. Set one in Settings.',
        );
        return;
      }

      final client = ProviderFactory.createFromData(provider);
      final prompt = '''You are a stock discovery analyst. Find 5 promising stocks that are under-the-radar but have strong potential in the current market.

For each stock, provide:
1. Ticker symbol
2. Company name
3. Why it's promising (1-2 sentences)
4. Strategy category (one of: value, growth, momentum, dividend, turnaround)
5. Estimated upside potential as a percentage

Respond ONLY with valid JSON — no markdown:
[
  {
    "symbol": "AAPL",
    "companyName": "Apple Inc.",
    "reason": "Strong ecosystem growth...",
    "strategy": "growth",
    "currentPrice": 150.00,
    "confidence": 0.75,
    "potentialUpside": 15.0
  }
]''';

      final response = await client.generateText(prompt);
      final discoveries = _parseDiscoveries(response);

      if (discoveries.isNotEmpty) {
        await discoveryRepo.clearAll();
        await discoveryRepo.saveAll(discoveries);
      }

      final active = await discoveryRepo.getActive();
      state = state.copyWith(discoveries: active, isDiscovering: false);
    } catch (e) {
      state = state.copyWith(isDiscovering: false, errorMessage: e.toString());
    }
  }

  List<DiscoveryData> _parseDiscoveries(String raw) {
    try {
      String jsonStr = raw.trim();
      if (jsonStr.startsWith('```')) {
        final firstNewline = jsonStr.indexOf('\n');
        if (firstNewline != -1) jsonStr = jsonStr.substring(firstNewline + 1);
        if (jsonStr.endsWith('```')) jsonStr = jsonStr.substring(0, jsonStr.length - 3);
        jsonStr = jsonStr.trim();
      }
      final list = jsonDecode(jsonStr) as List<dynamic>;
      return list.map((item) {
        final m = item as Map<String, dynamic>;
        return DiscoveryData(
          id: 0,
          symbol: (m['symbol'] as String).toUpperCase(),
          companyName: m['companyName'] as String? ?? '',
          reason: m['reason'] as String? ?? 'AI discovered opportunity',
          strategy: m['strategy'] as String? ?? 'ai',
          currentPrice: (m['currentPrice'] as num?)?.toDouble() ?? 100.0,
          confidence: (m['confidence'] as num?)?.toDouble() ?? 0.5,
          discoveredAt: DateTime.now(),
          isPromoted: false,
          isDismissed: false,
          potentialUpside: (m['potentialUpside'] as num?)?.toDouble(),
        );
      }).toList();
    } catch (_) {
      return [];
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
  final discoveryRepo = ref.watch(discoveryRepositoryProvider);
  final providerRepo = ref.watch(providerRepositoryProvider);
  return DiscoveryViewModel(
    discoveryRepo: discoveryRepo,
    providerRepo: providerRepo,
  );
});
