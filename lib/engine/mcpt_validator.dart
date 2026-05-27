import 'dart:math';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';

/// Monte Carlo Permutation Test — mirrors News/engine/mcpt_validator.py.
class McptValidator {
  McptValidator(this._db);

  final AppDatabase _db;

  static const inSamplePermutations = 200;
  static const walkForwardPThreshold = 0.05;
  static const minSignals = 30;

  Future<Map<String, dynamic>> runValidation({int? nPermutations}) async {
    final nPerm = nPermutations ?? inSamplePermutations;

    final records = await (_db.select(_db.signalGrades)
          ..where((t) => t.grade.isIn(['correct', 'incorrect', 'partially_correct']))
          ..where((t) => t.return30d.isNotNull()))
        .get();

    if (records.length < minSignals) {
      return {
        'status': 'insufficient_data',
        'n_signals': records.length,
        'min_required': minSignals,
      };
    }

    const signalMap = {
      'STRONG_BUY': 1.0,
      'BUY': 1.0,
      'Opportunity': 1.0,
      'HOLD': 0.0,
      'Neutral': 0.0,
      'SELL': -1.0,
      'Caution': -1.0,
      'STRONG_SELL': -1.0,
    };

    final signals = records
        .map((r) => signalMap[r.signal.toUpperCase()] ?? signalMap[r.signal] ?? 0.0)
        .toList();
    final returns =
        records.map((r) => r.return30d ?? 0.0).toList();
    final strategyReturns = List<double>.generate(
      signals.length,
      (i) => signals[i] * returns[i],
    );

    final actualPf = _profitFactor(strategyReturns);
    final rng = Random(42);
    final permutedPfs = List<double>.filled(nPerm, 0);

    for (var i = 0; i < nPerm; i++) {
      final shuffled = List<double>.from(returns)..shuffle(rng);
      final permReturns = List<double>.generate(
        signals.length,
        (j) => signals[j] * shuffled[j],
      );
      permutedPfs[i] = _profitFactor(permReturns);
    }

    final pValue =
        permutedPfs.where((pf) => pf >= actualPf).length / nPerm;
    final significant = pValue < walkForwardPThreshold;
    final mean = permutedPfs.reduce((a, b) => a + b) / nPerm;
    final variance = permutedPfs
            .map((x) => (x - mean) * (x - mean))
            .reduce((a, b) => a + b) /
        nPerm;

    final result = {
      'status': 'completed',
      'test_type': 'in_sample',
      'p_value': double.parse(pValue.toStringAsFixed(4)),
      'actual_pf': double.parse(actualPf.toStringAsFixed(4)),
      'permuted_mean': double.parse(mean.toStringAsFixed(4)),
      'permuted_std': double.parse(sqrt(variance).toStringAsFixed(4)),
      'n_permutations': nPerm,
      'n_signals': records.length,
      'significant': significant,
    };

    await _db.into(_db.mcptResults).insert(
          McptResultsCompanion.insert(
            testType: 'in_sample',
            runDate: DateTime.now(),
            pValue: Value(result['p_value'] as double),
            actualMetric: Value(result['actual_pf'] as double),
            permutedMean: Value(result['permuted_mean'] as double),
            permutedStd: Value(result['permuted_std'] as double),
            nPermutations: Value(nPerm),
            nSignals: Value(records.length),
            significant: Value(significant),
          ),
        );

    return result;
  }

  static double _profitFactor(List<double> returns) {
    var sumPos = 0.0;
    var sumNeg = 0.0;
    for (final r in returns) {
      if (r > 0) {
        sumPos += r;
      } else if (r < 0) {
        sumNeg += r.abs();
      }
    }
    return sumPos / (sumNeg > 0 ? sumNeg : 0.001);
  }

  Future<Map<String, dynamic>?> getLatestResult() async {
    final row = await (_db.select(_db.mcptResults)
          ..orderBy([(t) => OrderingTerm.desc(t.runDate)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return {
      'test_type': row.testType,
      'run_date': row.runDate.toIso8601String(),
      'p_value': row.pValue,
      'actual_pf': row.actualMetric,
      'significant': row.significant,
      'n_signals': row.nSignals,
    };
  }

  Future<bool> isStrategyValid() async {
    final latest = await getLatestResult();
    if (latest == null) return true;
    return latest['significant'] as bool? ?? true;
  }
}
