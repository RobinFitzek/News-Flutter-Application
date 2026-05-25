class AppConstants {
  AppConstants._();

  // Base URLs for external APIs
  static const String yahooFinanceBaseUrl = 'https://query2.finance.yahoo.com';
  static const String geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta';
  static const String perplexityBaseUrl = 'https://api.perplexity.ai';

  // Default settings
  static const int analysisIntervalHours = 4;
  static const double maxPositionPercent = 10.0;
  static const double stopLossPercent = 15.0;

  // Secure storage keys
  static const String kGeminiApiKey = 'gemini_api_key';
  static const String kPerplexityApiKey = 'perplexity_api_key';
}
