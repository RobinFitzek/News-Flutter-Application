import '../data/datasources/remote/yahoo_finance_client.dart';

/// Short interest + squeeze detection — mirrors short_interest.py.
class ShortInterestTracker {
  ShortInterestTracker({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(minutes: 30);

  Future<Map<String, dynamic>?> getShortData(String ticker) async {
    final key = ticker.toUpperCase();
    final cached = _cache[key];
    if (cached != null &&
        DateTime.now().difference(cached.at) < _cacheDuration) {
      return cached.data;
    }

    try {
      final info = await _yahoo.getStockInfo(key);
      var siPct = info['shortPercentOfFloat'] as double?;
      if (siPct != null && siPct < 1) siPct *= 100;

      final data = {
        'ticker': key,
        'short_pct_float': siPct,
        'days_to_cover': info['shortRatio'] as double?,
        'short_shares': info['sharesShort'] as int?,
        'float_shares': info['floatShares'] as double?,
        'shares_outstanding': info['sharesOutstanding'] as double?,
        'current_price': info['currentPrice'] as double?,
        'fetched_at': DateTime.now().toIso8601String(),
      };

      _cache[key] = _CacheEntry(data, DateTime.now());
      return data;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> checkSqueezeSetup(String ticker) async {
    final shortData = await getShortData(ticker);
    if (shortData == null || shortData['short_pct_float'] == null) return null;

    final siPct = shortData['short_pct_float'] as double;
    final dtc = (shortData['days_to_cover'] as num?)?.toDouble() ?? 0;

    final bars = await _yahoo.getOhlcvHistory(ticker, range: '1mo');
    if (bars.length < 5) return null;

    final closes = bars.map((b) => (b['close'] as num).toDouble()).toList();
    final priceNow = closes.last;
    final price5d = closes[closes.length - 5];
    final change5d = ((priceNow - price5d) / price5d) * 100;

    var score = 0;
    final signals = <String>[];

    if (siPct >= 20) {
      score += 40;
      signals.add('Very high SI: ${siPct.toStringAsFixed(1)}%');
    } else if (siPct >= 15) {
      score += 25;
      signals.add('High SI: ${siPct.toStringAsFixed(1)}%');
    } else if (siPct >= 10) {
      score += 10;
      signals.add('Elevated SI: ${siPct.toStringAsFixed(1)}%');
    }

    if (dtc >= 5) {
      score += 25;
      signals.add('High days-to-cover: ${dtc.toStringAsFixed(1)}');
    } else if (dtc >= 3) {
      score += 15;
      signals.add('Moderate days-to-cover: ${dtc.toStringAsFixed(1)}');
    }

    if (change5d > 5) {
      score += 25;
      signals.add('Strong 5d momentum: +${change5d.toStringAsFixed(1)}%');
    } else if (change5d > 2) {
      score += 15;
      signals.add('Rising 5d momentum: +${change5d.toStringAsFixed(1)}%');
    }

    return {
      'ticker': ticker.toUpperCase(),
      'squeeze_score': score,
      'is_squeeze_candidate': score >= 50,
      'short_pct_float': siPct,
      'days_to_cover': dtc,
      'price_change_5d': double.parse(change5d.toStringAsFixed(2)),
      'signals': signals,
    };
  }
}

class _CacheEntry {
  _CacheEntry(this.data, this.at);
  final Map<String, dynamic> data;
  final DateTime at;
}
