import 'package:dio/dio.dart';
import '../../../config/constants.dart';

class YahooFinanceClient {
  YahooFinanceClient()
      : _dio = Dio(BaseOptions(
          baseUrl: AppConstants.yahooFinanceBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ));

  final Dio _dio;

  Future<Map<String, dynamic>> getStockQuote(String symbol) async {
    try {
      final response = await _dio.get(
        '/v8/finance/chart/$symbol',
        queryParameters: {'interval': '1d', 'range': '1d'},
      );

      final result = response.data['chart']['result'][0];
      final meta = result['meta'];

      final currentPrice =
          (meta['regularMarketPrice'] as num?)?.toDouble() ?? 0.0;
      final previousClose = (meta['previousClose'] as num?)?.toDouble() ?? 0.0;
      final change = (currentPrice - previousClose);
      final changePercent =
          previousClose != 0 ? (change / previousClose) * 100 : 0.0;

      return {
        'symbol': symbol.toUpperCase(),
        'companyName':
            meta['longName']?.toString() ?? meta['shortName']?.toString() ?? '',
        'currentPrice': currentPrice,
        'previousClose': previousClose,
        'change': double.parse(change.toStringAsFixed(4)),
        'changePercent': double.parse(changePercent.toStringAsFixed(4)),
        'dayHigh':
            (meta['regularMarketDayHigh'] as num?)?.toDouble() ?? currentPrice,
        'dayLow':
            (meta['regularMarketDayLow'] as num?)?.toDouble() ?? currentPrice,
        'volume': meta['regularMarketVolume'] as int? ?? 0,
        'marketCap': meta['marketCap'] as double?,
        'fiftyTwoWeekHigh':
            (meta['fiftyTwoWeekHigh'] as num?)?.toDouble(),
        'fiftyTwoWeekLow':
            (meta['fiftyTwoWeekLow'] as num?)?.toDouble(),
        'trailingPE': meta['trailingPE'] as double?,
        'forwardPE': meta['forwardPE'] as double?,
        'beta': meta['beta'] as double?,
        'dividendYield': meta['dividendYield'] as double?,
        'eps': meta['epsTrailingTwelveMonths'] as double?,
        'bookValue': meta['bookValue'] as double?,
        'priceToBook': meta['priceToBook'] as double?,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch quote for $symbol: ${e.message ?? e.response?.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to fetch quote for $symbol: $e');
    }
  }

  Future<Map<String, dynamic>> getHistoricalData(
    String symbol, {
    String interval = '1d',
    String range = '1mo',
  }) async {
    try {
      final response = await _dio.get(
        '/v8/finance/chart/$symbol',
        queryParameters: {'interval': interval, 'range': range},
      );

      final result = response.data['chart']['result'][0];
      final timestamps = List<int>.from(result['timestamp'] ?? []);
      final quotes = result['indicators']['quote'][0];
      final opens = List<num>.from(quotes['open'] ?? []);
      final highs = List<num>.from(quotes['high'] ?? []);
      final lows = List<num>.from(quotes['low'] ?? []);
      final closes = List<num>.from(quotes['close'] ?? []);
      final volumes = List<int>.from(quotes['volume'] ?? []);

      final dataPoints = <Map<String, dynamic>>[];
      for (int i = 0; i < timestamps.length; i++) {
        dataPoints.add({
          'timestamp': DateTime.fromMillisecondsSinceEpoch(
            timestamps[i] * 1000,
          ).toIso8601String(),
          'open': (opens[i]).toDouble(),
          'high': (highs[i]).toDouble(),
          'low': (lows[i]).toDouble(),
          'close': (closes[i]).toDouble(),
          'volume': volumes[i],
        });
      }

      return {
        'symbol': symbol.toUpperCase(),
        'dataPoints': dataPoints,
      };
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch historical data for $symbol: ${e.message ?? e.response?.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to fetch historical data for $symbol: $e');
    }
  }

  Future<List<Map<String, dynamic>>> searchSymbol(String query) async {
    try {
      final response = await _dio.get(
        '/v1/finance/search',
        queryParameters: {'q': query},
      );

      final quotes = List<Map<String, dynamic>>.from(
        response.data['quotes'] ?? [],
      );

      return quotes.map((q) {
        return {
          'symbol': q['symbol'] as String? ?? '',
          'companyName': q['longname']?.toString() ??
              q['shortname']?.toString() ??
              '',
          'exchange': q['exchange']?.toString() ?? '',
        };
      }).toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to search symbols: ${e.message ?? e.response?.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to search symbols: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getEarningsHistory(String symbol) async {
    try {
      final response = await _dio.get(
        '/v8/finance/chart/$symbol',
        queryParameters: {'interval': '3mo', 'range': '2y', 'events': 'div,splits,earnings'},
      );
      final result = response.data['chart']['result'][0];
      final earnings = result['events']?['earnings'] as Map<String, dynamic>?;
      if (earnings == null) return [];

      return earnings.values.map((e) {
        final date =
            DateTime.fromMillisecondsSinceEpoch((e['date'] as int) * 1000);
        return {
          'symbol': symbol.toUpperCase(),
          'reportDate': date.toIso8601String(),
          'estimatedEps': (e['epsEstimate'] as num?)?.toDouble(),
          'actualEps': (e['epsActual'] as num?)?.toDouble(),
          'surprise': (e['surprise'] as num?)?.toDouble(),
          'surprisePercent': (e['surprisePercent'] as num?)?.toDouble(),
          'period': e['period']?.toString() ?? '',
        };
      }).toList()
        ..sort((a, b) => (b['reportDate'] as String)
            .compareTo(a['reportDate'] as String));
    } on DioException {
      return [];
    } catch (e) {
      throw Exception('Failed to fetch earnings: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCorporateActions(String symbol) async {
    try {
      final response = await _dio.get(
        '/v8/finance/chart/$symbol',
        queryParameters: {'interval': '1d', 'range': '2y', 'events': 'div,splits'},
      );
      final result = response.data['chart']['result'][0];
      final events = <Map<String, dynamic>>[];

      final dividends = result['events']?['dividends'] as Map<String, dynamic>?;
      if (dividends != null) {
        for (final d in dividends.values) {
          final date =
              DateTime.fromMillisecondsSinceEpoch((d['date'] as int) * 1000);
          events.add({
            'symbol': symbol.toUpperCase(),
            'type': 'dividend',
            'date': date.toIso8601String(),
            'description': 'Cash dividend',
            'amount': (d['amount'] as num).toDouble(),
            'currency': 'USD',
          });
        }
      }

      final splits = result['events']?['splits'] as Map<String, dynamic>?;
      if (splits != null) {
        for (final s in splits.values) {
          final date =
              DateTime.fromMillisecondsSinceEpoch((s['date'] as int) * 1000);
          events.add({
            'symbol': symbol.toUpperCase(),
            'type': 'split',
            'date': date.toIso8601String(),
            'description': '${s['numerator']}/${s['denominator']} split',
            'amount': null,
            'currency': 'USD',
          });
        }
      }

      events.sort((a, b) =>
          (b['date'] as String).compareTo(a['date'] as String));
      return events;
    } on DioException {
      return [];
    } catch (e) {
      throw Exception('Failed to fetch corporate actions: $e');
    }
  }
}
