abstract class AiClientInterface {
  Future<bool> testConnection();
  Future<String> generateText(String prompt);
  String get providerType;
}
