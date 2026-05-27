import 'quant_screener.dart';
import 'sector_momentum.dart';

/// Sector-relative screener — mirrors GET /api/sector-screen.
class SectorRelativeScreener {
  SectorRelativeScreener({
    QuantScreener? screener,
    SectorMomentum? momentum,
  })  : _screener = screener ?? QuantScreener(),
        _momentum = momentum ?? SectorMomentum();

  final QuantScreener _screener;
  final SectorMomentum _momentum;

  static const sp500Core = [
    'AAPL', 'MSFT', 'AMZN', 'NVDA', 'GOOGL', 'META', 'BRK-B', 'LLY',
    'AVGO', 'JPM', 'TSLA', 'UNH', 'V', 'XOM', 'MA', 'JNJ', 'PG', 'HD',
    'COST', 'ABBV', 'MRK', 'CRM', 'BAC', 'AMD', 'NFLX', 'CVX', 'KO',
    'WMT', 'PEP', 'ADBE', 'TMO', 'CSCO', 'ACN', 'LIN', 'MCD', 'ABT',
    'DHR', 'INTC', 'CMCSA', 'TXN', 'QCOM', 'VZ', 'PM', 'NEE', 'UNP',
    'RTX', 'HON', 'LOW', 'SPGI', 'INTU', 'IBM', 'CAT', 'GS', 'AMAT',
    'DE', 'AXP', 'BKNG', 'SYK', 'MDT', 'GILD', 'BLK', 'TJX', 'VRTX',
    'ADI', 'MMC', 'LRCX', 'REGN', 'CVS', 'AMT', 'PGR', 'CI', 'ISRG',
    'NOW', 'CB', 'ZTS', 'MO', 'SO', 'DUK', 'BSX', 'BDX', 'EOG', 'SLB',
    'CME', 'ITW', 'PNC', 'USB', 'NOC', 'EQIX', 'AON', 'CL', 'CSX',
    'HCA', 'F', 'GM', 'GE', 'BA', 'DIS', 'NKE', 'SBUX', 'PYPL', 'SQ',
  ];

  static const tickerSectorMap = {
    'AAPL': 'XLK', 'MSFT': 'XLK', 'NVDA': 'XLK', 'GOOGL': 'XLC', 'META': 'XLC',
    'AMZN': 'XLY', 'TSLA': 'XLY', 'JPM': 'XLF', 'BAC': 'XLF', 'GS': 'XLF',
    'XOM': 'XLE', 'CVX': 'XLE', 'JNJ': 'XLV', 'UNH': 'XLV', 'LLY': 'XLV',
    'PG': 'XLP', 'KO': 'XLP', 'WMT': 'XLP', 'HD': 'XLY', 'NKE': 'XLY',
    'CAT': 'XLI', 'HON': 'XLI', 'NEE': 'XLU', 'DUK': 'XLU', 'LIN': 'XLB',
    'DIS': 'XLC', 'VZ': 'XLC', 'AMT': 'XLRE', 'EQIX': 'XLRE',
  };

  Future<Map<String, dynamic>> runScreen() async {
    final rankings = await _momentum.getSectorRankings();
    rankings.sort((a, b) =>
        (b['return_1mo'] as num).compareTo(a['return_1mo'] as num));

    final sectors = <Map<String, dynamic>>[];
    for (var i = 0; i < rankings.length && i < 3; i++) {
      final sector = rankings[i];
      final etf = sector['etf'] as String;
      final tickers = tickerSectorMap.entries
          .where((e) => e.value == etf)
          .map((e) => e.key)
          .toList();
      if (tickers.isEmpty) {
        tickers.addAll(sp500Core.take(10));
      }

      final screened = <Map<String, dynamic>>[];
      for (final t in tickers.take(20)) {
        final result = await _screener.screenTicker(t);
        if (result != null && !result.containsKey('error')) {
          screened.add(result);
        }
      }
      screened.sort((a, b) =>
          (b['composite_score'] as int).compareTo(a['composite_score'] as int));

      sectors.add({
        'etf': etf,
        'name': sector['name'],
        'rank': i + 1,
        'return_1mo': sector['return_1mo'],
        'return_1wk': sector['return_1wk'],
        'momentum': sector['momentum'],
        'stocks': screened.take(3).map((s) => {
              'ticker': s['ticker'],
              'score': s['composite_score'],
              'pe_ratio': s['pe_ratio'],
              'pe_vs_sector': s['pe_vs_sector'],
              'signal': s['signal'],
              'price': s['price'],
            }).toList(),
      });
    }

    Map<String, dynamic>? contrarian;
    if (rankings.length >= 11) {
      final worst = rankings.last;
      final etf = worst['etf'] as String;
      final tickers = tickerSectorMap.entries
          .where((e) => e.value == etf)
          .map((e) => e.key)
          .toList();

      Map<String, dynamic>? cheapest;
      for (final t in tickers.take(15)) {
        final result = await _screener.screenTicker(t);
        if (result == null || result.containsKey('error')) continue;
        final score = result['composite_score'] as int? ?? 0;
        final pe = (result['pe_ratio'] as num?)?.toDouble() ?? 0;
        if (score >= 30 && pe > 0) {
          if (cheapest == null ||
              pe < (cheapest['pe_ratio'] as num).toDouble()) {
            cheapest = result;
          }
        }
      }

      if (cheapest != null) {
        contrarian = {
          'etf': etf,
          'name': worst['name'],
          'return_1mo': worst['return_1mo'],
          'stock': {
            'ticker': cheapest['ticker'],
            'score': cheapest['composite_score'],
            'pe_ratio': cheapest['pe_ratio'],
            'signal': cheapest['signal'],
            'price': cheapest['price'],
          },
        };
      }
    }

    return {
      'sectors': sectors,
      'contrarian': contrarian,
      'generated_at': DateTime.now().toIso8601String(),
    };
  }
}
