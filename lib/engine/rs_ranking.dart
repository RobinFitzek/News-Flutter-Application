import '../data/datasources/remote/yahoo_finance_client.dart';

/// Relative strength ranking — mirrors News/engine/rs_ranking.py.
class RsRanking {
  RsRanking({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  Future<List<Map<String, dynamic>>> rankSymbols(List<String> symbols) async {
    final spyBars = await _yahoo.getOhlcvHistory('SPY', range: '6mo');
    if (spyBars.length < 20) return [];

    final spyStart = (spyBars.first['close'] as num).toDouble();
    final spyEnd = (spyBars.last['close'] as num).toDouble();
    final spyReturn =
        spyStart > 0 ? ((spyEnd - spyStart) / spyStart) * 100 : 0.0;

    final ranked = <Map<String, dynamic>>[];
    for (final symbol in symbols) {
      try {
        final bars = await _yahoo.getOhlcvHistory(symbol, range: '6mo');
        if (bars.length < 20) continue;
        final start = (bars.first['close'] as num).toDouble();
        final end = (bars.last['close'] as num).toDouble();
        if (start <= 0) continue;
        final ret = ((end - start) / start) * 100;
        final rs = ret - spyReturn;
        ranked.add({
          'symbol': symbol.toUpperCase(),
          'return_6m': double.parse(ret.toStringAsFixed(2)),
          'spy_return_6m': double.parse(spyReturn.toStringAsFixed(2)),
          'relative_strength': double.parse(rs.toStringAsFixed(2)),
          'outperforming': rs > 0,
        });
      } catch (_) {
        continue;
      }
    }

    ranked.sort((a, b) => (b['relative_strength'] as double)
        .compareTo(a['relative_strength'] as double));
    for (var i = 0; i < ranked.length; i++) {
      ranked[i]['rank'] = i + 1;
    }
    return ranked;
  }
}
