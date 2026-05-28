import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_provider.freezed.dart';
part 'ai_provider.g.dart';

@freezed
class AiProvider with _$AiProvider {
  const factory AiProvider({
    int? id,
    required String name,
    required ProviderType type,
    required String baseUrl,
    required String apiKey,
    required String model,
    @Default(true) bool isEnabled,
    @Default(false) bool isConnected,
    @Default(0) int totalCalls,
    @Default(0.0) double totalCost,
    DateTime? lastTestedAt,
    DateTime? createdAt,
  }) = _AiProvider;

  factory AiProvider.fromJson(Map<String, dynamic> json) =>
      _$AiProviderFromJson(json);
}

enum ProviderType { gemini, perplexity, openai, claude, custom, ollama }
