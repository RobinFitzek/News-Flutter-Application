import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/macro_tracker.dart';
import 'package:news_app/engine/composite_signals.dart';

void main() {
  group('MacroTracker', () {
    final tracker = MacroTracker();

    test('returns upcoming FOMC events within 90 days', () {
      final events = tracker.getUpcomingEvents(daysAhead: 90);
      expect(events, isNotEmpty);
      expect(events.first['type'], isIn(['FOMC', 'ECB']));
    });

    test('detects rate sensitive tickers', () {
      expect(tracker.isRateSensitive('BAC', name: 'Bank of America'), isTrue);
      expect(tracker.isRateSensitive('AAPL', name: 'Apple Inc'), isFalse);
    });

    test('buildMacroContextBlock includes events when present', () {
      final block = tracker.buildMacroContextBlock();
      if (block.isNotEmpty) {
        expect(block, contains('CENTRAL BANK'));
      }
    });
  });

  group('CompositeSignals', () {
    test('defines three composite patterns', () {
      expect(CompositeSignals.patterns.length, 3);
    });
  });
}
