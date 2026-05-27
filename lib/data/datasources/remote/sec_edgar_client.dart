import 'package:dio/dio.dart';

/// SEC EDGAR client — fetches and parses Form 4 insider filings.
class SecEdgarClient {
  SecEdgarClient()
      : _secDio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'User-Agent': 'StockholmApp/1.0 (contact@stockholm.app)',
            'Accept': 'application/json',
          },
        ));

  final Dio _secDio;
  static const _rateLimit = Duration(milliseconds: 150);

  Future<List<Map<String, dynamic>>> getInsiderTransactions(
    String symbol, {
    int daysBack = 180,
    int limit = 15,
  }) async {
    final cik = await _getCik(symbol);
    if (cik == null) return [];

    await Future<void>.delayed(_rateLimit);

    try {
      final response = await _secDio.get(
        'https://data.sec.gov/submissions/CIK$cik.json',
      );
      final filings = response.data['filings']?['recent'];
      if (filings == null) return [];

      final forms = List<String>.from(
        (filings['form'] as List?)?.map((e) => e.toString()) ?? [],
      );
      final accessionNumbers =
          List<String>.from(filings['accessionNumber'] as List? ?? []);
      final primaryDocs =
          List<String>.from(filings['primaryDocument'] as List? ?? []);
      final filingDates =
          List<String>.from(filings['filingDate'] as List? ?? []);

      final cutoff = DateTime.now().subtract(Duration(days: daysBack));
      final results = <Map<String, dynamic>>[];
      final cikInt = int.parse(cik).toString();

      for (var i = 0; i < forms.length && results.length < limit; i++) {
        final form = forms[i];
        if (form != '4' && form != '4/A') continue;

        final filingDate = DateTime.tryParse(filingDates[i]) ?? DateTime.now();
        if (filingDate.isBefore(cutoff)) continue;

        final accession = accessionNumbers[i].replaceAll('-', '');
        final doc = primaryDocs[i];
        final xmlUrl =
            'https://www.sec.gov/Archives/edgar/data/$cikInt/$accession/$doc';

        await Future<void>.delayed(_rateLimit);
        final parsed = await _parseForm4Xml(symbol, xmlUrl, filingDate);
        if (parsed != null) results.add(parsed);
      }

      return results;
    } catch (_) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> _parseForm4Xml(
    String symbol,
    String xmlUrl,
    DateTime filingDate,
  ) async {
    try {
      final response = await _secDio.get(
        xmlUrl,
        options: Options(responseType: ResponseType.plain),
      );
      final xml = response.data as String;

      final insiderName = _extractTag(xml, 'rptOwnerName') ?? 'Unknown Insider';
      final title = _extractTag(xml, 'officerTitle') ??
          _extractTag(xml, 'directorTitle') ??
          'Insider';

      final txnBlock = _firstMatch(xml, r'<nonDerivativeTransaction>[\s\S]*?</nonDerivativeTransaction>') ??
          _firstMatch(xml, r'<derivativeTransaction>[\s\S]*?</derivativeTransaction>');
      if (txnBlock == null) return null;

      final txnCode = _extractTag(txnBlock, 'transactionCode') ?? '';
      final shares = _extractNumber(txnBlock, 'transactionShares') ??
          _extractNumber(txnBlock, 'sharesOwnedFollowingTransaction') ??
          0;
      final price = _extractNumber(txnBlock, 'transactionPricePerShare') ?? 0;
      final txnDateStr = _extractTag(txnBlock, 'transactionDate');
      final txnDate = txnDateStr != null
          ? DateTime.tryParse(txnDateStr.split('T').first) ?? filingDate
          : filingDate;

      final txnType = _interpretTransactionCode(txnCode);
      final value = shares * price;

      return {
        'symbol': symbol.toUpperCase(),
        'insiderName': insiderName,
        'title': title,
        'type': txnType,
        'transaction_code': txnCode,
        'shares': shares,
        'price': price,
        'totalValue': value,
        'filingDate': filingDate,
        'transactionDate': txnDate,
        'is_voluntary_purchase': txnCode == 'P',
      };
    } catch (_) {
      return null;
    }
  }

  String? _extractTag(String xml, String tag) {
    final match = RegExp('<$tag[^>]*>([^<]+)</$tag>', caseSensitive: false)
        .firstMatch(xml);
    return match?.group(1)?.trim();
  }

  double? _extractNumber(String xml, String tag) {
    final text = _extractTag(xml, tag);
    if (text == null) return null;
    return double.tryParse(text.replaceAll(',', ''));
  }

  String? _firstMatch(String text, String pattern) {
    return RegExp(pattern, caseSensitive: false).firstMatch(text)?.group(0);
  }

  String _interpretTransactionCode(String code) {
    switch (code.toUpperCase()) {
      case 'P':
        return 'PURCHASE';
      case 'S':
        return 'SALE';
      case 'A':
        return 'AWARD';
      case 'M':
        return 'EXERCISE';
      case 'G':
        return 'GIFT';
      default:
        return code.isEmpty ? 'OTHER' : code;
    }
  }

  Future<String?> _getCik(String symbol) async {
    try {
      final response = await _secDio.get(
        'https://www.sec.gov/files/company_tickers.json',
      );
      final data = response.data as Map<String, dynamic>;
      for (final entry in data.values) {
        if (entry['ticker']?.toString().toUpperCase() == symbol.toUpperCase()) {
          return entry['cik_str'].toString().padLeft(10, '0');
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
