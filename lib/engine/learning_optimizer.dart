import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import 'config/engine_config.dart';
import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Self-learning feedback tracker — mirrors News/engine/learning_optimizer.py.
class LearningOptimizer {
  LearningOptimizer(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  static const verificationWindows = {
    'momentum': 20,
    'value': 180,
    'default': 60,
  };

  String classifySignalType({
    int confidence = 50,
    String signal = '',
    int? momentumScore,
    int? valuationScore,
  }) {
    if (momentumScore != null && momentumScore > 70) return 'momentum';
    if (valuationScore != null && valuationScore > 70) return 'value';
    return 'default';
  }

  String _predictedDirection(String signal) {
    if (signal == 'Opportunity' || signal.contains('Buy')) return 'up';
    if (signal == 'Caution' || signal.contains('Sell')) return 'down';
    return 'neutral';
  }

  Future<int> recordPrediction({
    required String symbol,
    required String signal,
    required int confidence,
    required double currentPrice,
    int? momentumScore,
    int? valuationScore,
    int? analysisId,
  }) async {
    final signalType = classifySignalType(
      confidence: confidence,
      signal: signal,
      momentumScore: momentumScore,
      valuationScore: valuationScore,
    );
    final windowDays = verificationWindows[signalType] ?? 60;

    return _db.into(_db.predictionOutcomes).insert(
          PredictionOutcomesCompanion.insert(
            symbol: symbol.toUpperCase(),
            signal: signal,
            predictedDirection: Value(_predictedDirection(signal)),
            confidence: Value(confidence),
            actualPriceAtPrediction: currentPrice,
            signalType: Value(signalType),
            verificationWindowDays: Value(windowDays),
            analysisId: Value(analysisId),
          ),
        );
  }

  Future<List<Map<String, dynamic>>> verifyPredictions() async {
    final unverified = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNull()))
        .get();

