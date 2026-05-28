import '../data/datasources/remote/yahoo_finance_client.dart';
import '../data/database/app_database.dart';

/// Portfolio vs SPY benchmark — mirrors portfolio_benchmark.py.
class PortfolioBenchmark {
  PortfolioBenchmark({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;
  Map<String, dynamic>? _cache;
  DateTime? _cacheTime;
  static const _cacheDuration = Duration(minutes: 30);

  Future<Map<String, dynamic>> calculate({
    required List<PositionData> positions,
    List<PaperTradeData> paperTrades = const [],
    int chartDays = 90,
  }) async {
    if (_cache != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheDuration) {
      return _cache!;
    }

    if (positions.isEmpty && paperTrades.isEmpty) {
      return {
        'portfolio_return_pct': 0.0,
        'spy_return_pct': 0.0,
        'alpha': 0.0,
        'portfolio_value': 0.0,
        'message': 'No holdings to benchmark',
        'labels': <String>[],
        'portfolio_series': <double>[],
        'spy_series': <double>[],
      };
    }

    double portfolioValue = 0;
    double totalInvested = 0;
    final lots = <_Lot>[];

    for (final p in positions) {
      if (p.shares <= 0) continue;
      final cost = p.shares * p.avgCostBasis;
      final value = p.shares * p.currentPrice;
      portfolioValue += value;
      totalInvested += cost;
      lots.add(_Lot(
        symbol: p.symbol,
        invested: cost,
        acquiredAt: p.acquiredAt,
        weight: value,
      ));
    }

    for (final t in paperTrades.where((t) => t.type == 'BUY' && t.status == 'OPEN')) {
      final cost = t.shares * t.price;
      portfolioValue += cost;
      totalInvested += cost;
      lots.add(_Lot(
        symbol: t.symbol,
        invested: cost,
        acquiredAt: t.executedAt,
        weight: cost,
      ));
    }

    if (totalInvested <= 0) {
      return {
        'portfolio_return_pct': 0.0,
        'spy_return_pct': 0.0,
        'alpha': 0.0,
        'portfolio_value': portfolioValue,
        'message': 'No invested capital',
        'labels': <String>[],
        'portfolio_series': <double>[],
        'spy_series': <double>[],
      };
    }

    final portfolioReturnPct =
        ((portfolioValue - totalInvested) / totalInvested) * 100;

    final spyBenchmark = await _spyBuyAndHoldEquivalent(lots);
    final spyReturnPct = spyBenchmark['return_pct'] as double;
    final alpha = portfolioReturnPct - spyReturnPct;

    final chart = await _buildChartSeries(lots, chartDays);

    final result = {
      'portfolio_value': double.parse(portfolioValue.toStringAsFixed(2)),
      'total_invested': double.parse(totalInvested.toStringAsFixed(2)),
      'portfolio_return_pct':
          double.parse(portfolioReturnPct.toStringAsFixed(2)),
      'spy_return_pct': double.parse(spyReturnPct.toStringAsFixed(2)),
      'alpha': double.parse(alpha.toStringAsFixed(2)),
      'spy_equivalent_value': spyBenchmark['value'],
      'labels': chart['labels'],
      'portfolio_series': chart['portfolio_series'],
      'spy_series': chart['spy_series'],
      'updated_at': DateTime.now().toIso8601String(),
    };

    _cache = result;
    _cacheTime = DateTime.now();
    return result;
  }

  Future<Map<String, dynamic>> _spyBuyAndHoldEquivalent(List<_Lot> lots) async {
    final spyBars = await _yahoo.getOhlcvHistory('SPY', range: '5y');
    if (spyBars.isEmpty) {
      return {'value': 0.0, 'return_pct': 0.0, 'invested': 0.0};
    }

    final spyCurrent = (spyBars.last['close'] as num).toDouble();
    var spyValue = 0.0;
    var spyInvested = 0.0;

    for (final lot in lots) {
      final priceThen = _priceNearDate(spyBars, lot.acquiredAt);
      if (priceThen == null || priceThen <= 0) continue;
      final shares = lot.invested / priceThen;
      spyValue += shares * spyCurrent;
      spyInvested += lot.invested;
    }

    final ret = spyInvested > 0 ? ((spyValue - spyInvested) / spyInvested) * 100 : 0.0;
    return {
      'value': double.parse(spyValue.toStringAsFixed(2)),
      'return_pct': double.parse(ret.toStringAsFixed(2)),
      'invested': spyInvested,
    };
  }

  Future<Map<String, dynamic>> _buildChartSeries(
    List<_Lot> lots,
    int days,
  ) async {
    final spyBars = await _yahoo.getOhlcvHistory('SPY', range: '6mo');
    if (spyBars.length < 10) {
      return {'labels': <String>[], 'portfolio_series': <double>[], 'spy_series': <double>[]};
    }

    final trimmed = spyBars.length > days ? spyBars.sublist(spyBars.length - days) : spyBars;
    final spyCloses = trimmed.map((b) => (b['close'] as num).toDouble()).toList();
    final spyStart = spyCloses.first;
    final spySeries = spyCloses.map((c) => (c / spyStart) * 100).toList();

    final symbols = lots.map((l) => l.symbol).toSet();
    final symbolSeries = <String, List<double>>{};
    final totalWeight = lots.fold<double>(0, (s, l) => s + l.weight);

    for (final sym in symbols) {
      try {
        final bars = await _yahoo.getOhlcvHistory(sym, range: '6mo');
        if (bars.length < 5) continue;
        final symTrimmed =
            bars.length > days ? bars.sublist(bars.length - days) : bars;
        if (symTrimmed.length != trimmed.length) {
          final closes = symTrimmed.map((b) => (b['close'] as num).toDouble()).toList();
          final start = closes.first;
          symbolSeries[sym] = closes.map((c) => (c / start) * 100).toList();
        } else {
          final closes = symTrimmed.map((b) => (b['close'] as num).toDouble()).toList();
          final start = closes.first;
          symbolSeries[sym] = closes.map((c) => (c / start) * 100).toList();
        }
      } catch (_) {}
    }

    final portfolioSeries = <double>[];
    final len = spySeries.length;
    for (var i = 0; i < len; i++) {
      var weighted = 0.0;
      var weightSum = 0.0;
      for (final lot in lots) {
        final series = symbolSeries[lot.symbol];
        if (series == null || i >= series.length) continue;
        final w = lot.weight / (totalWeight > 0 ? totalWeight : 1);
        weighted += series[i] * w;
        weightSum += w;
      }
      portfolioSeries.add(weightSum > 0 ? weighted / weightSum : spySeries[i]);
    }

    final labels = trimmed
        .map((b) => DateTime.parse(b['timestamp'] as String))
        .map((d) => '${d.month}/${d.day}')
        .toList();

    return {
      'labels': labels,
      'portfolio_series': portfolioSeries,
      'spy_series': spySeries,
    };
  }

  double? _priceNearDate(List<Map<String, dynamic>> bars, DateTime target) {
    Map<String, dynamic>? closest;
    var minDiff = 999999;
    for (final bar in bars) {
      final ts = DateTime.tryParse(bar['timestamp']?.toString() ?? '');
      if (ts == null) continue;
      final diff = ts.difference(target).inDays.abs();
      if (diff < minDiff) {
        minDiff = diff;
        closest = bar;
      }
    }
    return closest != null ? (closest['close'] as num).toDouble() : null;
  }
}

class _Lot {
  const _Lot({
    required this.symbol,
    required this.invested,
    required this.acquiredAt,
    required this.weight,
  });
  final String symbol;
  final double invested;
  final DateTime acquiredAt;
  final double weight;
}
