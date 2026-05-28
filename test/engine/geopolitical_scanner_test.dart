import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/geopolitical_scanner.dart';

void main() {
  group('GeopoliticalScanner.parseGeoText', () {
    test('extracts severity and summary', () {
      const raw = '''
SCHWEREGRAD: 7
ZUSAMMENFASSUNG: Erhöhte Spannungen im Nahen Osten belasten Öl und Defense.
EREIGNISSE:
- Israel-Iran Eskalation | Region: Middle East | SCHWEREGRAD: 8
- EU Zölle | Region: Europe | SCHWEREGRAD: 5
''';

      final parsed = GeopoliticalScanner.parseGeoText(raw);
      expect(parsed['severity'], 7);
      expect(parsed['summary'], contains('Nahen Osten'));
      expect((parsed['events'] as List).length, 2);
    });

    test('defaults severity when missing', () {
      final parsed = GeopoliticalScanner.parseGeoText('Markets are calm today.');
      expect(parsed['severity'], 5);
      expect(parsed['events'], isEmpty);
    });
  });
}
