import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';

/// Meta-labeler with logistic regression — mirrors meta_labeler.py (RF → LR for mobile).
class MetaLabeler {
  MetaLabeler(this._db);

  final AppDatabase _db;
  final _config = MetaLabelerConfig();

  List<double> _weights = [];
  List<String> _featureNames = [];
  bool _ready = false;
  int _version = 0;

  bool get isReady => _ready;
  int get version => _version;

  Map<String, double> extractFeatures(Map<String, dynamic> candidate) {
    final scores = candidate['scores'] as Map<String, dynamic>? ?? {};
    final tech = candidate['technicals'] as Map<String, dynamic>? ?? {};
    final mom = candidate['momentum'] as Map<String, dynamic>? ?? {};
    final vol = candidate['volume_metrics'] as Map<String, dynamic>? ?? {};

    const smaMap = {
      'golden_cross': 1.0,
      'bullish': 0.5,
      'neutral': 0.0,
      'bearish': -0.5,
      'death_cross': -1.0,
    };

    return {
      'composite_score':
          ((candidate['composite_score'] as num?) ?? 50) / 100.0,
      'val_score': ((scores['valuation'] as num?) ?? 50) / 100.0,
      'tech_score': ((scores['technical'] as num?) ?? 50) / 100.0,
      'mom_score': ((scores['momentum'] as num?) ?? 50) / 100.0,
      'qual_score': ((scores['quality'] as num?) ?? 50) / 100.0,
      'rsi_14': ((tech['rsi_14'] as num?) ?? 50) / 100.0,
      'bollinger_position':
          ((tech['bollinger_position'] as num?) ?? 0).toDouble(),
      'price_vs_52w':
          ((tech['price_vs_52w_range'] as num?) ?? 0.5).toDouble(),
      'sma_cross_code':
          smaMap[tech['sma_cross_signal']?.toString()] ?? 0.0,
      'volume_ratio':
          min(5.0, ((vol['volume_ratio'] as num?) ?? 1.0).toDouble()) / 5.0,
      'excess_return_1m':
          (((mom['excess_1m'] as num?) ?? 0) / 20.0).clamp(-1.0, 1.0),
    };
  }

  Map<String, dynamic> predict(Map<String, dynamic> candidate) {
    if (!_ready) {
      return {'meta_probability': 0.5, 'meta_signal': 'neutral'};
    }

    final features = extractFeatures(candidate);
    final x = _featureNames.map((f) => features[f] ?? 0.0).toList();
    final prob = _sigmoid(_dot(_weights, [1.0, ...x]));

    String metaSignal;
    if (prob >= _config.confirmThreshold) {
      metaSignal = 'confirmed';
    } else if (prob <= _config.filterThreshold) {
      metaSignal = 'filtered';
    } else {
      metaSignal = 'neutral';
    }

    return {
      'meta_probability': double.parse(prob.toStringAsFixed(3)),
      'meta_signal': metaSignal,
    };
  }

  int blendScore(int originalScore, double metaProb) {
    final blended = originalScore * _config.scoreBlendOriginal +
        (metaProb * 100) * _config.scoreBlendMeta;
    return blended.round().clamp(0, 100);
  }

