import 'dart:convert';

import 'config/engine_config.dart';
import 'quant_screener.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';
import '../data/datasources/remote/provider_factory.dart';
import '../data/database/app_database.dart';

/// Discovery engine — mirrors News/engine/discovery_engine.py.
class DiscoveryEngine {
  DiscoveryEngine({
    YahooFinanceClient? yahooClient,
    QuantScreener? screener,
  })  : _yahoo = yahooClient ?? YahooFinanceClient(),
        _screener = screener ?? QuantScreener(yahooClient: yahooClient);

  final YahooFinanceClient _yahoo;
  final QuantScreener _screener;

  Future<List<DiscoveryData>> discoverTrending({
    required Set<String> watchlistSymbols,
    int limit = 5,
    AiProviderData? aiProvider,
  }) async {
    if (aiProvider != null && aiProvider.apiKey.isNotEmpty) {
      final aiResults = await _discoverWithAi(aiProvider, watchlistSymbols, limit);
      if (aiResults.isNotEmpty) return aiResults;
    }
    return _momentumDiscovery(watchlistSymbols, limit);
  }

  Future<List<DiscoveryData>> _discoverWithAi(
    AiProviderData provider,
    Set<String> watchlist,
    int limit,
  ) async {
    try {
      final client = ProviderFactory.createFromData(provider);
      final prompt = '''Find $limit promising US stocks with strong potential right now.
Exclude these tickers already on watchlist: ${watchlist.join(', ')}.

Respond ONLY with valid JSON array:
[{"symbol":"TICKER","companyName":"Name","reason":"1-2 sentences","strategy":"momentum|value|growth","confidence":0.75,"potentialUpside":15.0}]''';

      final response = await client.generateText(prompt);
      return _parseAiDiscoveries(response, watchlist);
    } catch (_) {
      return [];
    }
  }

  List<DiscoveryData> _parseAiDiscoveries(String raw, Set<String> watchlist) {
    try {
      var jsonStr = raw.trim();
      if (jsonStr.startsWith('```')) {
        final nl = jsonStr.indexOf('\n');
        if (nl != -1) jsonStr = jsonStr.substring(nl + 1);
        if (jsonStr.endsWith('```')) jsonStr = jsonStr.substring(0, jsonStr.length - 3);
        jsonStr = jsonStr.trim();
      }
      final start = jsonStr.indexOf('[');
      final end = jsonStr.lastIndexOf(']');
      if (start == -1 || end == -1) return [];
      final parsed = jsonDecode(jsonStr.substring(start, end + 1)) as List<dynamic>;
      return parsed.map((item) {
        final m = item as Map<String, dynamic>;
        final symbol = (m['symbol'] as String).toUpperCase();
        if (watchlist.contains(symbol)) return null;
        return DiscoveryData(
          id: 0,
          symbol: symbol,
          companyName: m['companyName'] as String? ?? symbol,
          reason: m['reason'] as String? ?? 'AI discovered opportunity',
          strategy: m['strategy'] as String? ?? 'ai',
          currentPrice: 0,
          confidence: (m['confidence'] as num?)?.toDouble() ?? 0.5,
          discoveredAt: DateTime.now(),
          isPromoted: false,
          isDismissed: false,
          potentialUpside: (m['potentialUpside'] as num?)?.toDouble(),
        );
      }).whereType<DiscoveryData>().toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<DiscoveryData>> _momentumDiscovery(
    Set<String> watchlist,
    int limit,
  ) async {
    final allPeers = <String>{};
    for (final peers in EngineConfig.sectorPeers.values) {
      allPeers.addAll(peers);
    }

    final candidates = allPeers.where((t) => !watchlist.contains(t)).toList();
    final trending = <({String ticker, double change, int score})>[];

    for (final ticker in candidates) {
      try {
        final bars = await _yahoo.getOhlcvHistory(ticker, range: '5d');
        if (bars.length < 2) continue;
        final first = (bars.first['close'] as num).toDouble();
        final last = (bars.last['close'] as num).toDouble();
        if (first == 0) continue;
        final change = ((last - first) / first) * 100;

        final screen = await _screener.screenTicker(ticker);
        final score = screen?['composite_score'] as int? ?? 50;

        if (change > 0 && score >= 55) {
          trending.add((ticker: ticker, change: change, score: score));
        }
      } catch (_) {}
    }

    trending.sort((a, b) {
      final cmp = b.change.compareTo(a.change);
      return cmp != 0 ? cmp : b.score.compareTo(a.score);
    });

    final results = <DiscoveryData>[];
    for (final t in trending.take(limit)) {
      double price = 0;
      String name = t.ticker;
      try {
        final info = await _yahoo.getStockInfo(t.ticker);
        price = (info['currentPrice'] as num?)?.toDouble() ?? 0;
        name = info['longName']?.toString() ?? t.ticker;
      } catch (_) {}

      results.add(DiscoveryData(
        id: 0,
        symbol: t.ticker,
        companyName: name,
        reason:
            '5-day momentum +${t.change.toStringAsFixed(1)}% with quant score ${t.score}/100',
        strategy: 'momentum',
        currentPrice: price,
        confidence: (t.score / 100).clamp(0.0, 1.0),
        discoveredAt: DateTime.now(),
        isPromoted: false,
        isDismissed: false,
        potentialUpside: t.change.clamp(5, 30),
      ));
    }
    return results;
  }

  Future<List<String>> discoverSimilar(
    String ticker, {
    required Set<String> watchlist,
    int limit = 5,
  }) async {
    try {
      final info = await _yahoo.getStockInfo(ticker);
      final sector = info['sector']?.toString() ?? '';
      final peers = EngineConfig.sectorPeers[sector] ?? [];
      return peers
          .where((p) => p != ticker.toUpperCase() && !watchlist.contains(p))
          .take(limit)
          .toList();
    } catch (_) {
      return [];
    }
  }
}
