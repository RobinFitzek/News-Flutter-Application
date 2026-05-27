import '../data/datasources/remote/yahoo_finance_client.dart';

/// Pre/post market prices — mirrors extended-hours API.
class ExtendedHours {
  ExtendedHours({YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final YahooFinanceClient _yahoo;

  Future<Map<String, dynamic>> getExtendedHours(String ticker) async {
    ticker = ticker.toUpperCase();
    try {
      final q = await _yahoo.getStockQuote(ticker);
      return {
        'ticker': ticker,
        'regular_price': q['currentPrice'],
        'regular_change_pct': q['changePercent'],
        'pre_market_price': q['preMarketPrice'],
        'pre_market_change_pct': q['preMarketChangePercent'],
        'post_market_price': q['postMarketPrice'],
        'post_market_change_pct': q['postMarketChangePercent'],
        'market_state': q['marketState'] ?? 'REGULAR',
      };
    } catch (e) {
      return {'ticker': ticker, 'error': e.toString()};
    }
  }
}
