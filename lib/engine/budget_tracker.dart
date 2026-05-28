import 'package:drift/drift.dart';
import 'config/engine_config.dart';
import '../../data/database/app_database.dart';

/// Adaptive API budget tracker — mirrors News/core/budget_tracker.py.
class BudgetTracker {
  BudgetTracker(this._db);

  final AppDatabase _db;

  Future<double> getMonthlyBudgetEur(String api) async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals('${api}_monthly_budget')))
        .getSingleOrNull();
    if (row != null) {
      return double.tryParse(row.value) ?? EngineConfig.defaultMonthlyBudgetEur[api] ?? 5.0;
    }
    return EngineConfig.defaultMonthlyBudgetEur[api] ?? 5.0;
  }

  Future<double> getMonthlyBudgetUsdAsync(String api) async {
    final eur = await getMonthlyBudgetEur(api);
    return eur * EngineConfig.eurToUsd;
  }

  Future<void> logCost({
    required String api,
    required String model,
    int inputTokens = 0,
    int outputTokens = 0,
    double extraCost = 0,
    String? ticker,
  }) async {
    final cost = _estimateCost(api, model, inputTokens, outputTokens) + extraCost;
    final month = _monthKey();
    final today = _dayKey();

    await _db.into(_db.apiCostLog).insert(
          ApiCostLogCompanion.insert(
            api: api,
            model: model,
            inputTokens: Value(inputTokens),
            outputTokens: Value(outputTokens),
            costUsd: cost,
            month: month,
            day: today,
            ticker: Value(ticker),
          ),
        );
  }

  double _estimateCost(String api, String model, int inputTokens, int outputTokens) {
    if (api == 'perplexity') {
      final pricing = EngineConfig.geminiPricing['sonar-pro']!;
      final tokenCost = inputTokens * pricing['input']! / 1e6 +
          outputTokens * pricing['output']! / 1e6;
      final searchCost = (pricing['searchPer1000'] ?? 5.0) / 1000;
      return tokenCost + searchCost;
    }

    final pricing = EngineConfig.geminiPricing[model] ??
        EngineConfig.geminiPricing['gemini-2.0-flash']!;
    return inputTokens * pricing['input']! / 1e6 +
        outputTokens * pricing['output']! / 1e6;
  }

  Future<double> getMonthSpending(String api) async {
    final month = _monthKey();
    final rows = await (_db.select(_db.apiCostLog)
          ..where((t) => t.api.equals(api) & t.month.equals(month)))
        .get();
    return rows.fold<double>(0, (sum, r) => sum + r.costUsd);
  }

  Future<Map<String, dynamic>> getPipelineLimits() async {
    final pplxBudgetEur = await getMonthlyBudgetEur('perplexity');
    final geminiBudgetEur = await getMonthlyBudgetEur('gemini');
    final pplxBudgetUsd = pplxBudgetEur * EngineConfig.eurToUsd;
    final geminiBudgetUsd = geminiBudgetEur * EngineConfig.eurToUsd;

    final pplxSpent = await getMonthSpending('perplexity');
    final geminiSpent = await getMonthSpending('gemini');

    final pplxRemaining = (pplxBudgetUsd - pplxSpent).clamp(0, double.infinity);
    final geminiRemaining = (geminiBudgetUsd - geminiSpent).clamp(0, double.infinity);

    const pplxCostPerRequest = 0.006;
    const geminiCostPerRequest = 0.002;

    final stage2Max = (pplxRemaining / pplxCostPerRequest).floor().clamp(0, 50);
    final stage3Max = (geminiRemaining / geminiCostPerRequest).floor().clamp(0, 30);

    return {
      'stage1_max': 9999,
      'stage2_max': stage2Max,
      'stage3_max': stage3Max,
      'perplexity_max': stage2Max,
      'pplx_spent_usd': pplxSpent,
      'gemini_spent_usd': geminiSpent,
      'pplx_budget_usd': pplxBudgetUsd,
      'gemini_budget_usd': geminiBudgetUsd,
    };
  }

  Future<Map<String, dynamic>> getBudgetStatus() async {
    final limits = await getPipelineLimits();
    return {
      'perplexity': {
        'budget_usd': limits['pplx_budget_usd'],
        'spent_usd': limits['pplx_spent_usd'],
        'remaining_usd':
            (limits['pplx_budget_usd'] as double) - (limits['pplx_spent_usd'] as double),
      },
      'gemini': {
        'budget_usd': limits['gemini_budget_usd'],
        'spent_usd': limits['gemini_spent_usd'],
        'remaining_usd':
            (limits['gemini_budget_usd'] as double) - (limits['gemini_spent_usd'] as double),
      },
      'pipeline_limits': limits,
    };
  }

  String _monthKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  String _dayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }
}