    final verified = <Map<String, dynamic>>[];
    for (final pred in unverified) {
      final window = pred.verificationWindowDays;
      final age = DateTime.now().difference(pred.predictionDate).inDays;
      if (age < window) continue;

      final result = await _verifySingle(pred, window);
      if (result != null) verified.add(result);
    }
    return verified;
  }

  Future<Map<String, dynamic>?> _verifySingle(
    PredictionOutcomeData pred,
    int days,
  ) async {
    try {
      final bars = await _yahoo.getOhlcvHistory(
        pred.symbol,
        range: '${days + 10}d',
      );
      if (bars.isEmpty) {
        await (_db.update(_db.predictionOutcomes)
              ..where((t) => t.id.equals(pred.id)))
            .write(PredictionOutcomesCompanion(
          accuracyScore: const Value(0),
          verifiedAt: Value(DateTime.now()),
          daysElapsed: Value(days),
        ));
        await _db.into(_db.tickerGraveyard).insertOnConflictUpdate(
              TickerGraveyardCompanion.insert(
                ticker: pred.symbol,
                reason: 'No data from yfinance (possible delisting)',
                lastSeen: Value(DateTime.now().toIso8601String().split('T').first),
              ),
            );
        return {'ticker': pred.symbol, 'graveyard': true};
      }

      final currentPrice = (bars.last['close'] as num).toDouble();
      final startPrice = pred.actualPriceAtPrediction;
      final priceChange =
          startPrice > 0 ? ((currentPrice - startPrice) / startPrice) * 100 : 0;

      String actualDirection = 'neutral';
      if (priceChange > 2) {
        actualDirection = 'up';
      } else if (priceChange < -2) {
        actualDirection = 'down';
      }

      double accuracyScore = 0.5;
      if (pred.predictedDirection == actualDirection) {
        accuracyScore = 1.0;
      } else if (pred.predictedDirection == 'neutral' ||
          actualDirection == 'neutral') {
        accuracyScore = 0.5;
      } else {
        accuracyScore = 0.0;
      }

      double? benchmarkReturn;
      bool? beatBenchmark;
      try {
        final spyBars = await _yahoo.getOhlcvHistory('SPY', range: '${days + 10}d');
        if (spyBars.length >= 2) {
          final spyStart = (spyBars.first['close'] as num).toDouble();
          final spyEnd = (spyBars.last['close'] as num).toDouble();
          if (spyStart > 0) {
            benchmarkReturn = ((spyEnd - spyStart) / spyStart) * 100;
            beatBenchmark = priceChange > benchmarkReturn;
          }
        }
      } catch (_) {}

      await (_db.update(_db.predictionOutcomes)
            ..where((t) => t.id.equals(pred.id)))
          .write(PredictionOutcomesCompanion(
        actualPriceAfter: Value(currentPrice),
        actualDirection: Value(actualDirection),
        accuracyScore: Value(accuracyScore),
        daysElapsed: Value(days),
        verifiedAt: Value(DateTime.now()),
        benchmarkReturn: Value(benchmarkReturn),
        beatBenchmark: Value(beatBenchmark),
      ));

      return {
        'ticker': pred.symbol,
        'predicted': pred.predictedDirection,
        'actual': actualDirection,
        'accuracy': accuracyScore,
        'price_change': double.parse(priceChange.toStringAsFixed(2)),
        'benchmark_return': benchmarkReturn,
        'beat_benchmark': beatBenchmark,
      };
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getLearningStats() async {
    final verified = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNotNull()))
        .get();

    if (verified.isEmpty) {
      return {
        'total_verified': 0,
        'avg_accuracy': 0.5,
        'avg_confidence': 50.0,
        'correct_predictions': 0,
        'wrong_predictions': 0,
        'hit_rate': 0.0,
        'benchmark_beat_rate': 0.0,
        'pending_verification': await _countPending(),
        'message': 'Keine verifizierten Vorhersagen',
      };
    }

    final total = verified.length;
    final avgAccuracy =
        verified.fold<double>(0, (s, p) => s + (p.accuracyScore ?? 0.5)) / total;
    final avgConfidence =
        verified.fold<double>(0, (s, p) => s + p.confidence) / total;
    final correct = verified.where((p) => (p.accuracyScore ?? 0) >= 0.9).length;
    final wrong = verified.where((p) => (p.accuracyScore ?? 0) <= 0.1).length;
    final withBench = verified.where((p) => p.beatBenchmark != null).toList();
    final beatCount = withBench.where((p) => p.beatBenchmark == true).length;

    return {
      'total_verified': total,
      'avg_accuracy': double.parse(avgAccuracy.toStringAsFixed(3)),
      'avg_confidence': double.parse(avgConfidence.toStringAsFixed(1)),
      'correct_predictions': correct,
      'wrong_predictions': wrong,
      'hit_rate': double.parse((correct / total * 100).toStringAsFixed(1)),
      'benchmark_beat_rate': withBench.isEmpty
          ? 0.0
          : double.parse((beatCount / withBench.length * 100).toStringAsFixed(1)),
      'pending_verification': await _countPending(),
    };
  }

  Future<int> _countPending() async {
    final pending = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNull()))
        .get();
    return pending.length;
  }

  Future<bool> isAccuracyKillSwitchActive() async {
    final stats = await getLearningStats();
    return stats['total_verified'] as int >= 20 &&
        (stats['avg_accuracy'] as double) < 0.50;
  }

  Future<Map<String, dynamic>> calculateOptimalWeights() async {
    final verified = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.verifiedAt)])
          ..limit(100))
        .get();

    if (verified.length < 20) {
      return {
        'sufficient_data': false,
        'prediction_count': verified.length,
        'message': 'Need 20+ verified predictions, have ${verified.length}',
      };
    }

    final typeStats = <String, Map<String, num>>{};
    for (final p in verified) {
      final st = p.signalType;
      typeStats.putIfAbsent(st, () => {'total': 0, 'correct': 0});
      typeStats[st]!['total'] = (typeStats[st]!['total'] as int) + 1;
      if ((p.accuracyScore ?? 0) >= 0.5) {
        typeStats[st]!['correct'] = (typeStats[st]!['correct'] as int) + 1;
      }
    }

    for (final st in typeStats.values) {
      final total = st['total'] as int;
      st['accuracy'] = total > 0 ? (st['correct'] as int) / total : 0.5;
    }

    final current = Map<String, double>.from(EngineConfig.quantCompositeWeights);
    final suggested = Map<String, double>.from(current);

    final momAcc = (typeStats['momentum']?['accuracy'] as num?)?.toDouble() ?? 0.5;
    final valAcc = (typeStats['value']?['accuracy'] as num?)?.toDouble() ?? 0.5;
    final defAcc = (typeStats['default']?['accuracy'] as num?)?.toDouble() ?? 0.5;

    if (momAcc > defAcc + 0.1) {
      suggested['momentum'] = (current['momentum']! + 0.05).clamp(0.1, 0.45);
      suggested['technical'] = (current['technical']! + 0.05).clamp(0.1, 0.45);
    }
    if (valAcc > defAcc + 0.1) {
      suggested['valuation'] = (current['valuation']! + 0.05).clamp(0.1, 0.45);
      suggested['quality'] = (current['quality']! + 0.03).clamp(0.1, 0.45);
    }

    final total = suggested.values.reduce((a, b) => a + b);
    suggested.updateAll((k, v) => double.parse((v / total).toStringAsFixed(4)));

    return {
      'sufficient_data': true,
      'prediction_count': verified.length,
      'current_weights': current,
      'suggested_weights': suggested,
      'factor_accuracy': typeStats,
    };
  }

  Future<Map<String, dynamic>> calculateCalibration() async {
    final verified = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNotNull())
          ..where((t) => t.accuracyScore.isNotNull()))
        .get();

    if (verified.length < 5) {
      return {
        'sufficient_data': false,
        'total': verified.length,
        'message': 'Need at least 5 verified predictions',
      };
    }

    const bucketRanges = [
      (0, 40, '0-40'),
      (40, 50, '40-50'),
      (50, 60, '50-60'),
      (60, 70, '60-70'),
      (70, 80, '70-80'),
      (80, 90, '80-90'),
      (90, 101, '90-100'),
    ];

    final buckets = <Map<String, dynamic>>[];
    var brierSum = 0.0;

    for (final (low, high, label) in bucketRanges) {
      final inBucket =
          verified.where((p) => p.confidence >= low && p.confidence < high);
      if (inBucket.isEmpty) continue;
      final count = inBucket.length;
      final midpoint = (low + min(high, 100)) / 2 / 100;
      final actualAccuracy =
          inBucket.fold<double>(0, (s, p) => s + (p.accuracyScore ?? 0)) /
              count;
      final hitRate = inBucket
              .where((p) => (p.accuracyScore ?? 0) >= 0.5)
              .length /
          count;

      buckets.add({
        'range': label,
        'count': count,
        'predicted_accuracy': double.parse(midpoint.toStringAsFixed(3)),
        'actual_accuracy': double.parse(actualAccuracy.toStringAsFixed(3)),
        'hit_rate': double.parse((hitRate * 100).toStringAsFixed(1)),
        'gap': double.parse(
            ((actualAccuracy - midpoint) * 100).toStringAsFixed(1)),
      });
    }

    for (final p in verified) {
      final forecast = p.confidence / 100;
      brierSum += pow(forecast - (p.accuracyScore ?? 0), 2);
    }
    final brierScore =
        double.parse((brierSum / verified.length).toStringAsFixed(4));

    final calibrationError = buckets.isEmpty
        ? 0.0
        : buckets
                .map((b) =>
                    ((b['actual_accuracy'] as double) -
                            (b['predicted_accuracy'] as double))
                        .abs())
                .reduce((a, b) => a + b) /
            buckets.length *
            100;

    String interpretation;
    if (brierScore < 0.15) {
      interpretation = 'Well-calibrated. Confidence scores are meaningful.';
    } else if (brierScore < 0.25) {
      interpretation =
          'Moderately calibrated. Some over/under-confidence.';
    } else {
      interpretation = 'Poorly calibrated. Confidence scores unreliable.';
    }

    return {
      'sufficient_data': true,
      'total': verified.length,
      'buckets': buckets,
      'brier_score': brierScore,
      'calibration_error':
          double.parse(calibrationError.toStringAsFixed(1)),
      'interpretation': interpretation,
    };
  }

  Future<Map<String, dynamic>> calculateSignalDecay() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 180));
    final predictions = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.actualPriceAtPrediction.isBiggerThanValue(0))
          ..where((t) => t.predictionDate.isBiggerOrEqualValue(cutoff)))
        .get();

    if (predictions.length < 5) {
      return {
        'sufficient_data': false,
        'total': predictions.length,
        'message': 'Need at least 5 predictions with price data',
      };
    }

    const windows = [1, 3, 7, 14, 30];
    final windowResults = {
      for (final w in windows) w: {'hits': 0.0, 'total': 0, 'returns': <double>[]}
    };

    final bySymbol = <String, List<PredictionOutcomeData>>{};
    for (final p in predictions) {
      bySymbol.putIfAbsent(p.symbol, () => []).add(p);
    }

    for (final entry in bySymbol.entries) {
      try {
        final bars =
            await _yahoo.getOhlcvHistory(entry.key, range: '8mo');
        if (bars.length < 5) continue;

        for (final pred in entry.value) {
          final entryPrice = pred.actualPriceAtPrediction;
          if (entryPrice <= 0) continue;

          for (final w in windows) {
            final target = pred.predictionDate.add(Duration(days: w));
            double? futurePrice;
            for (final bar in bars) {
              final ts = bar['timestamp'] as DateTime? ??
                  DateTime.tryParse(bar['date']?.toString() ?? '');
              if (ts != null && !ts.isBefore(target)) {
                futurePrice = (bar['close'] as num).toDouble();
                break;
              }
            }
            if (futurePrice == null) continue;

            final pctReturn = ((futurePrice - entryPrice) / entryPrice) * 100;
            double hit;
            if (pred.predictedDirection == 'up') {
              hit = pctReturn > 2
                  ? 1.0
                  : (pctReturn.abs() <= 2 ? 0.5 : 0.0);
            } else if (pred.predictedDirection == 'down') {
              hit = pctReturn < -2
                  ? 1.0
                  : (pctReturn.abs() <= 2 ? 0.5 : 0.0);
            } else {
              hit = pctReturn.abs() <= 2 ? 0.5 : 0.0;
            }

            windowResults[w]!['hits'] =
                (windowResults[w]!['hits'] as double) + hit;
            windowResults[w]!['total'] =
                (windowResults[w]!['total'] as int) + 1;
            (windowResults[w]!['returns'] as List<double>).add(pctReturn);
          }
        }
      } catch (_) {
        continue;
      }
    }

    final decayData = <Map<String, dynamic>>[];
    for (final w in windows) {
      final wr = windowResults[w]!;
      final total = wr['total'] as int;
      if (total == 0) continue;
      final hits = wr['hits'] as double;
      final returns = wr['returns'] as List<double>;
      final accuracy = hits / total;
      decayData.add({
        'window_days': w,
        'label': '${w}d',
        'accuracy': double.parse(accuracy.toStringAsFixed(3)),
        'accuracy_pct': double.parse((accuracy * 100).toStringAsFixed(1)),
        'avg_return': returns.isEmpty
            ? 0.0
            : double.parse(
                (returns.reduce((a, b) => a + b) / returns.length)
                    .toStringAsFixed(2)),
        'count': total,
      });
    }

    if (decayData.isEmpty) {
      return {
        'sufficient_data': false,
        'total': predictions.length,
        'message': 'Could not compute returns for any window',
      };
    }

    final peak = decayData.reduce(
      (a, b) =>
          (a['accuracy'] as double) >= (b['accuracy'] as double) ? a : b,
    );

    String pattern = 'stable';
    String interpretation =
        'Signal accuracy stable. Peak at ${peak['label']}.';
    if (decayData.length >= 3) {
      final early = decayData.first['accuracy'] as double;
      final late = decayData.last['accuracy'] as double;
      if (early > late + 0.05) {
        pattern = 'decaying';
        interpretation =
            'Signals most accurate at ${peak['label']}. Act fast.';
      } else if (late > early + 0.05) {
        pattern = 'improving';
        interpretation =
            'Signals improve over time. Best at ${peak['label']}.';
      }
    }

    return {
      'sufficient_data': true,
      'total_predictions': predictions.length,
      'windows': decayData,
      'peak_window': peak['label'],
      'peak_accuracy': peak['accuracy_pct'],
      'pattern': pattern,
      'interpretation': interpretation,
    };
  }

  Future<Map<String, dynamic>> calculateAbComparison() async {
    final verified = await (_db.select(_db.predictionOutcomes)
          ..where((t) => t.verifiedAt.isNotNull()))
        .get();

    Map<String, dynamic> formatGroup(List<PredictionOutcomeData> group) {
      if (group.isEmpty) {
        return {'count': 0, 'accuracy': 0.0, 'win_rate': 0.0};
      }
      final wins =
          group.where((p) => (p.accuracyScore ?? 0) >= 0.5).length;
      final avgAcc =
          group.fold<double>(0, (s, p) => s + (p.accuracyScore ?? 0)) /
              group.length;
      return {
        'count': group.length,
        'accuracy': double.parse(avgAcc.toStringAsFixed(3)),
        'win_rate':
            double.parse((wins / group.length * 100).toStringAsFixed(1)),
      };
    }

    // Infer AI usage from linked analysis reasoning length
    final quantOnly = <PredictionOutcomeData>[];
    final quantAi = <PredictionOutcomeData>[];
    for (final p in verified) {
      if (p.analysisId != null) {
        quantAi.add(p);
      } else {
        quantOnly.add(p);
      }
    }

    final qo = formatGroup(quantOnly);
    final qa = formatGroup(quantAi);
    final total = (qo['count'] as int) + (qa['count'] as int);

    if (total < 10) {
      return {
        'sufficient_data': false,
        'quant_only': qo,
        'quant_ai': qa,
        'total': total,
        'message': 'Need at least 10 verified A/B predictions',
      };
    }

    final diff = (qa['accuracy'] as double) - (qo['accuracy'] as double);
    String verdict;
    String verdictText;
    if ((qo['count'] as int) < 5 || (qa['count'] as int) < 5) {
      verdict = 'insufficient_data';
      verdictText = 'Need more data in both groups';
    } else if (diff > 0.05) {
      verdict = 'ai_adds_value';
      verdictText =
          'AI improves accuracy by +${(diff * 100).toStringAsFixed(0)}%';
    } else if (diff < -0.05) {
      verdict = 'ai_adds_noise';
      verdictText =
          'AI reduces accuracy by ${(diff * 100).toStringAsFixed(0)}%';
    } else {
      verdict = 'no_difference';
      verdictText = 'No meaningful difference between quant-only and quant+AI';
    }

    return {
      'sufficient_data': true,
      'quant_only': qo,
      'quant_ai': qa,
      'total': total,
      'difference': double.parse(diff.toStringAsFixed(3)),
      'verdict': verdict,
      'verdict_text': verdictText,
    };
  }

  Future<void> _logWeightChange({
    required Map<String, double> oldWeights,
    required Map<String, double> newWeights,
    required String trigger,
    String? reason,
  }) async {
    await _db.into(_db.weightVersions).insert(
          WeightVersionsCompanion.insert(
            oldWeights: jsonEncode(oldWeights),
            newWeights: jsonEncode(newWeights),
            trigger: trigger,
            reason: Value(reason),
          ),
        );
  }

  Future<List<Map<String, dynamic>>> getWeightHistory({int limit = 20}) async {
    final rows = await (_db.select(_db.weightVersions)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(limit))
        .get();
    return rows
        .map((r) => {
              'id': r.id,
              'timestamp': r.timestamp.toIso8601String(),
              'old_weights': jsonDecode(r.oldWeights),
              'new_weights': jsonDecode(r.newWeights),
              'trigger': r.trigger,
              'reason': r.reason,
            })
        .toList();
  }

  Future<Map<String, dynamic>> rollbackWeights(int versionId) async {
    final row = await (_db.select(_db.weightVersions)
          ..where((t) => t.id.equals(versionId)))
        .getSingleOrNull();
    if (row == null) {
      return {'success': false, 'message': 'Version $versionId not found'};
    }

    final target = Map<String, double>.from(
      (jsonDecode(row.oldWeights) as Map).map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      ),
    );
    final current = Map<String, double>.from(EngineConfig.quantCompositeWeights);

    await _settingJson('quant_weights_override', target);
    EngineConfig.quantCompositeWeights
      ..clear()
      ..addAll(target);

    await _logWeightChange(
      oldWeights: current,
      newWeights: target,
      trigger: 'rollback',
      reason: 'Rollback to version #$versionId',
    );

    return {
      'success': true,
      'message': 'Rolled back to version #$versionId',
      'restored_weights': target,
    };
  }

  Future<Map<String, dynamic>> autoAdjustWeights({bool dryRun = true}) async {
    final suggestion = await calculateOptimalWeights();
    if (suggestion['sufficient_data'] != true) return suggestion;

    final current =
        Map<String, double>.from(suggestion['current_weights'] as Map);
    final suggested =
        Map<String, double>.from(suggestion['suggested_weights'] as Map);

    if (!dryRun) {
      await _logWeightChange(
        oldWeights: current,
        newWeights: suggested,
        trigger: 'auto_adjust',
        reason: 'Learning optimizer auto-adjustment',
      );
      await _settingJson('quant_weights_override', suggested);
      EngineConfig.quantCompositeWeights
        ..clear()
        ..addAll(suggested);
    }

    return {
      'current': current,
      'suggested': suggested,
      'applied': !dryRun,
    };
  }

  Future<void> _settingJson(String key, Map<String, double> value) async {
    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    final encoded = jsonEncode(value);
    if (existing != null) {
      await (_db.update(_db.appSettings)..where((t) => t.id.equals(existing.id)))
          .write(AppSettingsCompanion(value: Value(encoded)));
    } else {
      await _db.into(_db.appSettings).insert(
            AppSettingsCompanion.insert(key: key, value: encoded),
          );
    }
  }
}

