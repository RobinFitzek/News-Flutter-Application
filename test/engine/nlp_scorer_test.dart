import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/nlp_scorer.dart';
import 'package:news_app/data/database/app_database.dart';

void main() {
  group('NlpScorer', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase();
    });

    tearDown(() async {
      await db.close();
    });

    test('scoreTicker detects ticker in headline', () {
      final scorer = NlpScorer(db);
      final result = scorer.scoreTicker('AAPL', [
        {'title': 'AAPL shares surge on strong earnings beat', 'summary': ''},
        {'title': 'Market mixed as tech rallies', 'summary': ''},
      ]);

      expect(result['headline_count'], 1);
      expect(result['compound'] as double, greaterThan(0));
    });

    test('scoreTicker returns neutral when no matches', () {
      final scorer = NlpScorer(db);
      final result = scorer.scoreTicker('ZZZZ', [
        {'title': 'Market mixed as tech rallies', 'summary': ''},
      ]);

      expect(result['headline_count'], 0);
      expect(result['compound'], 0.0);
    });
  });
}
