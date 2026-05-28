import '../data/database/app_database.dart';
import '../data/repositories/provider_repository.dart';
import '../models/stage_assignment.dart';
import 'budget_tracker.dart';
import 'investment_swarm.dart';
import 'pipeline_gate.dart';
import 'staleness_tracker.dart';
import 'package:drift/drift.dart';

/// Daily analysis pipeline — mirrors News/engine/pipeline.py.
class AnalysisPipeline {
  AnalysisPipeline({
    required AppDatabase db,
    required ProviderRepository providerRepo,
    InvestmentSwarm? swarm,
  })  : _db = db,
        _providerRepo = providerRepo,
        _swarm = swarm ?? InvestmentSwarm(db: db),
        _budget = BudgetTracker(db);

  final AppDatabase _db;
  final ProviderRepository _providerRepo;
  final InvestmentSwarm _swarm;
  final BudgetTracker _budget;
  final StalenessTracker _staleness = StalenessTracker();

  static bool shouldScanTicker({
    required String tier,
    DateTime? lastScannedAt,
  }) {
    if (lastScannedAt == null) return true;
    final age = DateTime.now().difference(lastScannedAt);
    switch (tier) {
      case 'tier1':
      case 'core':
        return true;
      case 'tier2':
        return age.inHours >= 24;
      default:
        return age.inHours >= 72;
    }
  }

  Future<List<Map<String, dynamic>>> runDailyCycle({
    String variant = 'balanced',
    bool skipGate = false,
  }) async {
    if (!skipGate) {
      final gate = PipelineGate(_db);
      final check = await gate.check();
      if (check['allowed'] != true) {
        return [
          {
            'skipped': true,
            'reasons': check['reasons'],
            'risk_gate': check['risk_gate'],
          }
        ];
      }
    }

    final limits = await _budget.getPipelineLimits();
    final watchlist = await _db.select(_db.watchlistItems).get();

    final eligible = watchlist.where((item) {
      return shouldScanTicker(
        tier: item.tier,
        lastScannedAt: item.lastScannedAt,
      );
    }).toList();

    if (eligible.isEmpty) return [];

    final tickers = eligible.map((w) => w.symbol).toList();

    // Stage 1: Quant screen (free)
    final stage1Results = await _swarm.stage1Scan(tickers, variant: variant);
    await _markScanned(eligible);
    final stage1Max = limits['stage1_max'] as int? ?? 50;
    final topStage1 = stage1Results.take(stage1Max).toList();

    final stage2Max = limits['stage2_max'] as int? ?? 10;
    final stage3Max = limits['stage3_max'] as int? ?? 5;

    final newsProvider = await _providerRepo.getByStage(AnalysisStage.newsResearch);
    final synthesisProvider =
        await _providerRepo.getByStage(AnalysisStage.finalAnalysis);

    final finalResults = <Map<String, dynamic>>[];

    for (var i = 0; i < topStage1.length && i < stage2Max; i++) {
      final candidate = topStage1[i];
      final stage2 = await _swarm.stage2Analyze(
        candidate,
        strategy: variant,
        newsProvider: newsProvider,
      );
      final merged = {...candidate, ...stage2};

      if (i < stage3Max) {
        final stage3 = await _swarm.stage3Synthesize(
          merged,
          strategy: variant,
          synthesisProvider: synthesisProvider,
        );
        finalResults.add(_enrichWithStaleness(stage3));
      } else {
        finalResults.add(_enrichWithStaleness(merged));
      }
    }

    return finalResults;
  }

  Map<String, dynamic> _enrichWithStaleness(Map<String, dynamic> result) {
    final enriched = Map<String, dynamic>.from(result);
    enriched['created_at'] = DateTime.now();
    enriched['confidence'] =
        ((result['confidence'] as num?)?.toDouble() ?? 0.5) * 100;
    return _staleness.enrichAnalysis(enriched);
  }

  Future<void> _markScanned(List<WatchlistItemData> items) async {
    final now = DateTime.now();
    for (final item in items) {
      await (_db.update(_db.watchlistItems)..where((t) => t.id.equals(item.id)))
          .write(WatchlistItemsCompanion(lastScannedAt: Value(now)));
    }
  }

  Future<Map<String, dynamic>> analyzeSingle(
    String ticker, {
    String strategy = 'balanced',
  }) async {
    final newsProvider = await _providerRepo.getByStage(AnalysisStage.newsResearch);
    final synthesisProvider =
        await _providerRepo.getByStage(AnalysisStage.finalAnalysis);

    return _enrichWithStaleness(
      await _swarm.analyzeSingleStock(
        ticker,
        strategy: strategy,
        newsProvider: newsProvider,
        synthesisProvider: synthesisProvider,
      ),
    );
  }
}
