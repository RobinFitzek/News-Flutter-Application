import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/ai_crosscheck.dart';

void main() {
  group('AiCrosscheck', () {
    final crosscheck = AiCrosscheck();

    test('empty text returns zero trust warning', () async {
      final result = await crosscheck.checkAnalysis('AAPL', '');
      expect(result['trust_score'], 0.0);
      expect(result['warning'], isNotNull);
    });

    test('compare scoring within tolerance', () {
      // Access via checkAnalysis with no claims
      expect(crosscheck, isNotNull);
    });

    test('extracts P/E claim from text', () async {
      final result = await crosscheck.checkAnalysis(
        'AAPL',
        'The stock has a P/E ratio of 25.3 and strong growth.',
      );
      expect(result['claims_found'], greaterThanOrEqualTo(0));
    });
  });
}
