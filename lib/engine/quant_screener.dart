import 'config/engine_config.dart';
import 'math/statistics.dart';
import 'math/technical_indicators.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';

/// Pure math screening — mirrors News/engine/quant_screener.py (Stage 1).
class QuantScreener {
  QuantScreener({YahooFinanceClient? yahooClient})
      : _yahoo = yahooClient ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  final _sectorCache = <String, _SectorCacheEntry>{};
  final _stockCache = <String, _StockCacheEntry>{};

  Map<String, double> _compositeWeights =
      Map<String, double>.from(EngineConfig.quantCompositeWeights);

  static const _cacheDuration = Duration(minutes: 30);
  static const _sectorCacheDuration = Duration(minutes: 60);

  void applyWeightOverrides({double? techWeight, double? momentumWeight}) {
    if (techWeight == null || momentumWeight == null) return;
    final defaults = EngineConfig.quantCompositeWeights;
    final val = defaults['valuation']!;
    final qual = defaults['quality']!;
    final techNew = defaults['technical']! * (techWeight / 0.5);
    final momNew = defaults['momentum']! * (momentumWeight / 0.5);
    final total = val + techNew + momNew + qual;
    _compositeWeights = {
      'valuation': val / total,
      'technical': techNew / total,
      'momentum': momNew / total,
      'quality': qual / total,
    };
  }

  Future<List<Map<String, dynamic>>> screenBatch(
    List<String> tickers, {
    String variant = 'balanced',
    Map<String, double>? regimeWeightAdjustments,
  }) async {
    final benchmark = await _getBenchmarkHistory();
    final results = <Map<String, dynamic>>[];

    for (final ticker in tickers) {
      try {
        final result = await screenTicker(
          ticker,
          benchmarkHist: benchmark,
          variant: variant,
          regimeWeightAdjustments: regimeWeightAdjustments,
        );
        if (result != null && !result.containsKey('error')) {
          results.add(result);
        }
      } catch (_) {}
    }

    results.sort(
      (a, b) => (b['composite_score'] as int).compareTo(a['composite_score'] as int),
    );
    return results;
  }

  Future<Map<String, dynamic>?> screenTicker(
    String ticker, {
    List<Map<String, dynamic>>? benchmarkHist,
    String variant = 'balanced',
    Map<String, double>? regimeWeightAdjustments,
    Map<String, dynamic>? volumeMetrics,
  }) async {
    ticker = ticker.toUpperCase().trim();
    final stockData = await _getStockData(ticker);
    if (stockData == null) {
      return {'ticker': ticker, 'error': 'No data available'};
    }

    final info = stockData['info'] as Map<String, dynamic>;
    final bars = stockData['bars'] as List<OhlcvBar>;
    if (bars.length < 20) {
      return {'ticker': ticker, 'error': 'Insufficient price history'};
    }

    benchmarkHist ??= await _getBenchmarkHistory();
    final closes = bars.map((b) => b.close).toList();

    // Pre-load sector medians for relative valuation
    final sector = info['sector']?.toString() ?? 'Unknown';
    await _getSectorMedians(sector, excludeTicker: ticker);

    final valuation = _relativeValuation(ticker, info);
    final technicals = _technicalIndicators(closes);
    final momentum = _momentumScores(closes, benchmarkHist);
    final quality = _qualityMetrics(info);

    final valScore = _scoreValuation(valuation);
    final techScore = _scoreTechnicals(technicals, volumeMetrics);
    final momScore = _scoreMomentum(momentum);
    final qualScore = _scoreQuality(quality);

    var weights = Map<String, double>.from(_compositeWeights);
    if (regimeWeightAdjustments != null) {
      weights = {
        for (final k in weights.keys)
          k: weights[k]! * (regimeWeightAdjustments[k] ?? 1.0),
      };
      final total = weights.values.reduce((a, b) => a + b);
      weights = {for (final e in weights.entries) e.key: e.value / total};
    }

    var composite = (
      valScore * weights['valuation']! +
      techScore * weights['technical']! +
      momScore * weights['momentum']! +
      qualScore * weights['quality']!
    ).round().clamp(0, 100);

    final anomalies = _anomalyDetection(valuation, technicals, momentum, quality);
    var signal = _determineSignal(composite, anomalies, variant);

    return {
      'ticker': ticker,
      'composite_score': composite,
      'signal': signal,
      'enhanced_signal': signal,
      'scores': {
        'valuation': valScore.round(),
        'technical': techScore.round(),
        'momentum': momScore.round(),
        'quality': qualScore.round(),
      },
      'valuation': valuation,
      'technicals': technicals,
      'momentum': momentum,
      'quality': quality,
      'anomalies': anomalies,
      'score': composite,
      'initial_reason':
          'Quant Score $composite/100: Val=${valScore.round()}, Tech=${techScore.round()}, '
          'Mom=${momScore.round()}, Qual=${qualScore.round()}.',
      'data': {
        'name': info['longName'] ?? info['shortName'] ?? ticker,
        'sector': info['sector'] ?? 'Unknown',
        'industry': info['industry'] ?? 'Unknown',
        'current_price': info['currentPrice'] ?? info['regularMarketPrice'],
        'market_cap': info['marketCap'],
      },
    };
  }

