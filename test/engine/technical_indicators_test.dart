import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/math/statistics.dart';
import 'package:news_app/engine/math/technical_indicators.dart';

void main() {
  group('TechnicalIndicators', () {
    test('RSI returns value in 0-100 range for trending data', () {
      final closes = List<double>.generate(30, (i) => 100.0 + i);
      final rsi = TechnicalIndicators.computeRsi(closes);
      expect(rsi, isNotNull);
      expect(rsi!, greaterThan(50));
      expect(rsi, lessThanOrEqualTo(100));
    });

    test('SMA cross detects bullish when short above long', () {
      final closes = List<double>.generate(250, (i) => 100.0 + i * 0.5);
      final signal = TechnicalIndicators.computeSmaCrossSignal(closes);
      expect(['bullish', 'golden_cross'], contains(signal));
    });

    test('Bollinger position is negative when price below mid band', () {
      final closes = <double>[100.0, 101, 99, 100, 98, 97, 96, 95, 94, 93,
          92, 91, 90, 89, 88, 87, 86, 85, 84, 83, 82];
      final pos = TechnicalIndicators.computeBollingerPosition(closes);
      expect(pos, lessThan(0));
    });
  });

  group('Statistics', () {
    test('median of odd count', () {
      expect(Statistics.median([1, 3, 5]), 3);
    });

    test('median of even count', () {
      expect(Statistics.median([1, 2, 3, 4]), 2.5);
    });
  });
}
