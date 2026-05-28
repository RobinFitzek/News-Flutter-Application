import 'package:dio/dio.dart';

import '../data/datasources/remote/yahoo_finance_client.dart';

/// Graham intrinsic value screener — mirrors News/engine/graham_screener.py.
class GrahamScreener {
  GrahamScreener({YahooFinanceClient? yahoo, Dio? dio})
      : _yahoo = yahoo ?? YahooFinanceClient(),
        _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  final YahooFinanceClient _yahoo;
  final Dio _dio;

  static const fallbackAaaYield = 4.8;
  double? _aaaCache;
  DateTime? _aaaCacheTime;

  Future<double> fetchAaaYield() async {
    if (_aaaCache != null &&
        _aaaCacheTime != null &&
        DateTime.now().difference(_aaaCacheTime!).inHours < 24) {
      return _aaaCache!;
    }
    try {
      final response = await _dio.get(
        'https://fred.stlouisfed.org/graph/fredgraph.csv?id=DAAA',
      );
      final lines = (response.data as String).trim().split('\n');
      for (var i = lines.length - 1; i >= 0; i--) {
        if (lines[i].startsWith('DATE')) continue;
        final parts = lines[i].split(',');
        if (parts.length == 2 && parts[1] != '.') {
          final val = double.parse(parts[1]);
          _aaaCache = val;
          _aaaCacheTime = DateTime.now();
          return val;
        }
      }
    } catch (_) {}
    _aaaCache = fallbackAaaYield;
    _aaaCacheTime = DateTime.now();
    return fallbackAaaYield;
  }

  double? calculateIntrinsicValue({
    required double eps,
    required double growthRatePct,
    required double aaaYield,
  }) {
    if (aaaYield <= 0) return null;
    return double.parse(
      (eps * (8.5 + 2 * growthRatePct) * (4.4 / aaaYield)).toStringAsFixed(2),
    );
  }

  Future<Map<String, dynamic>> screenTicker(
    String ticker, {
    double discountFactor = 0.2,
  }) async {
    ticker = ticker.toUpperCase();
    final aaaYield = await fetchAaaYield();
    final info = await _yahoo.getStockInfo(ticker);

    final eps = (info['eps'] as num?)?.toDouble() ??
        (info['trailingPE'] != null && info['currentPrice'] != null
            ? (info['currentPrice'] as num).toDouble() /
                (info['trailingPE'] as num).toDouble()
            : null);
    final growthRaw = (info['earningsGrowth'] as num?)?.toDouble() ?? 0.07;
    final growthPct = (growthRaw * 100).clamp(-50.0, 20.0);
    final currentPrice = (info['currentPrice'] as num?)?.toDouble();

    if (eps == null || currentPrice == null) {
      return {
        'ticker': ticker,
        'buy_signal': false,
        'reason': 'Insufficient EPS data',
        'intrinsic_value': null,
        'current_price': currentPrice,
        'upside_pct': null,
        'aaa_yield': aaaYield,
      };
    }

    final iv = calculateIntrinsicValue(
      eps: eps,
      growthRatePct: growthPct,
      aaaYield: aaaYield,
    );

    if (iv == null || iv <= 0) {
      return {
        'ticker': ticker,
        'buy_signal': false,
        'reason': iv != null && iv <= 0 ? 'Negative intrinsic value' : 'Could not calculate IV',
        'intrinsic_value': iv,
        'current_price': currentPrice,
        'upside_pct': null,
        'aaa_yield': aaaYield,
        'ttm_eps': eps,
        'growth_rate': growthPct,
      };
    }

    final buyThreshold = iv * (1 - discountFactor);
    final buySignal = currentPrice <= buyThreshold;
    final upsidePct = ((iv - currentPrice) / currentPrice) * 100;

    return {
      'ticker': ticker,
      'buy_signal': buySignal,
      'reason': buySignal
          ? 'Trading ${discountFactor * 100}% below intrinsic value'
          : 'Above Graham margin of safety',
      'intrinsic_value': iv,
      'current_price': currentPrice,
      'upside_pct': double.parse(upsidePct.toStringAsFixed(1)),
      'aaa_yield': aaaYield,
      'ttm_eps': eps,
      'growth_rate': growthPct,
      'margin_of_safety': discountFactor,
    };
  }

  Future<List<Map<String, dynamic>>> screenBatch(
    List<String> tickers, {
    double discountFactor = 0.2,
  }) async {
    final results = <Map<String, dynamic>>[];
    for (final t in tickers) {
      try {
        results.add(await screenTicker(t, discountFactor: discountFactor));
      } catch (_) {}
    }
    results.sort((a, b) {
      final aUp = (a['upside_pct'] as num?)?.toDouble() ?? -999;
      final bUp = (b['upside_pct'] as num?)?.toDouble() ?? -999;
      return bUp.compareTo(aUp);
    });
    return results;
  }
}
