import 'package:dio/dio.dart';

/// Lightweight RSS fetcher — mirrors clients/rss_client.py.
class RssClient {
  RssClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const headlineFeeds = [
    'https://feeds.finance.yahoo.com/rss/2.0/headline',
    'https://feeds.marketwatch.com/marketwatch/topstories',
  ];

  Future<List<Map<String, String>>> fetchHeadlines(
    List<String> feeds, {
    int maxPerFeed = 30,
  }) async {
    final headlines = <Map<String, String>>[];
    for (final feed in feeds) {
      try {
        final response = await _dio.get<String>(
          feed,
          options: Options(
            responseType: ResponseType.plain,
            receiveTimeout: const Duration(seconds: 15),
          ),
        );
        final body = response.data ?? '';
        headlines.addAll(_parseRssItems(body).take(maxPerFeed));
      } catch (_) {
        continue;
      }
    }
    return headlines;
  }

  List<Map<String, String>> _parseRssItems(String xml) {
    final items = <Map<String, String>>[];
    final itemPattern = RegExp(r'<item>(.*?)</item>', dotAll: true);
    for (final match in itemPattern.allMatches(xml)) {
      final block = match.group(1)!;
      final title = _tagValue(block, 'title');
      final summary = _tagValue(block, 'description');
      if (title.isEmpty) continue;
      items.add({'title': title, 'summary': summary});
    }
    return items;
  }

  String _tagValue(String block, String tag) {
    final cdata = RegExp(
      '<$tag><!\\[CDATA\\[(.*?)\\]\\]></$tag>',
      dotAll: true,
    ).firstMatch(block);
    if (cdata != null) return _decode(cdata.group(1)!.trim());

    final plain = RegExp('<$tag>(.*?)</$tag>', dotAll: true).firstMatch(block);
    if (plain != null) return _decode(plain.group(1)!.trim());
    return '';
  }

  String _decode(String raw) {
    return raw
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .trim();
  }
}
