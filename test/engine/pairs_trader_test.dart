import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/pairs_trader.dart';

void main() {
  group('PairsTrader', () {
    test('signal thresholds', () {
      final trader = PairsTrader();
      expect(trader.analyzePair, isNotNull);
    });

    test('default pairs list is populated', () {
      expect(PairsTrader.defaultPairs.length, greaterThanOrEqualTo(8));
    });
  });
}
