import '../data/datasources/remote/yahoo_finance_client.dart';

/// Dark pool proxy detector — mirrors News/engine/dark_pool_tracker.py.
class DarkPoolTracker {
  DarkPoolTracker({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  static const volumeSpikeMultiplier = 3.0;
  static const lowMoveThresholdPct = 0.5;
  static const blockTradeThresholdUsd = 5000000.0;

  Future<List<Map<String, dynamic>>> scanTicker(String ticker) async {
    ticker = ticker.toUpperCase();
    final bars = await _yahoo.getOhlcvHistory(ticker, range: '1mo');
    if (bars.length < 5) return [];

    final signals = <Map<String, dynamic>>[];
    final checkDays = bars.length < 10 ? bars.length : 10;
    final startIdx = bars.length - checkDays;

    for (var i = startIdx; i < bars.length; i++) {
      final window = bars.sublist(0, i);
      if (window.length < 5) continue;

      final volumes = window.map((b) => (b['volume'] as num?)?.toDouble() ?? 0).toList();
      final avgVol = volumes.isEmpty
          ? 0
          : volumes.reduce((a, b) => a + b) / volumes.length;
      if (avgVol <= 0) continue;

      final bar = bars[i];
      final vol = (bar['volume'] as num?)?.toDouble() ?? 0;
      final open = (bar['open'] as num).toDouble();
      final close = (bar['close'] as num).toDouble();
      final ratio = vol / avgVol;
      final movePct = open != 0 ? ((close - open) / open).abs() * 100 : 0;
      final estValue = vol * close;

      String? signalType;
      String? description;

      if (ratio >= volumeSpikeMultiplier && movePct < lowMoveThresholdPct) {
        signalType = 'dark_pool_proxy';
        description =
            'High volume (${ratio.toStringAsFixed(1)}x avg) with minimal price move — dark pool proxy';
      } else if (ratio >= volumeSpikeMultiplier) {
        signalType = 'volume_spike';
        description =
            'Volume spike ${ratio.toStringAsFixed(1)}x average with ${movePct.toStringAsFixed(2)}% move';
      }

      if (signalType != null) {
        signals.add({
          'symbol': ticker,
          'signal_date': bar['timestamp']?.toString() ?? '',
          'volume': vol.round(),
          'avg_volume_20d': avgVol.round(),
          'volume_ratio': double.parse(ratio.toStringAsFixed(2)),
          'price_move_pct': double.parse(movePct.toStringAsFixed(2)),
          'estimated_value': estValue,
          'is_large_block': estValue >= blockTradeThresholdUsd,
          'signal_type': signalType,
          'description': description,
          'current_price': close,
        });
      }
    }

    return signals.reversed.toList();
  }

  Future<List<Map<String, dynamic>>> scanBatch(List<String> tickers) async {
    final all = <Map<String, dynamic>>[];
    for (final t in tickers) {
      try {
        final signals = await scanTicker(t);
        if (signals.isNotEmpty) {
          all.add(signals.first);
        }
      } catch (_) {}
    }
    all.sort((a, b) =>
        (b['volume_ratio'] as num).compareTo(a['volume_ratio'] as num));
    return all;
  }
}
