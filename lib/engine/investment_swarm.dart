import 'package:drift/drift.dart' show OrderingTerm;

import '../data/datasources/remote/provider_factory.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';
import '../data/database/app_database.dart';
import 'budget_tracker.dart';
import 'market_regime.dart';
import 'meta_labeler.dart';
import 'quant_screener.dart';
import 'volume_analyzer.dart';

/// Multi-agent analysis system — mirrors News/engine/agents.py InvestmentSwarm.
class InvestmentSwarm {
  InvestmentSwarm({
    required AppDatabase db,
    YahooFinanceClient? yahooClient,
    QuantScreener? screener,
    VolumeAnalyzer? volumeAnalyzer,
    MarketRegime? marketRegime,
    MetaLabeler? metaLabeler,
  })  : _db = db,
        _yahoo = yahooClient ?? YahooFinanceClient(),
        _screener = screener ?? QuantScreener(yahooClient: yahooClient),
        _volume = volumeAnalyzer ?? VolumeAnalyzer(yahooClient: yahooClient),
        _regime = marketRegime ?? MarketRegime(yahooClient: yahooClient),
        _budget = BudgetTracker(db),
        _metaLabeler = metaLabeler ?? MetaLabeler(db) {
    _metaLabeler.loadModel();
  }

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;
  final QuantScreener _screener;
  final VolumeAnalyzer _volume;
  final MarketRegime _regime;
  final BudgetTracker _budget;
  final MetaLabeler _metaLabeler;

  Future<Map<String, dynamic>> analyzeSingleStock(
    String ticker, {
    String strategy = 'balanced',
    AiProviderData? newsProvider,
    AiProviderData? synthesisProvider,
  }) async {
    ticker = ticker.toUpperCase().trim();

    final regimeData = await _regime.getCurrentRegime();
    final regime = regimeData['regime']?.toString() ?? 'choppy';
    final weightAdj = _regime.getRegimeWeightAdjustments(regime);

    final volumeMetrics = await _volume.getVolumeMetrics(ticker);

    var quantResult = await _screener.screenTicker(
      ticker,
      variant: strategy,
      regimeWeightAdjustments: weightAdj,
      volumeMetrics: volumeMetrics,
    );

    if (quantResult == null || quantResult.containsKey('error')) {
      final quote = await _yahoo.getStockQuote(ticker);
      quantResult = {
        'ticker': ticker,
        'score': 50,
        'composite_score': 50,
        'signal': 'Neutral',
        'initial_reason': 'Quant data unavailable, manual override',
        'data': {
          'current_price': quote['currentPrice'],
          'name': quote['companyName'],
        },
        'valuation': <String, dynamic>{},
        'technicals': <String, dynamic>{},
        'momentum': <String, dynamic>{},
        'quality': <String, dynamic>{},
        'anomalies': <Map<String, dynamic>>[],
      };
    }

    // Apply volume enhancement + regime adjustment
    final volEnhancement = _volume.enhanceSignal(
      quantResult['signal']?.toString() ?? 'Neutral',
      volumeMetrics,
    );
    quantResult['enhanced_signal'] = volEnhancement['enhanced_signal'];
    quantResult['volume_note'] = volEnhancement['note'];

    final regimeAdj = _regime.getConfidenceAdjustment(
      quantResult['signal']?.toString() ?? 'Neutral',
      regime,
    );
    if (regimeAdj != 0) {
      final composite = (quantResult['composite_score'] as int? ?? 50) + regimeAdj;
      quantResult['composite_score'] = composite.clamp(0, 100);
      quantResult['regime'] = regime;
      quantResult['regime_adjustment'] = regimeAdj;
    }

    if (_metaLabeler.isReady) {
      final meta = _metaLabeler.predict(quantResult);
      quantResult['meta_probability'] = meta['meta_probability'];
      quantResult['meta_signal'] = meta['meta_signal'];
      final original = quantResult['composite_score'] as int? ?? 50;
      final blended = _metaLabeler.blendScore(
        original,
        meta['meta_probability'] as double,
      );
      quantResult['composite_score'] = blended;
      quantResult['score'] = blended;
      quantResult['meta_blended'] = true;
    }

    final stage2 = await stage2Analyze(
      quantResult,
      strategy: strategy,
      newsProvider: newsProvider,
    );

    final merged = {...quantResult, ...stage2};
    return stage3Synthesize(
      merged,
      strategy: strategy,
      synthesisProvider: synthesisProvider,
    );
  }

  Future<List<Map<String, dynamic>>> stage1Scan(
    List<String> tickers, {
    String variant = 'balanced',
  }) async {
    if (tickers.isEmpty) return [];
    final regimeData = await _regime.getCurrentRegime();
    final weightAdj =
        _regime.getRegimeWeightAdjustments(regimeData['regime']?.toString() ?? 'choppy');
    return _screener.screenBatch(tickers, variant: variant, regimeWeightAdjustments: weightAdj);
  }

