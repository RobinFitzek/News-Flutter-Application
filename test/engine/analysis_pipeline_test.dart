import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/engine/analysis_pipeline.dart';

void main() {
  group('AnalysisPipeline.shouldScanTicker', () {
    test('core tier always scans even with recent timestamp', () {
      expect(
        AnalysisPipeline.shouldScanTicker(
          tier: 'core',
          lastScannedAt: DateTime.now(),
        ),
        isTrue,
      );
    });

    test('tier2 waits 24 hours', () {
      expect(
        AnalysisPipeline.shouldScanTicker(
          tier: 'tier2',
          lastScannedAt: DateTime.now().subtract(const Duration(hours: 12)),
        ),
        isFalse,
      );
      expect(
        AnalysisPipeline.shouldScanTicker(
          tier: 'tier2',
          lastScannedAt: DateTime.now().subtract(const Duration(hours: 25)),
        ),
        isTrue,
      );
    });

    test('default tier waits 72 hours', () {
      expect(
        AnalysisPipeline.shouldScanTicker(
          tier: 'tier3',
          lastScannedAt: DateTime.now().subtract(const Duration(hours: 48)),
        ),
        isFalse,
      );
      expect(
        AnalysisPipeline.shouldScanTicker(
          tier: 'tier3',
          lastScannedAt: DateTime.now().subtract(const Duration(hours: 73)),
        ),
        isTrue,
      );
    });

    test('null lastScannedAt always eligible', () {
      expect(
        AnalysisPipeline.shouldScanTicker(tier: 'tier3', lastScannedAt: null),
        isTrue,
      );
    });
  });
}
