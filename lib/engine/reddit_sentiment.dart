import 'package:dio/dio.dart';

/// Reddit sentiment — mirrors News/engine/sentiment_reddit.py.
class RedditSentiment {
  RedditSentiment({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(hours: 6);
  static const _subreddits = ['wallstreetbets', 'investing', 'stocks'];

  static const _positive = [
    'bullish', 'buy', 'long', 'moon', 'rocket', 'calls', 'undervalued',
    'breakout', 'strong', 'growth', 'beat', 'upgrade', 'outperform',
  ];
  static const _negative = [
    'bearish', 'sell', 'short', 'crash', 'puts', 'overvalued', 'dump',
    'weak', 'miss', 'downgrade', 'underperform', 'bankruptcy', 'fraud',
  ];

  Future<Map<String, dynamic>> getRedditSentiment(String ticker) async {
    ticker = ticker.toUpperCase();
    final cached = _cache[ticker];
    if (cached != null &&
        DateTime.now().difference(cached.time) < _cacheDuration) {
      return cached.data;
    }

    final posts = <Map<String, dynamic>>[];
    for (final sub in _subreddits) {
      try {
        final resp = await _dio.get(
          'https://www.reddit.com/r/$sub/search.json',
          queryParameters: {
            'q': ticker,
            'sort': 'new',
            'limit': 10,
            'restrict_sr': 'true',
          },
          options: Options(
            headers: {'User-Agent': 'StockholmFlutter/1.0'},
            receiveTimeout: const Duration(seconds: 15),
          ),
        );
        final children =
            (resp.data['data']?['children'] as List?) ?? [];
        for (final child in children) {
          final d = child['data'] as Map<String, dynamic>?;
          if (d == null) continue;
          final title = d['title']?.toString() ?? '';
          final selftext = d['selftext']?.toString() ?? '';
          final text = '$title $selftext';
          posts.add({
            'title': title,
            'url': 'https://reddit.com${d['permalink']}',
            'sentiment': analyzeSentiment(text),
            'score': d['score'] ?? 0,
            'num_comments': d['num_comments'] ?? 0,
            'subreddit': sub,
          });
        }
      } catch (_) {}
    }

    final avgSentiment = posts.isEmpty
        ? 0.0
        : posts.fold<double>(0, (s, p) => s + (p['sentiment'] as double)) /
            posts.length;

    final result = {
      'ticker': ticker,
      'sentiment_score': double.parse(avgSentiment.toStringAsFixed(2)),
      'posts': posts.take(15).toList(),
    };
    _cache[ticker] = _CacheEntry(result, DateTime.now());
    return result;
  }

  double analyzeSentiment(String text) {
    final lower = text.toLowerCase();
    var pos = 0;
    var neg = 0;
    for (final w in _positive) {
      if (lower.contains(w)) pos++;
    }
    for (final w in _negative) {
      if (lower.contains(w)) neg++;
    }
    if (pos + neg == 0) return 0;
    return ((pos - neg) / (pos + neg)).clamp(-1.0, 1.0);
  }
}

class _CacheEntry {
  _CacheEntry(this.data, this.time);
  final Map<String, dynamic> data;
  final DateTime time;
}