  Future<Map<String, dynamic>> stage2Analyze(
    Map<String, dynamic> candidate, {
    String strategy = 'balanced',
    AiProviderData? newsProvider,
  }) async {
    final ticker = candidate['ticker']?.toString() ?? '';
    final qm = {
      'valuation': candidate['valuation'] ?? {},
      'technicals': candidate['technicals'] ?? {},
      'momentum': candidate['momentum'] ?? {},
      'quality': candidate['quality'] ?? {},
      'anomalies': candidate['anomalies'] ?? [],
      'composite_score':
          candidate['composite_score'] ?? candidate['score'] ?? 0,
      'signal': candidate['signal'] ?? 'Neutral',
    };

    final val = qm['valuation'] as Map<String, dynamic>;
    final tech = qm['technicals'] as Map<String, dynamic>;
    final mom = qm['momentum'] as Map<String, dynamic>;
    final qual = qm['quality'] as Map<String, dynamic>;

    final results = <String, dynamic>{
      'ticker': ticker,
      'stage1_score': candidate['score'] ?? candidate['composite_score'] ?? 0,
      'stage1_reason': candidate['initial_reason'] ?? '',
      'quant_metrics': qm,
      'fundamental':
          'P/E: ${val['pe_ratio'] ?? 'N/A'} (vs Sektor: ${val['pe_vs_sector'] ?? 'N/A'}x) | '
          'PEG: ${val['peg_ratio'] ?? 'N/A'} | P/B vs Sektor: ${val['pb_vs_sector'] ?? 'N/A'}x | '
          'D/E: ${qual['debt_to_equity'] ?? 'N/A'} | ROE: ${qual['roe'] ?? 'N/A'}% | '
          'FCF Yield: ${qual['fcf_yield'] ?? 'N/A'}%',
      'technical':
          'RSI(14): ${tech['rsi_14'] ?? 'N/A'} | SMA Signal: ${tech['sma_cross_signal'] ?? 'N/A'} | '
          '52W Position: ${tech['price_vs_52w_range'] ?? 'N/A'} | Bollinger: ${tech['bollinger_position'] ?? 'N/A'} | '
          '1M Return: ${mom['return_1m'] ?? 'N/A'}% | 3M: ${mom['return_3m'] ?? 'N/A'}% | '
          '6M: ${mom['return_6m'] ?? 'N/A'}% | vs SPY 1M: ${mom['excess_1m'] ?? 'N/A'}%',
    };

    String news = 'No stage2 provider configured';
    String stage2Provider = 'none';

    if (newsProvider != null && newsProvider.apiKey.isNotEmpty) {
      try {
        final client = ProviderFactory.createFromData(newsProvider);
        news = await client.generateText(_stage2Prompt(ticker));
        stage2Provider = newsProvider.name;
        await _budget.logCost(
          api: newsProvider.type == 'perplexity' ? 'perplexity' : 'gemini',
          model: newsProvider.model,
          inputTokens: 800,
          outputTokens: 400,
          ticker: ticker,
        );
      } catch (e) {
        news = 'News research unavailable: $e';
        stage2Provider = '${newsProvider.name} (failed)';
      }
    }

    results['news'] = news;
    results['stage2_provider'] = stage2Provider;
    results['geopolitical_context'] = await _getGeoContext(ticker);

    return results;
  }

  Future<Map<String, dynamic>> stage3Synthesize(
    Map<String, dynamic> analysisResult, {
    String strategy = 'balanced',
    AiProviderData? synthesisProvider,
  }) async {
    final ticker = analysisResult['ticker']?.toString() ?? '';
    final qm = analysisResult['quant_metrics'] as Map<String, dynamic>? ??
        {
          'valuation': analysisResult['valuation'] ?? {},
          'technicals': analysisResult['technicals'] ?? {},
          'momentum': analysisResult['momentum'] ?? {},
          'quality': analysisResult['quality'] ?? {},
          'anomalies': analysisResult['anomalies'] ?? [],
          'composite_score': analysisResult['composite_score'] ?? 50,
          'signal': analysisResult['signal'] ?? 'Neutral',
        };

    final anomalies = qm['anomalies'] as List? ?? [];
    final anomalyText = anomalies.isEmpty
        ? '  Keine Anomalien erkannt.'
        : anomalies
            .map((a) => '  - ${(a as Map)['description']}')
            .join('\n');

    final geoBlock = analysisResult['geopolitical_context'] != null
        ? '\nGeopolitisches Umfeld:\n${analysisResult['geopolitical_context']}\n'
        : '';

    final prompt = _stage3Prompt(ticker, qm, anomalyText, geoBlock, analysisResult['news']?.toString() ?? '');

    String response =
        'Risk Score: 5\nGeo-Risiko: 5\nBull Case: Not available\nBear Case: Not available\nQuellen: N/A\nZusammenfassung: Analysis provider unavailable.';
    String stage3Provider = 'none';

    if (synthesisProvider != null && synthesisProvider.apiKey.isNotEmpty) {
      try {
        final client = ProviderFactory.createFromData(synthesisProvider);
        response = await client.generateText(prompt);
        stage3Provider = synthesisProvider.name;
        await _budget.logCost(
          api: synthesisProvider.type == 'perplexity' ? 'perplexity' : 'gemini',
          model: synthesisProvider.model,
          inputTokens: 1200,
          outputTokens: 600,
          ticker: ticker,
        );
      } catch (_) {
        stage3Provider = '${synthesisProvider.name} (failed)';
      }
    }

    analysisResult['recommendation'] = response;
    analysisResult['stage3_provider'] = stage3Provider;
    analysisResult['risk_score'] = _extractInt(response, r'Risk Score:\s*(\d+)') ?? 5;
    analysisResult['geo_risk_score'] =
        _extractInt(response, r'Geo-Risiko:\s*(\d+)') ?? 5;
    analysisResult['bull_case'] = _extractSection(response, 'Bull Case');
    analysisResult['bear_case'] = _extractSection(response, 'Bear Case');
    analysisResult['sources'] = _extractSection(response, 'Quellen');
    analysisResult['summary'] = _extractSection(response, 'Zusammenfassung');
    analysisResult['signal'] = qm['signal'] ?? 'Neutral';

    if (analysisResult['bull_case']?.toString().isEmpty ?? true) {
      analysisResult['bull_case'] = 'Konnte nicht aus der Antwort extrahiert werden.';
    }
    if (analysisResult['bear_case']?.toString().isEmpty ?? true) {
      analysisResult['bear_case'] = 'Konnte nicht aus der Antwort extrahiert werden.';
    }

    return analysisResult;
  }

