/// Drawdown metrics from an equity curve — mirrors drawdown_tracker.py.
class DrawdownTracker {
  static Map<String, dynamic> analyzeEquityCurve(List<double> values) {
    if (values.length < 2) {
      return {
        'sufficient_data': false,
        'max_drawdown_pct': 0.0,
        'current_drawdown_pct': 0.0,
      };
    }

    var peak = values.first;
    var maxDrawdown = 0.0;
    var currentDrawdown = 0.0;

    for (final value in values) {
      if (value > peak) peak = value;
      final dd = peak > 0 ? (peak - value) / peak * 100 : 0.0;
      if (dd > maxDrawdown) maxDrawdown = dd;
      currentDrawdown = dd;
    }

    return {
      'sufficient_data': true,
      'max_drawdown_pct': double.parse(maxDrawdown.toStringAsFixed(2)),
      'current_drawdown_pct': double.parse(currentDrawdown.toStringAsFixed(2)),
      'underwater': currentDrawdown > 0.01,
    };
  }
}
