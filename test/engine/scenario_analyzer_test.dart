import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/scenario_analyzer.dart';
import 'package:news_app/data/database/app_database.dart';

void main() {
  group('ScenarioAnalyzer', () {
    final analyzer = ScenarioAnalyzer();

    test('returns five preset scenarios', () {
      expect(analyzer.getPresetScenarios().length, 5);
    });

    test('market crash scenario impacts holdings', () async {
      final holdings = [
        PositionData(
          id: 1,
          symbol: 'AAPL',
          companyName: 'Apple',
          shares: 10,
          avgCostBasis: 150,
          currentPrice: 180,
          acquiredAt: DateTime.now(),
          currency: 'USD',
          note: null,
        ),
      ];
      final result = await analyzer.runScenario('market_crash', holdings);
      expect(result['error'], isNull);
      expect(result['total_impact_pct'], lessThan(0));
      expect((result['impacts'] as List).length, 1);
    });

    test('empty portfolio returns error message', () async {
      final result = await analyzer.runScenario('market_crash', []);
      expect(result['error'], isNotNull);
    });
  });
}
