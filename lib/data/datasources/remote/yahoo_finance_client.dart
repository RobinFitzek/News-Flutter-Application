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
        'preMarketPrice': (meta['preMarketPrice'] as num?)?.toDouble(),
        'preMarketChangePercent':
            (meta['preMarketChangePercent'] as num?)?.toDouble(),
        'postMarketPrice': (meta['postMarketPrice'] as num?)?.toDouble(),
        'postMarketChangePercent':
            (meta['postMarketChangePercent'] as num?)?.toDouble(),
        'marketState': meta['marketState']?.toString() ?? 'REGULAR',
        'sector': meta['sector']?.toString(),
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

  /// Full fundamental profile via quoteSummary (mirrors yfinance .info).
  Future<Map<String, dynamic>> getStockInfo(String symbol) async {
    try {
      final response = await _dio.get(
        '/v10/finance/quoteSummary/$symbol',
        queryParameters: {
          'modules':
              'assetProfile,summaryDetail,defaultKeyStatistics,financialData,price',
        },
      );

      final result = response.data['quoteSummary']['result'][0];
      final profile = result['assetProfile'] ?? {};
      final summary = result['summaryDetail'] ?? {};
      final stats = result['defaultKeyStatistics'] ?? {};
      final financial = result['financialData'] ?? {};
      final price = result['price'] ?? {};

      double? numVal(dynamic v) => (v as num?)?.toDouble();

      return {
        'symbol': symbol.toUpperCase(),
        'longName': profile['longName']?.toString() ??
            price['longName']?.toString() ??
            price['shortName']?.toString() ??
            symbol.toUpperCase(),
        'shortName': price['shortName']?.toString() ?? symbol.toUpperCase(),
        'sector': profile['sector']?.toString() ?? 'Unknown',
        'industry': profile['industry']?.toString() ?? 'Unknown',
        'currentPrice': numVal(price['regularMarketPrice']) ??
            numVal(summary['regularMarketPrice']),
        'regularMarketPrice': numVal(price['regularMarketPrice']) ??
            numVal(summary['regularMarketPrice']),
        'marketCap': numVal(summary['marketCap']) ?? numVal(price['marketCap']),
        'trailingPE': numVal(summary['trailingPE']) ?? numVal(stats['trailingPE']),
        'forwardPE': numVal(summary['forwardPE']) ?? numVal(stats['forwardPE']),
        'priceToBook': numVal(stats['priceToBook']),
        'pegRatio': numVal(stats['pegRatio']),
        'debtToEquity': numVal(financial['debtToEquity']) ??
            numVal(stats['debtToEquity']),
        'currentRatio': numVal(financial['currentRatio']) ??
            numVal(stats['currentRatio']),
        'returnOnEquity': numVal(financial['returnOnEquity']) ??
            numVal(stats['returnOnEquity']),
        'freeCashflow': numVal(financial['freeCashflow']),
        'grossMargins': numVal(financial['grossMargins']),
        'earningsGrowth': numVal(financial['earningsGrowth']) ??
            numVal(stats['earningsQuarterlyGrowth']),
        'beta': numVal(summary['beta']) ?? numVal(stats['beta']),
        'dividendYield': numVal(summary['dividendYield']),
        'fiftyTwoWeekHigh': numVal(summary['fiftyTwoWeekHigh']),
        'fiftyTwoWeekLow': numVal(summary['fiftyTwoWeekLow']),
        'eps': numVal(stats['trailingEps']) ??
            numVal(financial['revenuePerShare']),
        'shortPercentOfFloat': numVal(stats['shortPercentOfFloat']),
        'shortRatio': numVal(stats['shortRatio']),
        'sharesShort': stats['sharesShort'] as int?,
        'floatShares': numVal(stats['floatShares']),
        'sharesOutstanding': numVal(stats['sharesOutstanding']),
      };
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch info for $symbol: ${e.message ?? e.response?.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to fetch info for $symbol: $e');
    }
  }

  /// Returns OHLCV bars for quant screener / backtest engines.
  Future<List<Map<String, dynamic>>> getOhlcvHistory(
    String symbol, {
    String interval = '1d',
    String range = '1y',
  }) async {
    final raw = await getHistoricalData(symbol, interval: interval, range: range);
    return List<Map<String, dynamic>>.from(raw['dataPoints']);
  }

  Future<List<Map<String, dynamic>>> getInstitutionalHolders(String symbol) async {
    try {
      final response = await _dio.get(
        '/v10/finance/quoteSummary/$symbol',
        queryParameters: {'modules': 'institutionOwnership'},
      );
      final holders =
          response.data['quoteSummary']['result'][0]['institutionOwnership']
                  ?['ownershipList'] as List? ??
              [];

      return holders.map((h) {
        return {
          'symbol': symbol.toUpperCase(),
          'holderName': h['organization']?.toString() ?? 'Unknown',
          'shares': (h['position']?['raw'] as num?)?.toDouble() ?? 0,
          'value': (h['value']?['raw'] as num?)?.toDouble() ?? 0,
          'percentOut':
              (h['pctHeld']?['raw'] as num?)?.toDouble() ?? 0,
          'reportDate': DateTime.fromMillisecondsSinceEpoch(
            ((h['reportDate']?['raw'] as num?) ?? 0).toInt() * 1000,
          ),
          'change': (h['pctChange']?['raw'] as num?)?.toDouble(),
        };
      }).toList();
    } on DioException {
      return [];
    } catch (_) {
      return [];
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

  /// Options chain summary for nearest expiry.
  Future<Map<String, dynamic>?> getOptionsSummary(String symbol) async {
    try {
      final response = await _dio.get('/v7/finance/options/$symbol');
      final result = response.data['optionChain']?['result'] as List?;
      if (result == null || result.isEmpty) return null;

      final chain = result[0] as Map<String, dynamic>;
      final expiries = List<String>.from(chain['expirationDates'] ?? []);
      if (expiries.isEmpty) return null;

      final options = chain['options'] as List?;
      if (options == null || options.isEmpty) return null;

      final nearest = options[0] as Map<String, dynamic>;
      final calls = List<Map<String, dynamic>>.from(nearest['calls'] ?? []);
      final puts = List<Map<String, dynamic>>.from(nearest['puts'] ?? []);

      int sumVol(List<Map<String, dynamic>> rows) =>
          rows.fold(0, (s, r) => s + ((r['volume'] as num?)?.toInt() ?? 0));
      int sumOi(List<Map<String, dynamic>> rows) =>
          rows.fold(0, (s, r) => s + ((r['openInterest'] as num?)?.toInt() ?? 0));

      final callVol = sumVol(calls);
      final putVol = sumVol(puts);
      final callOi = sumOi(calls);
      final putOi = sumOi(puts);

      final pcVol = callVol > 0 ? putVol / callVol : null;
      final pcOi = callOi > 0 ? putOi / callOi : null;

      String sentiment = 'neutral';
      if (pcVol != null) {
        if (pcVol > 1.2) {
          sentiment = 'bearish';
        } else if (pcVol < 0.7) {
          sentiment = 'bullish';
        }
      }

      final ivs = <double>[];
      for (final row in [...calls, ...puts]) {
        final iv = (row['impliedVolatility'] as num?)?.toDouble();
        if (iv != null && iv > 0) ivs.add(iv);
      }
      double? ivRank;
      if (ivs.length >= 3) {
        ivs.sort();
        final current = ivs[ivs.length ~/ 2];
        final minIv = ivs.first;
        final maxIv = ivs.last;
        ivRank = maxIv == minIv ? 50.0 : ((current - minIv) / (maxIv - minIv)) * 100;
      }

      final unusual = <Map<String, dynamic>>[];
      for (final row in [...calls.map((c) => {...c, 'type': 'call'}), ...puts.map((p) => {...p, 'type': 'put'})]) {
        final vol = (row['volume'] as num?)?.toInt() ?? 0;
        final oi = (row['openInterest'] as num?)?.toInt() ?? 0;
        if (oi > 0 && vol > 2 * oi && vol >= 100) {
          unusual.add({
            'type': row['type'],
            'strike': (row['strike'] as num).toDouble(),
            'volume': vol,
            'open_interest': oi,
            'vol_oi_ratio': vol / oi,
            'implied_volatility':
                ((row['impliedVolatility'] as num?) ?? 0).toDouble() * 100,
          });
        }
      }
      unusual.sort((a, b) =>
          (b['vol_oi_ratio'] as double).compareTo(a['vol_oi_ratio'] as double));

      return {
        'ticker': symbol.toUpperCase(),
        'expiry': expiries.first,
        'total_expiries': expiries.length,
        'call_volume': callVol,
        'put_volume': putVol,
        'total_volume': callVol + putVol,
        'call_oi': callOi,
        'put_oi': putOi,
        'pc_ratio_volume': pcVol,
        'pc_ratio_oi': pcOi,
        'iv_rank': ivRank,
        'sentiment': sentiment,
        'unusual_activity': unusual.take(10).toList(),
        'fetched_at': DateTime.now().toIso8601String(),
      };
    } on DioException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
