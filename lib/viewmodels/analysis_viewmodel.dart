import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/analysis_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../data/datasources/remote/provider_factory.dart';
import '../../models/stage_assignment.dart';

class AnalysisState {
  const AnalysisState({
    this.currentAnalysis,
    this.history = const [],
    this.isLoading = false,
    this.isAnalyzing = false,
    this.errorMessage,
  });

  final AnalysisResultData? currentAnalysis;
  final List<AnalysisResultData> history;
  final bool isLoading;
  final bool isAnalyzing;
  final String? errorMessage;

  AnalysisState copyWith({
    AnalysisResultData? currentAnalysis,
    List<AnalysisResultData>? history,
    bool? isLoading,
    bool? isAnalyzing,
    String? errorMessage,
    bool clearError = false,
    bool clearCurrent = false,
  }) {
    return AnalysisState(
      currentAnalysis:
          clearCurrent ? null : (currentAnalysis ?? this.currentAnalysis),
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      errorMessage:
          clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AnalysisViewModel extends StateNotifier<AnalysisState> {
  AnalysisViewModel({
    required this.analysisRepo,
    required this.providerRepo,
  }) : super(const AnalysisState()) {
    _yahooClient = YahooFinanceClient();
  }

  final AnalysisRepository analysisRepo;
  final ProviderRepository providerRepo;
  late final YahooFinanceClient _yahooClient;

  String _newsPrompt(String symbol) =>
      'Find the 3-5 most recent and impactful news headlines about $symbol stock. '
      'For each, include the date and a one-sentence summary. '
      'Focus on news that could move the stock price this week.';

  String _analysisPrompt(
    String symbol,
    double price,
    String timeframe,
    String news,
  ) =>
      '''You are an expert stock market analyst. Analyze $symbol at \$${price.toStringAsFixed(2)} for a $timeframe outlook.

Recent news:
$news

Using your knowledge of the company, technical analysis, sector trends, and the news above, provide a $timeframe price prediction.

Respond ONLY with valid JSON — no markdown, no extra text:
{
  "predictedPrice": number,
  "confidence": number (0.0 to 1.0),
  "recommendation": "BUY" or "SELL" or "HOLD",
  "reasoning": "2-3 paragraph analysis explaining your prediction"
}''';

  Future<void> analyzeStock(String symbol,
      {String timeframe = 'daily'}) async {
    state = state.copyWith(isAnalyzing: true, clearError: true, clearCurrent: true);

    try {
      final quote = await _yahooClient.getStockQuote(symbol);
      final currentPrice = (quote['currentPrice'] as num).toDouble();

      String? newsSummary;
      final newsProvider = await providerRepo.getByStage(AnalysisStage.newsResearch);
      if (newsProvider == null) {
        state = state.copyWith(
          isAnalyzing: false,
          errorMessage:
              'No provider assigned for newsResearch. Set one in Settings.',
        );
        return;
      }
      if (newsProvider.apiKey.isEmpty) {
        state = state.copyWith(
          isAnalyzing: false,
          errorMessage:
              '${newsProvider.name} has no API key. Add one in Settings.',
        );
        return;
      }

      try {
        final newsClient = ProviderFactory.createFromData(newsProvider);
        newsSummary = await newsClient.generateText(_newsPrompt(symbol));
      } catch (e) {
        newsSummary = 'News research unavailable: ${e.toString().split('\n').first}';
      }

      final analysisProvider =
          await providerRepo.getByStage(AnalysisStage.finalAnalysis);
      if (analysisProvider == null) {
        state = state.copyWith(
          isAnalyzing: false,
          errorMessage:
              'No provider assigned for finalAnalysis. Set one in Settings.',
        );
        return;
      }
      if (analysisProvider.apiKey.isEmpty) {
        state = state.copyWith(
          isAnalyzing: false,
          errorMessage:
              '${analysisProvider.name} has no API key. Add one in Settings.',
        );
        return;
      }

      final analysisClient = ProviderFactory.createFromData(analysisProvider);
      final rawResponse = await analysisClient.generateText(
        _analysisPrompt(symbol, currentPrice, timeframe, newsSummary),
      );

      final parsed = _parseAnalysisResponse(rawResponse, currentPrice);

      final result = AnalysisResultData(
        id: 0,
        symbol: symbol.toUpperCase(),
        predictedPrice: parsed['predictedPrice'] as double,
        confidence: parsed['confidence'] as double,
        recommendation: parsed['recommendation'] as String,
        reasoning: parsed['reasoning'] as String,
        newsSummary: newsSummary,
        timeframe: timeframe,
        currentPrice: currentPrice,
        createdAt: DateTime.now(),
      );

      final saved = await analysisRepo.save(result);
      await loadHistory();

      state = state.copyWith(
        currentAnalysis: saved,
        isAnalyzing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isAnalyzing: false,
        errorMessage: e.toString(),
      );
    }
  }

  Map<String, dynamic> _parseAnalysisResponse(String raw, double fallbackPrice) {
    try {
      String jsonStr = raw.trim();
      if (jsonStr.startsWith('```')) {
        final firstNewline = jsonStr.indexOf('\n');
        if (firstNewline != -1) {
          jsonStr = jsonStr.substring(firstNewline + 1);
        }
        if (jsonStr.endsWith('```')) {
          jsonStr = jsonStr.substring(0, jsonStr.length - 3);
        }
        jsonStr = jsonStr.trim();
      }

      final startBrace = jsonStr.indexOf('{');
      final endBrace = jsonStr.lastIndexOf('}');
      if (startBrace != -1 && endBrace != -1 && endBrace > startBrace) {
        jsonStr = jsonStr.substring(startBrace, endBrace + 1);
      }

      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return {
        'predictedPrice': (map['predictedPrice'] as num?)?.toDouble() ?? fallbackPrice,
        'confidence': (map['confidence'] as num?)?.toDouble() ?? 0.5,
        'recommendation': map['recommendation'] as String? ?? 'HOLD',
        'reasoning': map['reasoning'] as String? ?? 'Analysis parsing failed.',
      };
    } catch (_) {
      return {
        'predictedPrice': fallbackPrice,
        'confidence': 0.5,
        'recommendation': 'HOLD',
        'reasoning': 'Analysis parsing failed.',
      };
    }
  }

  Future<void> loadHistory() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final history = await analysisRepo.getAll();
      state = state.copyWith(history: history, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteAnalysis(int id) async {
    try {
      await analysisRepo.delete(id);
      await loadHistory();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

final analysisViewModelProvider =
    StateNotifierProvider<AnalysisViewModel, AnalysisState>((ref) {
  final analysisRepo = ref.watch(analysisRepositoryProvider);
  final providerRepo = ref.watch(providerRepositoryProvider);
  return AnalysisViewModel(
    analysisRepo: analysisRepo,
    providerRepo: providerRepo,
  );
});
