import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/correlation_analyzer.dart';
import 'package:news_app/engine/drawdown_tracker.dart';

void main() {
  group('CorrelationAnalyzer', () {
    test('correlation of identical series is 1', () {
      final analyzer = CorrelationAnalyzer();
      final matrix = {
        'AAPL': {'AAPL': 1.0, 'MSFT': 1.0},
        'MSFT': {'AAPL': 1.0, 'MSFT': 1.0},
      };
      final pairs = analyzer.getHighCorrelationPairs(matrix, threshold: 0.9);
      expect(pairs, isNotEmpty);
      expect(pairs.first['correlation'], 1.0);
    });
  });

  group('DrawdownTracker', () {
    test('detects max drawdown', () {
      final result = DrawdownTracker.analyzeEquityCurve([100, 120, 90, 110]);
      expect(result['sufficient_data'], isTrue);
      expect(result['max_drawdown_pct'] as double, greaterThan(20));
    });
  });
}
