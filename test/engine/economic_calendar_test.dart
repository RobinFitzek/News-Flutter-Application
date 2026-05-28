import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/economic_calendar.dart';

void main() {
  group('EconomicCalendar', () {
    test('includes FOMC events in upcoming window', () async {
      final cal = EconomicCalendar();
      final events = await cal.getUpcomingEvents(daysAhead: 365);
      final fomc = events.where((e) => e['type'] == 'FOMC').toList();
      expect(fomc, isNotEmpty);
    });

    test('events are sorted by date', () async {
      final cal = EconomicCalendar();
      final events = await cal.getUpcomingEvents(daysAhead: 60);
      for (var i = 1; i < events.length; i++) {
        expect(
          (events[i]['date'] as DateTime)
              .isAfter((events[i - 1]['date'] as DateTime).subtract(const Duration(seconds: 1))),
          isTrue,
        );
      }
    });
  });
}
