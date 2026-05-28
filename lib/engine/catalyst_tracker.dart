import '../data/datasources/remote/yahoo_finance_client.dart';

/// Upcoming catalysts — earnings, dividends, splits.
class CatalystTracker {
  CatalystTracker({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  Future<List<Map<String, dynamic>>> getCatalysts(String ticker) async {
    ticker = ticker.toUpperCase();
    final catalysts = <Map<String, dynamic>>[];

    try {
      final earnings = await _yahoo.getEarningsHistory(ticker);
      for (final e in earnings.take(3)) {
        final date = e['reportDate']?.toString();
        if (date == null) continue;
        catalysts.add({
          'type': 'earnings',
          'date': date,
          'title': 'Earnings Report',
          'detail': 'EPS est: ${e['estimatedEps'] ?? '—'}',
        });
      }
    } catch (_) {}

    try {
      final actions = await _yahoo.getCorporateActions(ticker);
      final now = DateTime.now();
      for (final a in actions) {
        final dateStr = a['date']?.toString();
        final dt = DateTime.tryParse(dateStr ?? '');
        if (dt == null || dt.isBefore(now.subtract(const Duration(days: 1)))) {
          continue;
        }
        if (dt.isAfter(now.add(const Duration(days: 90)))) continue;
        catalysts.add({
          'type': a['type']?.toString() ?? 'corporate_action',
          'date': dateStr,
          'title': a['type']?.toString() ?? 'Corporate Action',
          'detail': a['description']?.toString() ?? '',
        });
      }
    } catch (_) {}

    catalysts.sort((a, b) => (a['date'] as String).compareTo(b['date'] as String));
    return catalysts;
  }
}
