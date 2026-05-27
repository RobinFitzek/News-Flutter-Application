import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/staleness_tracker.dart';

void main() {
  group('StalenessTracker', () {
    final tracker = StalenessTracker();

    test('fresh analysis has no decay', () {
      expect(tracker.applyConfidenceDecay(90, 0), 90);
      expect(tracker.getStalenessLevel(2), 'fresh');
    });

    test('14 day analysis is aging/stale boundary', () {
      final level = tracker.getStalenessLevel(14);
      expect(level, 'aging');
      expect(tracker.shouldRefresh(14), true);
    });

    test('enrichAnalysis adds decay metadata', () {
      final result = tracker.enrichAnalysis({
        'created_at': DateTime.now().subtract(const Duration(days: 20)),
        'confidence': 80.0,
      });
      expect(result['age_days'], 20);
      expect(result['decayed_confidence'], lessThan(80.0));
      expect(result['needs_refresh'], true);
    });

    test('sort bonus penalizes stale signals', () {
      expect(tracker.freshnessBonus('very_stale'), -10);
      expect(tracker.freshnessBonus('fresh'), 5);
    });
  });
}
