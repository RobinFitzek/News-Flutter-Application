import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/datasources/remote/provider_factory.dart';
import '../../models/stage_assignment.dart';

class ProviderState {
  const ProviderState({
    this.providers = const [],
    this.isLoading = false,
    this.testingProviderId,
    this.errorMessage,
  });

  final List<AiProviderData> providers;
  final bool isLoading;
  final int? testingProviderId;
  final String? errorMessage;

  ProviderState copyWith({
    List<AiProviderData>? providers,
    bool? isLoading,
    int? testingProviderId,
    String? errorMessage,
    bool clearError = false,
    bool clearTesting = false,
  }) {
    return ProviderState(
      providers: providers ?? this.providers,
      isLoading: isLoading ?? this.isLoading,
      testingProviderId:
          clearTesting ? null : (testingProviderId ?? this.testingProviderId),
      errorMessage:
          clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class ProviderViewModel extends StateNotifier<ProviderState> {
  ProviderViewModel({required this.providerRepo})
      : super(const ProviderState());

  final ProviderRepository providerRepo;

  Future<void> loadProviders() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final providers = await providerRepo.getAll();
      state = state.copyWith(providers: providers, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> saveProvider(AiProviderData provider) async {
    try {
      await providerRepo.save(provider);
      await loadProviders();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> deleteProvider(int id) async {
    try {
      await providerRepo.delete(id);
      await loadProviders();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> testProvider(int id) async {
    state = state.copyWith(testingProviderId: id, clearError: true);
    try {
      final provider = await providerRepo.getById(id);
      if (provider == null) return;

      final client = ProviderFactory.createFromData(provider);
      final connected = await client.testConnection();

      final updated = provider.copyWith(isConnected: connected);
      await providerRepo.save(updated);
      await loadProviders();
      state = state.copyWith(clearTesting: true);
    } catch (e) {
      state = state.copyWith(
        clearTesting: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> setStage(AnalysisStage stage, int providerId) async {
    try {
      await providerRepo.setStage(stage, providerId);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

final providerViewModelProvider =
    StateNotifierProvider<ProviderViewModel, ProviderState>((ref) {
  final repo = ref.watch(providerRepositoryProvider);
  return ProviderViewModel(providerRepo: repo);
});
