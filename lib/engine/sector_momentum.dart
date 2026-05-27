import '../data/datasources/remote/yahoo_finance_client.dart';

/// Sector momentum — mirrors News/engine/sector_momentum.py.
class SectorMomentum {
  SectorMomentum({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const sectorEtfs = {
    'XLK': {'name': 'Technology', 'color': '#3b82f6'},
    'XLF': {'name': 'Financials', 'color': '#22c55e'},
    'XLE': {'name': 'Energy', 'color': '#f97316'},
    'XLV': {'name': 'Healthcare', 'color': '#ec4899'},
    'XLI': {'name': 'Industrials', 'color': '#a855f7'},
    'XLC': {'name': 'Communication', 'color': '#14b8a6'},
    'XLY': {'name': 'Consumer Disc.', 'color': '#eab308'},
    'XLP': {'name': 'Consumer Staples', 'color': '#84cc16'},
    'XLU': {'name': 'Utilities', 'color': '#06b6d4'},
    'XLRE': {'name': 'Real Estate', 'color': '#f43f5e'},
    'XLB': {'name': 'Materials', 'color': '#8b5cf6'},
  };

  List<Map<String, dynamic>>? _cache;
  DateTime? _cacheTime;

  Future<List<Map<String, dynamic>>> getSectorRankings() async {
    if (_cache != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!).inMinutes < 15) {
      return _cache!;
    }

    final spyReturn1m = await _getReturn('SPY', 21);
    final rankings = <Map<String, dynamic>>[];

    for (final entry in sectorEtfs.entries) {
      final etf = entry.key;
      final info = entry.value;
      final r1w = await _getReturn(etf, 5);
      final r1m = await _getReturn(etf, 21);
      final r3m = await _getReturn(etf, 63);
      final relStrength =
          r1m != null && spyReturn1m != null ? r1m - spyReturn1m : 0.0;

      rankings.add({
        'etf': etf,
        'name': info['name'],
        'color': info['color'],
        'return_1wk': r1w ?? 0,
        'return_1mo': r1m ?? 0,
        'return_3mo': r3m ?? 0,
        'relative_strength': double.parse(relStrength.toStringAsFixed(2)),
        'momentum': (r1m ?? 0) > 3
            ? 'hot'
            : (r1m ?? 0) < -3
                ? 'cold'
                : 'neutral',
      });
    }

    rankings.sort(
      (a, b) => (b['return_1mo'] as num).compareTo(a['return_1mo'] as num),
    );

    _cache = rankings;
    _cacheTime = DateTime.now();
    return rankings;
  }

  Future<double?> _getReturn(String symbol, int days) async {
    try {
      final bars = await _yahoo.getOhlcvHistory(symbol, range: '3mo');
      if (bars.length < days + 1) return null;
      final start = (bars[bars.length - days - 1]['close'] as num).toDouble();
      final end = (bars.last['close'] as num).toDouble();
      if (start == 0) return null;
      return double.parse((((end - start) / start) * 100).toStringAsFixed(2));
    } catch (_) {
      return null;
    }
  }

  String? getSectorEtf(String ticker) {
    const map = {
      'AAPL': 'XLK', 'MSFT': 'XLK', 'GOOGL': 'XLK', 'META': 'XLK', 'NVDA': 'XLK',
      'JPM': 'XLF', 'BAC': 'XLF', 'GS': 'XLF',
      'XOM': 'XLE', 'CVX': 'XLE',
      'UNH': 'XLV', 'JNJ': 'XLV', 'PFE': 'XLV',
      'AMZN': 'XLY', 'TSLA': 'XLY', 'HD': 'XLY',
      'PG': 'XLP', 'KO': 'XLP', 'WMT': 'XLP',
      'NFLX': 'XLC', 'DIS': 'XLC',
      'CAT': 'XLI', 'BA': 'XLI', 'GE': 'XLI',
      'NEE': 'XLU', 'AMT': 'XLRE', 'LIN': 'XLB',
    };
    return map[ticker.toUpperCase()];
  }
}
