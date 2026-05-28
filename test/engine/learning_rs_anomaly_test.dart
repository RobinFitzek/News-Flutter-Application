import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/learning_optimizer.dart';
import 'package:news_app/engine/rs_ranking.dart';
import 'package:news_app/engine/portfolio_anomaly.dart';
import 'package:news_app/data/database/app_database.dart';

void main() {
  group('LearningOptimizer classifySignalType', () {
    late AppDatabase db;
    late LearningOptimizer opt;

    setUp(() {
      db = AppDatabase();
      opt = LearningOptimizer(db);
    });

    tearDown(() async => db.close());

    test('high momentum score returns momentum', () {
      expect(opt.classifySignalType(momentumScore: 75), 'momentum');
    });

    test('high valuation score returns value', () {
      expect(opt.classifySignalType(valuationScore: 80), 'value');
    });

    test('default classification', () {
      expect(opt.classifySignalType(), 'default');
    });
  });

  group('RsRanking', () {
    test('class exists for ranking', () {
      expect(RsRanking(), isNotNull);
    });
  });

  group('PortfolioAnomaly', () {
    test('empty holdings returns no anomalies', () async {
      final result = await PortfolioAnomaly().scan([]);
      expect(result, isEmpty);
    });
  });
}