  String _stage2Prompt(String ticker) =>
      'Ticker: $ticker. Provide latest relevant market/news context in 6-10 bullets. '
      'Include sentiment (bullish/neutral/bearish), key events, and source names/URLs if present.';

  String _stage3Prompt(
    String ticker,
    Map<String, dynamic> qm,
    String anomalyText,
    String geoBlock,
    String news,
  ) {
    final val = qm['valuation'] as Map<String, dynamic>? ?? {};
    final tech = qm['technicals'] as Map<String, dynamic>? ?? {};
    final mom = qm['momentum'] as Map<String, dynamic>? ?? {};
    final qual = qm['quality'] as Map<String, dynamic>? ?? {};

    return '''Du bist ein Research-Analyst. Schreibe eine kurze Research-Notiz fuer $ticker.

Quantitative Daten:
- Bewertung: P/E vs Sektor: ${val['pe_vs_sector'] ?? 'N/A'}x, PEG: ${val['peg_ratio'] ?? 'N/A'}, P/B vs Sektor: ${val['pb_vs_sector'] ?? 'N/A'}x
- Technisch: RSI(14): ${tech['rsi_14'] ?? 'N/A'}, SMA-Signal: ${tech['sma_cross_signal'] ?? 'N/A'}, 52W-Position: ${tech['price_vs_52w_range'] ?? 'N/A'}
- Momentum: 1M: ${mom['return_1m'] ?? 'N/A'}%, 3M: ${mom['return_3m'] ?? 'N/A'}%, 6M: ${mom['return_6m'] ?? 'N/A'}%
- Qualitaet: D/E: ${qual['debt_to_equity'] ?? 'N/A'}, ROE: ${qual['roe'] ?? 'N/A'}%, FCF Yield: ${qual['fcf_yield'] ?? 'N/A'}%
- Anomalien:
$anomalyText
- Quant Signal: ${qm['signal'] ?? 'Neutral'} (Score: ${qm['composite_score'] ?? 'N/A'}/100)
$geoBlock
Aktuelle Nachrichten:
$news

KEINE Kauf/Verkauf-Empfehlung. Nur Fakten und Kontext.

Zwingendes Format:
Risk Score: [1-10]
Geo-Risiko: [1-10]
Bull Case: [Argumente für die Aktie - 2-3 Sätze]
Bear Case: [Die größten Risiken und Schwächen - 2-3 Sätze]
Quellen: [Liste der URLs oder Publikationen]
Zusammenfassung: [Kurzer Gesamteindruck]
''';
  }

  Future<String?> _getGeoContext(String ticker) async {
    final latest = await (_db.select(_db.geopoliticalEvents)
          ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)])
          ..limit(1))
        .getSingleOrNull();
    if (latest == null) return null;
    return 'Global geo scan (${latest.severity}/10): ${latest.summary} — assess $ticker exposure.';
  }

  int? _extractInt(String text, String pattern) {
    final match = RegExp(pattern, caseSensitive: false).firstMatch(text);
    return match != null ? int.tryParse(match.group(1)!) : null;
  }

  String _extractSection(String text, String header) {
    final pattern = RegExp(
      '$header:\\s*(.*?)(?=\n(?:Risk Score|Geo-Risiko|Bull Case|Bear Case|Quellen|Zusammenfassung):|\$)',
      caseSensitive: false,
      dotAll: true,
    );
    final match = pattern.firstMatch(text);
    return match?.group(1)?.trim() ?? '';
  }
}
