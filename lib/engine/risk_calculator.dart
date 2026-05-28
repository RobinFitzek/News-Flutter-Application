import 'dart:math';

class RiskCalculator {
  static Map<String, double> calculate({
    required List<double> equityCurve,
    double riskFreeRate = 0.05,
  }) {
    if (equityCurve.length < 2) {
      return {'sharpe': 0, 'sortino': 0, 'maxDrawdown': 0, 'volatility': 0, 'var95': 0};
    }

    final returns = <double>[];
    for (int i = 1; i < equityCurve.length; i++) {
      if (equityCurve[i - 1] != 0) {
        returns.add((equityCurve[i] - equityCurve[i - 1]) / equityCurve[i - 1]);
      }
    }

    if (returns.isEmpty) {
      return {'sharpe': 0, 'sortino': 0, 'maxDrawdown': 0, 'volatility': 0, 'var95': 0};
    }

    final avgReturn = returns.reduce((a, b) => a + b) / returns.length;
    final variance = returns.map((r) => pow(r - avgReturn, 2)).reduce((a, b) => a + b) / returns.length;
    final stdDev = sqrt(variance);

    final sharpe = stdDev != 0 ? (avgReturn * 252 - riskFreeRate) / (stdDev * sqrt(252)) : 0.0;

    final downReturns = returns.where((r) => r < 0).toList();
    final downVariance = downReturns.isNotEmpty
        ? downReturns.map((r) => pow(r, 2)).reduce((a, b) => a + b) / downReturns.length
        : 0.0;
    final downStdDev = sqrt(downVariance);
    final sortino = downStdDev != 0 ? (avgReturn * 252 - riskFreeRate) / (downStdDev * sqrt(252)) : 0.0;

    double peak = equityCurve[0];
    double maxDrawdown = 0;
    for (final v in equityCurve) {
      if (v > peak) peak = v;
      final dd = (peak - v) / peak;
      if (dd > maxDrawdown) maxDrawdown = dd;
    }

    final volatility = stdDev * sqrt(252) * 100;
    final sortedReturns = returns.toList()..sort();
    final var95Idx = (sortedReturns.length * 0.05).round().clamp(0, sortedReturns.length - 1);
    final var95 = -sortedReturns[var95Idx] * 100;

    return {
      'sharpe': double.parse(sharpe.toStringAsFixed(2)),
      'sortino': double.parse(sortino.toStringAsFixed(2)),
      'maxDrawdown': double.parse((maxDrawdown * 100).toStringAsFixed(2)),
      'volatility': double.parse(volatility.toStringAsFixed(2)),
      'var95': double.parse(var95.toStringAsFixed(2)),
    };
  }
}