  Future<Map<String, dynamic>> train({bool force = false}) async {
    final records = await (_db.select(_db.signalGrades)
          ..where((t) =>
              t.grade.equals('correct') | t.grade.equals('incorrect')))
        .get();

    if (records.length < _config.minTrainingSamples && !force) {
      return {
        'trained': false,
        'reason':
            'Insufficient data (${records.length}/${_config.minTrainingSamples})',
      };
    }

    if (records.isEmpty) {
      return {'trained': false, 'reason': 'No graded signals'};
    }

    final samples = <List<double>>[];
    final labels = <double>[];

    for (final rec in records) {
      if (rec.quantScore == null) continue;
      final features = {
        'composite_score': rec.quantScore! / 100.0,
        'val_score': 0.5,
        'tech_score': 0.5,
        'mom_score': 0.5,
        'qual_score': 0.5,
        'rsi_14': 0.5,
        'bollinger_position': 0.0,
        'price_vs_52w': 0.5,
        'sma_cross_code': 0.0,
        'volume_ratio': 0.2,
        'excess_return_1m': ((rec.return30d ?? 0) * 5).clamp(-1.0, 1.0),
      };

      if (_featureNames.isEmpty) {
        _featureNames = features.keys.toList();
      }

      samples.add(_featureNames.map((f) => features[f] ?? 0.0).toList());
      labels.add(rec.grade == 'correct' ? 1.0 : 0.0);
    }

    if (samples.length < 10) {
      return {'trained': false, 'reason': 'Too few feature samples'};
    }

    _weights = _trainLogisticRegression(samples, labels, epochs: 200, lr: 0.1);
    _ready = true;
    _version++;

    await _persistModel();

    return {
      'trained': true,
      'samples': samples.length,
      'version': _version,
      'accuracy': _evaluateAccuracy(samples, labels),
    };
  }

  Future<void> loadModel() async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals('meta_labeler_model')))
        .getSingleOrNull();
    if (row == null) return;

    try {
      final data = jsonDecode(row.value) as Map<String, dynamic>;
      _featureNames = List<String>.from(data['features'] as List);
      _weights = List<double>.from(
          (data['weights'] as List).map((e) => (e as num).toDouble()));
      _version = data['version'] as int? ?? 0;
      _ready = _weights.isNotEmpty;
    } catch (_) {}
  }

  Future<void> _persistModel() async {
    final payload = jsonEncode({
      'features': _featureNames,
      'weights': _weights,
      'version': _version,
      'trained_at': DateTime.now().toIso8601String(),
    });

    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals('meta_labeler_model')))
        .getSingleOrNull();

    if (existing != null) {
      await (_db.update(_db.appSettings)
            ..where((t) => t.key.equals('meta_labeler_model')))
          .write(AppSettingsCompanion(value: Value(payload)));
    } else {
      await _db.into(_db.appSettings).insert(
            AppSettingsCompanion.insert(
              key: 'meta_labeler_model',
              value: payload,
            ),
          );
    }
  }

  List<double> _trainLogisticRegression(
    List<List<double>> x,
    List<double> y, {
    required int epochs,
    required double lr,
  }) {
    final nFeatures = x.first.length;
    var weights = List<double>.filled(nFeatures + 1, 0.0);

    for (var epoch = 0; epoch < epochs; epoch++) {
      final grads = List<double>.filled(nFeatures + 1, 0.0);
      for (var i = 0; i < x.length; i++) {
        final pred = _sigmoid(_dot(weights, [1.0, ...x[i]]));
        final error = pred - y[i];
        grads[0] += error;
        for (var j = 0; j < nFeatures; j++) {
          grads[j + 1] += error * x[i][j];
        }
      }
      for (var j = 0; j < weights.length; j++) {
        weights[j] -= lr * grads[j] / x.length;
      }
    }
    return weights;
  }

  double _evaluateAccuracy(List<List<double>> x, List<double> y) {
    var correct = 0;
    for (var i = 0; i < x.length; i++) {
      final pred = _sigmoid(_dot(_weights, [1.0, ...x[i]])) >= 0.5 ? 1.0 : 0.0;
      if (pred == y[i]) correct++;
    }
    return double.parse((correct / x.length).toStringAsFixed(3));
  }

  double _dot(List<double> a, List<double> b) {
    var sum = 0.0;
    for (var i = 0; i < min(a.length, b.length); i++) {
      sum += a[i] * b[i];
    }
    return sum;
  }

  double _sigmoid(double x) => 1 / (1 + exp(-x.clamp(-20, 20)));
}

class MetaLabelerConfig {
  final int minTrainingSamples = 50;
  final double confirmThreshold = 0.55;
  final double filterThreshold = 0.45;
  final double scoreBlendOriginal = 0.70;
  final double scoreBlendMeta = 0.30;
}
