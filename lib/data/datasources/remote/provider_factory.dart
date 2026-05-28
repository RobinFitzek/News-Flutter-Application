import 'ai_client_interface.dart';
import 'gemini_client.dart';
import 'perplexity_client.dart';
import 'openai_client.dart';
import 'claude_client.dart';
import 'custom_provider_client.dart';
import 'ollama_client.dart';
import '../../database/app_database.dart';

class ProviderFactory {
  static AiClientInterface createFromData(AiProviderData provider) {
    switch (provider.type) {
      case 'gemini':
        return GeminiClient(apiKey: provider.apiKey, model: provider.model);
      case 'perplexity':
        return PerplexityClient(
            apiKey: provider.apiKey, model: provider.model);
      case 'openai':
        return OpenAiClient(
          baseUrl: provider.baseUrl,
          apiKey: provider.apiKey,
          model: provider.model,
        );
      case 'claude':
        return ClaudeClient(apiKey: provider.apiKey, model: provider.model);
      case 'custom':
        return CustomProviderClient(
          baseUrl: provider.baseUrl,
          apiKey: provider.apiKey,
          model: provider.model,
        );
      case 'ollama':
        return OllamaClient(
            baseUrl: provider.baseUrl, model: provider.model);
      default:
        throw Exception('Unknown provider type: ${provider.type}');
    }
  }
}
