import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/rss_client.dart';

/// RSS headline sentiment — mirrors nlp_scorer.py (VADER replaced by lexicon).
class NlpScorer {
  NlpScorer(this._db, {RssClient? rss}) : _rss = rss ?? RssClient();

  final AppDatabase _db;
  final RssClient _rss;

  static const _positive = {
    'surge', 'gain', 'gains', 'beat', 'beats', 'strong', 'growth', 'record',
    'bullish', 'upgrade', 'upgraded', 'rally', 'profit', 'profits', 'boost',
    'outperform', 'buy', 'positive', 'soar', 'jump', 'jumps', 'rise', 'rises',
  };

  static const _negative = {
    'fall', 'falls', 'drop', 'drops', 'miss', 'misses', 'weak', 'loss',
    'losses', 'bearish', 'downgrade', 'downgraded', 'selloff', 'cut', 'cuts',
    'underperform', 'sell', 'negative', 'plunge', 'slump', 'decline', 'warning',
  };

  Future<List<Map<String, dynamic>>> runHourlyScoring({
    required List<Map<String, String>> watchlist,
  }) async {
    if (watchlist.isEmpty) return [];

    final headlines = await _rss.fetchHeadlines(
      RssClient.headlineFeeds,
      maxPerFeed: 50,
    );
    if (headlines.isEmpty) return [];

    final results = <Map<String, dynamic>>[];
    for (final row in watchlist) {
      final ticker = row['ticker']!.toUpperCase();
      final companyName = row['company_name'];
      final result = scoreTicker(ticker, headlines, companyName: companyName);
      if ((result['headline_count'] as int? ?? 0) > 0) {
        await _storeSnapshot(result);
        results.add(result);
      }
    }
    return results;
  }

  Map<String, dynamic> scoreTicker(
    String ticker,
    List<Map<String, String>> headlines, {
    String? companyName,
  }) {
    final scores = <Map<String, double>>[];
    for (final h in headlines) {
      final text = '${h['title'] ?? ''} ${h['summary'] ?? ''}'.trim();
      if (!_mentionsTicker(text, ticker, companyName)) continue;
      scores.add(_polarityScores(text));
    }

    if (scores.isEmpty) {
      return {
        'ticker': ticker.toUpperCase(),
        'compound': 0.0,
        'positive': 0.0,
        'neutral': 1.0,
        'negative': 0.0,
        'headline_count': 0,
        'scored_at': DateTime.now().toIso8601String(),
      };
    }

    final compound =
        scores.map((s) => s['compound']!).reduce((a, b) => a + b) / scores.length;
    final positive =
        scores.map((s) => s['positive']!).reduce((a, b) => a + b) / scores.length;
    final neutral =
        scores.map((s) => s['neutral']!).reduce((a, b) => a + b) / scores.length;
    final negative =
        scores.map((s) => s['negative']!).reduce((a, b) => a + b) / scores.length;

    return {
      'ticker': ticker.toUpperCase(),
      'compound': double.parse(compound.toStringAsFixed(4)),
      'positive': double.parse(positive.toStringAsFixed(4)),
      'neutral': double.parse(neutral.toStringAsFixed(4)),
      'negative': double.parse(negative.toStringAsFixed(4)),
      'headline_count': scores.length,
      'scored_at': DateTime.now().toIso8601String(),
    };
  }

  Future<double?> getSentimentDelta(String ticker, {int vsHours = 24}) async {
    final rows = await (_db.select(_db.tickerSentimentSnapshots)
          ..where((t) => t.ticker.equals(ticker.toUpperCase()))
          ..orderBy([(t) => OrderingTerm.desc(t.scoredAt)])
          ..limit(2))
        .get();
    if (rows.length < 2) return null;
    return double.parse(
      (rows[0].compoundScore - rows[1].compoundScore).toStringAsFixed(4),
    );
  }

  Future<List<Map<String, dynamic>>> getSentimentMovers({
    int hours = 24,
    int topN = 10,
  }) async {
    final cutoff = DateTime.now().subtract(Duration(hours: hours));
    final rows = await (_db.select(_db.tickerSentimentSnapshots)
          ..where((t) => t.scoredAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(t) => OrderingTerm.desc(t.scoredAt)]))
        .get();

    final byTicker = <String, List<TickerSentimentData>>{};
    for (final row in rows) {
      byTicker.putIfAbsent(row.ticker, () => []).add(row);
    }

    final movers = <Map<String, dynamic>>[];
    for (final entry in byTicker.entries) {
      final snapshots = entry.value;
      if (snapshots.isEmpty) continue;
      final compounds = snapshots.map((s) => s.compoundScore).toList();
      final maxScore = compounds.reduce((a, b) => a > b ? a : b);
      final minScore = compounds.reduce((a, b) => a < b ? a : b);
      final headlines = snapshots.fold<int>(0, (s, r) => s + r.headlineCount);
      if (headlines == 0) continue;
      movers.add({
        'ticker': entry.key,
        'delta': maxScore - minScore,
        'max_score': maxScore,
        'min_score': minScore,
        'total_headlines': headlines,
        'latest_at': snapshots.first.scoredAt.toIso8601String(),
      });
    }

    movers.sort(
      (a, b) => ((b['delta'] as num).abs()).compareTo((a['delta'] as num).abs()),
    );
    return movers.take(topN).toList();
  }

  Future<void> _storeSnapshot(Map<String, dynamic> result) async {
    await _db.into(_db.tickerSentimentSnapshots).insert(
          TickerSentimentSnapshotsCompanion.insert(
            ticker: result['ticker'] as String,
            compoundScore: Value((result['compound'] as num).toDouble()),
            positive: Value((result['positive'] as num).toDouble()),
            neutral: Value((result['neutral'] as num).toDouble()),
            negative: Value((result['negative'] as num).toDouble()),
            headlineCount: Value(result['headline_count'] as int),
            scoredAt: Value(DateTime.parse(result['scored_at'] as String)),
          ),
        );
  }

  bool _mentionsTicker(String text, String ticker, String? companyName) {
    final upper = text.toUpperCase();
    final pattern = RegExp('\\b${RegExp.escape(ticker.toUpperCase())}\\b');
    if (pattern.hasMatch(upper)) return true;

    if (companyName != null && companyName.isNotEmpty) {
      final parts = companyName.split(' ').where((p) => p.length > 3).take(2);
      if (parts.isNotEmpty &&
          parts.every((p) => upper.contains(p.toUpperCase()))) {
        return true;
      }
    }
    return false;
  }

  Map<String, double> _polarityScores(String text) {
    final words = text.toLowerCase().split(RegExp(r'\W+'));
    var pos = 0;
    var neg = 0;
    for (final w in words) {
      if (_positive.contains(w)) pos++;
      if (_negative.contains(w)) neg++;
    }
    final total = pos + neg;
    if (total == 0) {
      return {'compound': 0.0, 'positive': 0.0, 'neutral': 1.0, 'negative': 0.0};
    }
    final compound = ((pos - neg) / total).clamp(-1.0, 1.0);
    final positive = pos / total;
    final negative = neg / total;
    final neutral = (1.0 - positive - negative).clamp(0.0, 1.0);
    return {
      'compound': compound,
      'positive': positive,
      'neutral': neutral,
      'negative': negative,
    };
  }
}
