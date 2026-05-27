import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/moat_scorer.dart';

void main() {
  group('MoatScorer', () {
    test('moatGrade thresholds match server', () {
      expect(MoatScorer.moatGrade(75), 'Strong');
      expect(MoatScorer.moatGrade(70), 'Strong');
      expect(MoatScorer.moatGrade(50), 'Moderate');
      expect(MoatScorer.moatGrade(45), 'Moderate');
      expect(MoatScorer.moatGrade(25), 'Weak');
      expect(MoatScorer.moatGrade(10), 'None');
    });
  });
}
