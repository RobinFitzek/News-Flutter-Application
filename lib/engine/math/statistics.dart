import 'dart:math';

class Statistics {
  static double? median(List<double> values) {
    if (values.isEmpty) return null;
    final sorted = List<double>.from(values)..sort();
    final mid = sorted.length ~/ 2;
    if (sorted.length.isOdd) {
      return sorted[mid];
    }
    return (sorted[mid - 1] + sorted[mid]) / 2;
  }

  static double mean(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  static double stdDev(List<double> values) {
    if (values.length < 2) return 0;
    final avg = mean(values);
    final variance =
        values.map((v) => pow(v - avg, 2)).reduce((a, b) => a + b) / values.length;
    return sqrt(variance);
  }

  static double? rollingMean(List<double> values, int window, int index) {
    if (index < window - 1) return null;
    final slice = values.sublist(index - window + 1, index + 1);
    return mean(slice);
  }

  static double? rollingStd(List<double> values, int window, int index) {
    if (index < window - 1) return null;
    final slice = values.sublist(index - window + 1, index + 1);
    return stdDev(slice);
  }
}
