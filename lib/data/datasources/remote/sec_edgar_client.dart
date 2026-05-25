import 'package:dio/dio.dart';

class SecEdgarClient {
  final Dio _dio;

  SecEdgarClient()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://data.sec.gov',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'User-Agent': 'AIStockPrediction/1.0 (robin.fitzek@gmail.com)',
            'Accept': 'application/json',
          },
        ));

  Future<List<Map<String, dynamic>>> getInsiderTransactions(String symbol, {int limit = 10}) async {
    try {
      final cik = await _getCik(symbol);
      if (cik == null) return [];

      final response = await _dio.get(
        '/submissions/CIK$cik.json',
      );

      final data = response.data;
      final filings = data['filings']?['recent'];
      if (filings == null) return [];

      final forms = filings['form'] as List? ?? [];
      final primaryDocs = filings['primaryDocument'] as List? ?? [];
      final filingDates = filings['filingDate'] as List? ?? [];
      final descriptions = filings['primaryDocDescription'] as List? ?? [];

      final results = <Map<String, dynamic>>[];
      for (int i = 0; i < forms.length && results.length < limit; i++) {
        final form = forms[i]?.toString() ?? '';
        if (form == '4' || form == '3' || form == '4/A') {
          results.add({
            'symbol': symbol.toUpperCase(),
            'insiderName': descriptions[i]?.toString() ?? 'Insider Filing',
            'title': '',
            'type': form.contains('4') ? 'TRANSACTION' : 'INITIAL',
            'shares': 0.0,
            'price': 0.0,
            'totalValue': 0.0,
            'filingDate': DateTime.tryParse(filingDates[i]?.toString() ?? '') ?? DateTime.now(),
            'transactionDate': DateTime.tryParse(filingDates[i]?.toString() ?? '') ?? DateTime.now(),
          });
        }
      }
      return results;
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getInstitutionalHolders(String symbol, {int limit = 10}) async {
    try {
      final cik = await _getCik(symbol);
      if (cik == null) return [];

      final response = await _dio.get(
        '/submissions/CIK$cik.json',
      );

      final data = response.data;
      final facts = data['facts'];
      if (facts == null) return [];

      final holders = <Map<String, dynamic>>[];
      final usGaap = facts['us-gaap'];
      if (usGaap == null) return [];

      return holders;
    } catch (e) {
      return [];
    }
  }

  Future<String?> _getCik(String symbol) async {
    try {
      final response = await _dio.get(
        'https://www.sec.gov/files/company_tickers.json',
        options: Options(headers: {'User-Agent': 'AIStockPrediction/1.0 (robin.fitzek@gmail.com)'}),
      );
      final data = response.data as Map<String, dynamic>;
      for (final entry in data.values) {
        if (entry['ticker']?.toString().toUpperCase() == symbol.toUpperCase()) {
          final cik = entry['cik_str'].toString();
          return cik.padLeft(10, '0');
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