  Future<List<Map<String, dynamic>>?> _getBenchmarkHistory() async {
    return _fetchHistory(EngineConfig.benchmarkTicker);
  }

  Future<Map<String, dynamic>?> _getStockData(String ticker) async {
    final cached = _stockCache[ticker];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheDuration) {
      return cached.data;
    }

    try {
      final info = await _yahoo.getStockInfo(ticker);
      final rawBars = await _yahoo.getOhlcvHistory(ticker, range: '1y');
      final bars = rawBars
          .where((p) => p['close'] != null)
          .map(
            (p) => OhlcvBar(
              open: (p['open'] as num).toDouble(),
              high: (p['high'] as num).toDouble(),
              low: (p['low'] as num).toDouble(),
              close: (p['close'] as num).toDouble(),
              volume: (p['volume'] as num?)?.toDouble() ?? 0,
            ),
          )
          .toList();

      final data = {'info': info, 'bars': bars};
      _stockCache[ticker] = _StockCacheEntry(data: data, timestamp: DateTime.now());
      return data;
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> _fetchHistory(String ticker) async {
    try {
      return await _yahoo.getOhlcvHistory(ticker, range: '1y');
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, double>> _getSectorMedians(
    String sector, {
    String? excludeTicker,
  }) async {
    final cached = _sectorCache[sector];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _sectorCacheDuration) {
      return cached.data;
    }

    final peers = EngineConfig.sectorPeers[sector] ?? [];
    final peValues = <double>[];
    final pbValues = <double>[];

    for (final peer in peers) {
      if (peer == excludeTicker) continue;
      try {
        final info = await _yahoo.getStockInfo(peer);
        final pe = (info['trailingPE'] as num?)?.toDouble();
        final pb = (info['priceToBook'] as num?)?.toDouble();
        if (pe != null && pe > 0 && pe < 500) peValues.add(pe);
        if (pb != null && pb > 0 && pb < 100) pbValues.add(pb);
      } catch (_) {}
    }

    final data = {
      'pe_median': Statistics.median(peValues) ?? 0,
      'pb_median': Statistics.median(pbValues) ?? 0,
      'count': peValues.length.toDouble(),
    };
    _sectorCache[sector] = _SectorCacheEntry(data: data, timestamp: DateTime.now());
    return data;
  }

  Map<String, dynamic> _relativeValuation(String ticker, Map<String, dynamic> info) {
    final sector = info['sector']?.toString() ?? 'Unknown';
    // Sector medians fetched async in full flow — sync fallback uses stored cache
    final sectorMedians = _sectorCache[sector]?.data ??
        <String, double>{'pe_median': 0, 'pb_median': 0};

    final pe = (info['trailingPE'] as num?)?.toDouble();
    final pb = (info['priceToBook'] as num?)?.toDouble();
    var peg = (info['pegRatio'] as num?)?.toDouble();

    if (peg == null && pe != null) {
      final eg = (info['earningsGrowth'] as num?)?.toDouble();
      if (eg != null && eg > 0) {
        peg = pe / (eg * 100);
      }
    }

    final peMedian = sectorMedians['pe_median'] ?? 0.0;
    final pbMedian = sectorMedians['pb_median'] ?? 0.0;

    return {
      'pe_ratio': pe != null ? double.parse(pe.toStringAsFixed(2)) : null,
      'pe_vs_sector': pe != null && peMedian > 0
          ? double.parse((pe / peMedian).toStringAsFixed(2))
          : null,
      'pb_ratio': pb != null ? double.parse(pb.toStringAsFixed(2)) : null,
      'pb_vs_sector': pb != null && pbMedian > 0
          ? double.parse((pb / pbMedian).toStringAsFixed(2))
          : null,
      'peg_ratio': peg != null ? double.parse(peg.toStringAsFixed(2)) : null,
      'sector': sector,
    };
  }

  Map<String, dynamic> _technicalIndicators(List<double> closes) {
    final rsi = TechnicalIndicators.computeRsi(closes);
    final sma50 = TechnicalIndicators.sma(closes, 50);
    final sma200 = TechnicalIndicators.sma(closes, 200);
    final smaCross = TechnicalIndicators.computeSmaCrossSignal(closes);
    final priceVs52w = TechnicalIndicators.priceVs52WeekRange(closes);
    final bollinger = TechnicalIndicators.computeBollingerPosition(closes);

    return {
      'rsi_14': rsi != null ? double.parse(rsi.toStringAsFixed(1)) : null,
      'sma_50': sma50 != null ? double.parse(sma50.toStringAsFixed(2)) : null,
      'sma_200': sma200 != null ? double.parse(sma200.toStringAsFixed(2)) : null,
      'sma_cross_signal': smaCross,
      'price_vs_52w_range': double.parse(priceVs52w.toStringAsFixed(3)),
      'bollinger_position': double.parse(bollinger.toStringAsFixed(3)),
      'current_price': double.parse(closes.last.toStringAsFixed(2)),
    };
  }

  Map<String, dynamic> _momentumScores(
    List<double> closes,
    List<Map<String, dynamic>>? benchmarkHist,
  ) {
    double? pctReturn(int days) {
      if (closes.length < days) return null;
      final past = closes[closes.length - days];
      if (past == 0) return null;
      return double.parse(
        (((closes.last - past) / past) * 100).toStringAsFixed(2),
      );
    }

    final ret1m = pctReturn(21);
    final ret3m = pctReturn(63);
    final ret6m = pctReturn(126);

    double? excess1m, excess3m, excess6m;
    if (benchmarkHist != null && benchmarkHist.isNotEmpty) {
      final benchCloses = benchmarkHist
          .where((p) => p['close'] != null)
          .map((p) => (p['close'] as num).toDouble())
          .toList();

      double? benchReturn(int days) {
        if (benchCloses.length < days) return null;
        final past = benchCloses[benchCloses.length - days];
        if (past == 0) return null;
        return ((benchCloses.last - past) / past) * 100;
      }

      final b1 = benchReturn(21);
      final b3 = benchReturn(63);
      final b6 = benchReturn(126);
      if (ret1m != null && b1 != null) excess1m = double.parse((ret1m - b1).toStringAsFixed(2));
      if (ret3m != null && b3 != null) excess3m = double.parse((ret3m - b3).toStringAsFixed(2));
      if (ret6m != null && b6 != null) excess6m = double.parse((ret6m - b6).toStringAsFixed(2));
    }

    return {
      'return_1m': ret1m,
      'return_3m': ret3m,
      'return_6m': ret6m,
      'excess_1m': excess1m,
      'excess_3m': excess3m,
      'excess_6m': excess6m,
    };
  }

  Map<String, dynamic> _qualityMetrics(Map<String, dynamic> info) {
    final de = (info['debtToEquity'] as num?)?.toDouble();
    final cr = (info['currentRatio'] as num?)?.toDouble();
    final roeRaw = (info['returnOnEquity'] as num?)?.toDouble();
    final fcf = (info['freeCashflow'] as num?)?.toDouble();
    final mcap = (info['marketCap'] as num?)?.toDouble();

    double? fcfYield;
    if (fcf != null && mcap != null && mcap > 0) {
      fcfYield = double.parse(((fcf / mcap) * 100).toStringAsFixed(2));
    }

    return {
      'debt_to_equity': de != null ? double.parse(de.toStringAsFixed(2)) : null,
      'current_ratio': cr != null ? double.parse(cr.toStringAsFixed(2)) : null,
      'roe': roeRaw != null ? double.parse((roeRaw * 100).toStringAsFixed(2)) : null,
      'fcf_yield': fcfYield,
    };
  }

  double _scoreValuation(Map<String, dynamic> val) {
    final scores = <double>[];

    final peVs = val['pe_vs_sector'] as double?;
    if (peVs != null) {
      if (peVs <= 0.5) {
        scores.add(95);
      } else if (peVs <= 0.8) {
        scores.add(80);
      } else if (peVs <= 1.0) {
        scores.add(60);
      } else if (peVs <= 1.3) {
        scores.add(40);
      } else if (peVs <= 1.8) {
        scores.add(25);
      } else {
        scores.add(10);
      }
    }

    final peg = val['peg_ratio'] as double?;
    if (peg != null) {
      if (peg < 0) {
        scores.add(20);
      } else if (peg <= 0.5) {
        scores.add(95);
      } else if (peg <= 1.0) {
        scores.add(75);
      } else if (peg <= 1.5) {
        scores.add(55);
      } else if (peg <= 2.0) {
        scores.add(35);
      } else {
        scores.add(15);
      }
    }

    final pbVs = val['pb_vs_sector'] as double?;
    if (pbVs != null) {
      if (pbVs <= 0.5) {
        scores.add(90);
      } else if (pbVs <= 0.8) {
        scores.add(75);
      } else if (pbVs <= 1.2) {
        scores.add(55);
      } else if (pbVs <= 2.0) {
        scores.add(30);
      } else {
        scores.add(10);
      }
    }

    if (scores.isEmpty) return 50;
    return scores.reduce((a, b) => a + b) / scores.length;
  }

  double _scoreTechnicals(Map<String, dynamic> tech, Map<String, dynamic>? volume) {
    final scores = <double>[];

    final rsi = tech['rsi_14'] as double?;
    if (rsi != null) {
      if (rsi >= 40 && rsi <= 60) {
        scores.add(70);
      } else if (rsi >= 30 && rsi < 40) {
        scores.add(80);
      } else if (rsi < 30) {
        scores.add(85);
      } else if (rsi > 60 && rsi <= 70) {
        scores.add(55);
      } else {
        scores.add(25);
      }
    }

    const crossScores = {
      'golden_cross': 90.0,
      'bullish': 70.0,
      'neutral': 50.0,
      'bearish': 30.0,
      'death_cross': 15.0,
    };
    scores.add(crossScores[tech['sma_cross_signal']] ?? 50);

    final pos = tech['price_vs_52w_range'] as double? ?? 0.5;
    if (pos <= 0.2) {
      scores.add(85);
    } else if (pos <= 0.4) {
      scores.add(70);
    } else if (pos <= 0.6) {
      scores.add(55);
    } else if (pos <= 0.8) {
      scores.add(40);
    } else {
      scores.add(20);
    }

    final bb = tech['bollinger_position'] as double? ?? 0;
    if (bb <= -0.8) {
      scores.add(85);
    } else if (bb <= -0.3) {
      scores.add(70);
    } else if (bb <= 0.3) {
      scores.add(55);
    } else if (bb <= 0.8) {
      scores.add(35);
    } else {
      scores.add(15);
    }

    var base = scores.reduce((a, b) => a + b) / scores.length;

    final volRatio = (volume?['volume_ratio'] as num?)?.toDouble() ?? 1.0;
    if (volRatio >= 2.0) {
      final volConf = volume?['volume_confirmation']?.toString() ?? 'neutral';
      if (volConf == 'strong_bullish' && base >= 55) {
        base = (base + 10).clamp(0, 100);
      } else if (volConf == 'strong_bearish' && base <= 45) {
        base = (base - 10).clamp(0, 100);
      }
    }

    return base;
  }

  double _scoreMomentum(Map<String, dynamic> mom) {
    final scores = <double>[];

    for (final key in ['excess_1m', 'excess_3m', 'excess_6m']) {
      final excess = mom[key] as double?;
      if (excess == null) continue;
      if (excess > 10) {
        scores.add(90);
      } else if (excess > 5) {
        scores.add(75);
      } else if (excess > 0) {
        scores.add(60);
      } else if (excess > -5) {
        scores.add(40);
      } else if (excess > -10) {
        scores.add(25);
      } else {
        scores.add(10);
      }
    }

    final r1 = mom['return_1m'] as double?;
    final r3 = mom['return_3m'] as double?;
    if (r1 != null && r3 != null) {
      final monthlyAvg = r3 / 3;
      if (r1 > monthlyAvg && r1 > 0) {
        scores.add(75);
      } else if (r1 < monthlyAvg && r1 < 0) {
        scores.add(25);
      } else {
        scores.add(50);
      }
    }

    if (scores.isEmpty) return 50;
    return scores.reduce((a, b) => a + b) / scores.length;
  }

  double _scoreQuality(Map<String, dynamic> qual) {
    final scores = <double>[];

    final de = qual['debt_to_equity'] as double?;
    if (de != null) {
      if (de < 30) {
        scores.add(90);
      } else if (de < 80) {
        scores.add(70);
      } else if (de < 150) {
        scores.add(50);
      } else if (de < 300) {
        scores.add(30);
      } else {
        scores.add(10);
      }
    }

    final cr = qual['current_ratio'] as double?;
    if (cr != null) {
      if (cr >= 2.0) {
        scores.add(85);
      } else if (cr >= 1.5) {
        scores.add(70);
      } else if (cr >= 1.0) {
        scores.add(50);
      } else if (cr >= 0.5) {
        scores.add(30);
      } else {
        scores.add(10);
      }
    }

    final roe = qual['roe'] as double?;
    if (roe != null) {
      if (roe >= 15 && roe <= 40) {
        scores.add(85);
      } else if (roe >= 10) {
        scores.add(65);
      } else if (roe >= 5) {
        scores.add(45);
      } else if (roe > 40) {
        scores.add(60);
      } else if (roe < 0) {
        scores.add(15);
      } else {
        scores.add(30);
      }
    }

    final fcf = qual['fcf_yield'] as double?;
    if (fcf != null) {
      if (fcf > 8) {
        scores.add(90);
      } else if (fcf > 5) {
        scores.add(75);
      } else if (fcf > 2) {
        scores.add(55);
      } else if (fcf > 0) {
        scores.add(40);
      } else {
        scores.add(15);
      }
    }

    if (scores.isEmpty) return 50;
    return scores.reduce((a, b) => a + b) / scores.length;
  }

  List<Map<String, dynamic>> _anomalyDetection(
    Map<String, dynamic> valuation,
    Map<String, dynamic> technicals,
    Map<String, dynamic> momentum,
    Map<String, dynamic> quality,
  ) {
    final anomalies = <Map<String, dynamic>>[];

    final peVs = valuation['pe_vs_sector'] as double?;
    if (peVs != null && peVs < 0.5) {
      anomalies.add({
        'metric': 'P/E vs Sector',
        'value': peVs,
        'direction': 'positive',
        'description':
            'Trading at ${peVs}x sector P/E median (significantly undervalued)',
      });
    } else if (peVs != null && peVs > 2.0) {
      anomalies.add({
        'metric': 'P/E vs Sector',
        'value': peVs,
        'direction': 'negative',
        'description':
            'Trading at ${peVs}x sector P/E median (significantly overvalued)',
      });
    }

    final rsi = technicals['rsi_14'] as double?;
    if (rsi != null && rsi < 25) {
      anomalies.add({
        'metric': 'RSI(14)',
        'value': rsi,
        'direction': 'positive',
        'description': 'RSI at $rsi — deeply oversold',
      });
    } else if (rsi != null && rsi > 80) {
      anomalies.add({
        'metric': 'RSI(14)',
        'value': rsi,
        'direction': 'negative',
        'description': 'RSI at $rsi — heavily overbought',
      });
    }

    final cross = technicals['sma_cross_signal']?.toString();
    if (cross == 'golden_cross') {
      anomalies.add({
        'metric': 'SMA Crossover',
        'value': 'golden_cross',
        'direction': 'positive',
        'description': 'SMA50 just crossed above SMA200 (Golden Cross)',
      });
    } else if (cross == 'death_cross') {
      anomalies.add({
        'metric': 'SMA Crossover',
        'value': 'death_cross',
        'direction': 'negative',
        'description': 'SMA50 just crossed below SMA200 (Death Cross)',
      });
    }

    final de = quality['debt_to_equity'] as double?;
    if (de != null && de > 300) {
      anomalies.add({
        'metric': 'Debt/Equity',
        'value': de,
        'direction': 'negative',
        'description': 'D/E ratio of $de — dangerously high leverage',
      });
    }

    final fcf = quality['fcf_yield'] as double?;
    if (fcf != null && fcf < -5) {
      anomalies.add({
        'metric': 'FCF Yield',
        'value': fcf,
        'direction': 'negative',
        'description': 'Negative FCF yield of $fcf% — burning cash',
      });
    }

    return anomalies;
  }

  String _determineSignal(
    int composite,
    List<Map<String, dynamic>> anomalies,
    String variant,
  ) {
    var oppThreshold = EngineConfig.opportunityThreshold;
    var cautThreshold = EngineConfig.cautionThreshold;

    if (variant == 'aggressive') {
      oppThreshold -= 10;
      cautThreshold -= 5;
    } else if (variant == 'conservative') {
      oppThreshold += 5;
      cautThreshold += 5;
    }

    final positive =
        anomalies.where((a) => a['direction'] == 'positive').toList();
    final negative =
        anomalies.where((a) => a['direction'] == 'negative').toList();

    final criticalNeg = negative
        .where((a) => a['metric'] == 'Debt/Equity' || a['metric'] == 'FCF Yield')
        .toList();
    if (criticalNeg.isNotEmpty) return 'Caution';

    if (composite >= oppThreshold && positive.isNotEmpty) return 'Opportunity';
    if (composite <= cautThreshold || negative.length >= 2) return 'Caution';
    return 'Neutral';
  }
}

class _StockCacheEntry {
  _StockCacheEntry({required this.data, required this.timestamp});
  final Map<String, dynamic> data;
  final DateTime timestamp;
}

class _SectorCacheEntry {
  _SectorCacheEntry({required this.data, required this.timestamp});
  final Map<String, double> data;
  final DateTime timestamp;
}
