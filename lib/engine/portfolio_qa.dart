import 'package:drift/drift.dart';

import '../core/app_settings_store.dart';
import '../data/database/app_database.dart';
import '../data/datasources/remote/provider_factory.dart';
import '../data/repositories/provider_repository.dart';
import '../models/stage_assignment.dart';
import 'geopolitical_scanner.dart';

/// Portfolio Q&A — mirrors News/engine/portfolio_qa.py.
class PortfolioQa {
  PortfolioQa({
    required AppDatabase db,
    required ProviderRepository providerRepo,
  })  : _db = db,
        _providerRepo = providerRepo,
        _settings = AppSettingsStore(db);

  final AppDatabase _db;
  final ProviderRepository _providerRepo;
  final AppSettingsStore _settings;

  DateTime? _lastQueryAt;

  Future<Map<String, dynamic>> ask(String question) async {
    if (_lastQueryAt != null &&
        DateTime.now().difference(_lastQueryAt!) <
            const Duration(seconds: 30)) {
      return {
        'answer': null,
        'rate_limited': true,
        'error': 'Please wait 30 seconds between questions',
      };
    }

    final provider = await _providerRepo.getByStage(AnalysisStage.finalAnalysis);
    if (provider == null || provider.apiKey.isEmpty) {
      return {
        'answer': null,
        'rate_limited': false,
        'error': 'No analysis provider configured',
      };
    }

    try {
      final context = await _buildContext();
      final client = ProviderFactory.createFromData(provider);
      final prompt = '''You are a portfolio analyst. Answer the user's question based ONLY on the portfolio context below.
Be concise (2-4 paragraphs). Cite specific tickers and numbers.

PORTFOLIO CONTEXT:
$context

USER QUESTION: $question''';

      final answer = await client.generateText(prompt);
      _lastQueryAt = DateTime.now();
      return {
        'answer': answer,
        'sources': ['portfolio', 'analyses', 'geopolitical'],
        'rate_limited': false,
        'error': null,
      };
    } catch (e) {
      return {
        'answer': null,
        'rate_limited': false,
        'error': e.toString(),
      };
    }
  }

  Future<String> _buildContext() async {
    final positions = await _db.select(_db.portfolioPositions).get();
    final analyses = await (_db.select(_db.analysisResults)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(10))
        .get();

    final holdings = positions
        .map((p) =>
            '${p.symbol}: ${p.shares} shares @ \$${p.avgCostBasis.toStringAsFixed(2)} (current \$${p.currentPrice.toStringAsFixed(2)})')
        .join('\n');

    final signals = analyses
        .map((a) =>
            '${a.symbol}: ${a.signal} (${(a.confidence * 100).toStringAsFixed(0)}% conf, risk ${a.riskScore}/10)')
        .join('\n');

    var geoSummary = 'No recent geo scan';
    try {
      final geo = GeopoliticalScanner(_db, providerRepo: _providerRepo);
      final latest = await geo.getLatestScan();
      if (latest != null) {
        geoSummary =
            'Severity ${latest.severity}/10: ${latest.summary.substring(0, latest.summary.length.clamp(0, 200))}';
      }
    } catch (_) {}

    return '''Holdings:
$holdings

Recent AI Signals:
$signals

Geopolitical: $geoSummary''';
  }
}
