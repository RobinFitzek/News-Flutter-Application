/// Signal staleness & confidence decay — mirrors News/engine/staleness_tracker.py.
class StalenessTracker {
  static const decayRatePerDay = 0.05 / 7;
  static const staleThresholdDays = 14;
  static const veryStaleThresholdDays = 30;
  static const geoScanStaleHours = 24;

  int calculateAgeDays(DateTime timestamp) {
    return DateTime.now().difference(timestamp).inDays.clamp(0, 9999);
  }

  double applyConfidenceDecay(double originalConfidence, int ageDays) {
    if (ageDays <= 0) return originalConfidence;
    final decayFactor = _pow(1 - decayRatePerDay, ageDays);
    return (originalConfidence * decayFactor).clamp(0, 100);
  }

  double _pow(double base, int exp) {
    var result = 1.0;
    for (var i = 0; i < exp; i++) {
      result *= base;
    }
    return result;
  }

  String getStalenessLevel(int ageDays) {
    if (ageDays <= 3) return 'fresh';
    if (ageDays <= 7) return 'recent';
    if (ageDays <= staleThresholdDays) return 'aging';
    if (ageDays <= veryStaleThresholdDays) return 'stale';
    return 'very_stale';
  }

  String getStalenessLabel(String level) {
    const labels = {
      'fresh': 'Fresh',
      'recent': 'Recent',
      'aging': 'Aging',
      'stale': 'Stale',
      'very_stale': 'Outdated',
    };
    return labels[level] ?? level;
  }

  bool shouldRefresh(int ageDays) => ageDays >= staleThresholdDays;

  Map<String, dynamic> enrichAnalysis(Map<String, dynamic> analysis) {
    final ts = analysis['created_at'] as DateTime? ??
        analysis['timestamp'] as DateTime? ??
        DateTime.now();
    final ageDays = calculateAgeDays(ts);
    final original =
        (analysis['confidence'] as num?)?.toDouble() ?? 50.0;
    final decayed = applyConfidenceDecay(original, ageDays);
    final level = getStalenessLevel(ageDays);

    analysis['age_days'] = ageDays;
    analysis['staleness_level'] = level;
    analysis['staleness_label'] = getStalenessLabel(level);
    analysis['original_confidence'] = original;
    analysis['decayed_confidence'] =
        double.parse(decayed.toStringAsFixed(1));
    analysis['needs_refresh'] = shouldRefresh(ageDays);

    if (level == 'stale' || level == 'very_stale') {
      final warnings = List<String>.from(
        (analysis['warnings'] as List?)?.cast<String>() ?? [],
      );
      warnings.add(
        'Analysis is $ageDays days old — confidence decayed from '
        '${original.toStringAsFixed(0)}% to ${decayed.toStringAsFixed(1)}%',
      );
      if (shouldRefresh(ageDays)) {
        warnings.add('NEEDS REFRESH — data may be outdated');
      }
      analysis['warnings'] = warnings;
    }
    return analysis;
  }

  double freshnessBonus(String level) {
    const bonus = {
      'fresh': 5.0,
      'recent': 3.0,
      'aging': 0.0,
      'stale': -5.0,
      'very_stale': -10.0,
    };
    return bonus[level] ?? 0;
  }
}
