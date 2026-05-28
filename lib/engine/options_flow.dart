import '../data/datasources/remote/yahoo_finance_client.dart';

/// Options flow analyzer — mirrors options_flow.py.
class OptionsFlow {
  OptionsFlow({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(minutes: 15);

  Future<Map<String, dynamic>?> getOptionsSummary(String ticker) async {
    final key = ticker.toUpperCase();
    final cached = _cache[key];
    if (cached != null &&
        DateTime.now().difference(cached.at) < _cacheDuration) {
      return cached.data;
    }

    final data = await _yahoo.getOptionsSummary(key);
    if (data != null) {
      _cache[key] = _CacheEntry(data, DateTime.now());
    }
    return data;
  }

  Future<Map<String, dynamic>?> getPutCallRatio(String ticker) async {
    final summary = await getOptionsSummary(ticker);
    if (summary == null) return null;
    return {
      'ticker': summary['ticker'],
      'pc_ratio_volume': summary['pc_ratio_volume'],
      'pc_ratio_oi': summary['pc_ratio_oi'],
      'sentiment': summary['sentiment'],
      'call_volume': summary['call_volume'],
      'put_volume': summary['put_volume'],
    };
  }

  Future<Map<String, dynamic>?> detectUnusualActivity(String ticker) async {
    final summary = await getOptionsSummary(ticker);
    if (summary == null) return null;

    final unusual =
        List<Map<String, dynamic>>.from(summary['unusual_activity'] ?? []);
    final calls = unusual.where((u) => u['type'] == 'call').toList();
    final puts = unusual.where((u) => u['type'] == 'put').toList();

    return {
      'ticker': summary['ticker'],
      'expiry': summary['expiry'],
      'has_unusual_activity': unusual.isNotEmpty,
      'unusual_calls': calls.take(5).toList(),
      'unusual_puts': puts.take(5).toList(),
      'bias': calls.length > puts.length
          ? 'bullish'
          : puts.length > calls.length
              ? 'bearish'
              : 'neutral',
    };
  }
}

class _CacheEntry {
  _CacheEntry(this.data, this.at);
  final Map<String, dynamic> data;
  final DateTime at;
}
