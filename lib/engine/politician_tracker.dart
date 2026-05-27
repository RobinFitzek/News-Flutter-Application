import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

/// Senate stock trade tracker — mirrors News/engine/politician_tracker.py.
class PoliticianTracker {
  PoliticianTracker({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const _senateUrl =
      'https://senate-stock-watcher-data.s3-us-west-2.amazonaws.com/aggregate/all_transactions.json';

  static const _amountMidpoints = {
    '\$1,001 - \$15,000': 8000,
    '\$15,001 - \$50,000': 32500,
    '\$50,001 - \$100,000': 75000,
    '\$100,001 - \$250,000': 175000,
    '\$250,001 - \$500,000': 375000,
    '\$500,001 - \$1,000,000': 750000,
    '\$1,000,001 - \$5,000,000': 3000000,
    '\$5,000,001 - \$25,000,000': 15000000,
    '\$25,000,001 - \$50,000,000': 37500000,
    '\$50,000,001 +': 75000000,
  };

  List<Map<String, dynamic>>? _cache;
  DateTime? _cacheTime;

  Future<List<Map<String, dynamic>>> fetchSenateTrades() async {
    if (_cache != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!).inHours < 24) {
      return _cache!;
    }
    try {
      final resp = await _dio.get(_senateUrl,
          options: Options(receiveTimeout: const Duration(seconds: 30)));
      final data = (resp.data as List).cast<Map<String, dynamic>>();
      _cache = data;
      _cacheTime = DateTime.now();
      return data;
    } catch (_) {
      return _cache ?? [];
    }
  }

  double _parseAmountMidpoint(String? amountStr) {
    if (amountStr == null || amountStr.isEmpty) return 0;
    for (final entry in _amountMidpoints.entries) {
      if (amountStr.contains(entry.key.replaceAll(r'\$', '\$')) ||
          amountStr.toLowerCase().contains(entry.key.toLowerCase())) {
        return entry.value.toDouble();
      }
    }
    final nums = RegExp(r'[\d,]+')
        .allMatches(amountStr)
        .map((m) => double.tryParse(m.group(0)!.replaceAll(',', '')))
        .whereType<double>()
        .toList();
    if (nums.isEmpty) return 0;
    return nums.reduce((a, b) => a + b) / nums.length;
  }

  bool _isBuy(String? type) {
    final t = (type ?? '').toLowerCase();
    return t.contains('purchase') || t.contains('buy');
  }

  bool _isSell(String? type) {
    final t = (type ?? '').toLowerCase();
    return t.contains('sale') || t.contains('sell');
  }

  Future<List<Map<String, dynamic>>> getRecentTrades({
    String? ticker,
    int days = 30,
  }) async {
    final raw = await fetchSenateTrades();
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final results = <Map<String, dynamic>>[];

    for (final tx in raw) {
      final sym = (tx['ticker'] ?? tx['asset_description'] ?? '')
          .toString()
          .toUpperCase()
          .trim();
      if (sym.isEmpty || sym.length > 6) continue;
      if (ticker != null && sym != ticker.toUpperCase()) continue;

      final dateStr = tx['transaction_date']?.toString() ?? tx['date']?.toString();
      final dt = DateTime.tryParse(dateStr ?? '');
      if (dt == null || dt.isBefore(cutoff)) continue;

      final txType = tx['type']?.toString() ?? '';
      final amountMid = _parseAmountMidpoint(tx['amount']?.toString());

      results.add({
        'ticker': sym,
        'date': dt.toIso8601String().split('T').first,
        'tx_type': txType,
        'asset_type': tx['asset_type']?.toString() ?? 'Stock',
        'senator': tx['senator']?.toString() ?? tx['representative']?.toString() ?? 'Unknown',
        'amount_mid': amountMid,
        'is_buy': _isBuy(txType),
        'is_sell': _isSell(txType),
      });
      if (results.length >= 500) break;
    }

    results.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));
    return results;
  }

  Future<List<Map<String, dynamic>>> getTopTradedTickers({
    int days = 90,
    int topN = 20,
  }) async {
    final trades = await getRecentTrades(days: days);
    final byTicker = <String, Map<String, dynamic>>{};

    for (final t in trades) {
      final sym = t['ticker'] as String;
      byTicker.putIfAbsent(sym, () => {
            'ticker': sym,
            'total_trades': 0,
            'buy_count': 0,
            'sell_count': 0,
            'unique_senators': <String>{},
            'total_volume_mid': 0.0,
          });
      final agg = byTicker[sym]!;
      agg['total_trades'] = (agg['total_trades'] as int) + 1;
      if (t['is_buy'] == true) agg['buy_count'] = (agg['buy_count'] as int) + 1;
      if (t['is_sell'] == true) agg['sell_count'] = (agg['sell_count'] as int) + 1;
      (agg['unique_senators'] as Set<String>).add(t['senator'] as String);
      agg['total_volume_mid'] =
          (agg['total_volume_mid'] as double) + (t['amount_mid'] as double);
    }

    final list = byTicker.values.map((v) {
      return {
        'ticker': v['ticker'],
        'total_trades': v['total_trades'],
        'buy_count': v['buy_count'],
        'sell_count': v['sell_count'],
        'unique_senators': (v['unique_senators'] as Set).length,
        'total_volume_mid': v['total_volume_mid'],
      };
    }).toList();

    list.sort((a, b) =>
        (b['total_trades'] as int).compareTo(a['total_trades'] as int));
    return list.take(topN).toList();
  }

  Future<Map<String, dynamic>> getFeaturesForTicker(String ticker) async {
    final trades = await getRecentTrades(ticker: ticker, days: 90);
    var buys = 0, sells = 0, exchanges = 0, options = 0, bonds = 0;
    final senators = <String>{};
    var moneyMid = 0.0;

    for (final t in trades) {
      if (t['is_buy'] == true) buys++;
      if (t['is_sell'] == true) sells++;
      final asset = (t['asset_type'] as String).toLowerCase();
      if (asset.contains('option')) options++;
      if (asset.contains('bond')) bonds++;
      senators.add(t['senator'] as String);
      moneyMid += t['amount_mid'] as double;
    }

    return {
      'ticker': ticker.toUpperCase(),
      'pol_total_trades': trades.length,
      'pol_buy_count': buys,
      'pol_sell_count': sells,
      'pol_exchange_count': exchanges,
      'pol_options_count': options,
      'pol_bond_other_count': bonds,
      'pol_unique_senators': senators.length,
      'pol_money_range_mid': moneyMid,
      'pol_log_money_mid': trades.isEmpty ? 0.0 : log(moneyMid + 1),
    };
  }
}
