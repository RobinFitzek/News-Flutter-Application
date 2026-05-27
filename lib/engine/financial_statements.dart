import 'dart:convert';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Financial statements, DCF, peers — mirrors News/engine/financial_statements.py.
class FinancialStatements {
  FinancialStatements(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  static const cacheHours = 24;

  Future<Map<String, dynamic>> getQuarterlyFinancials(String ticker) async {
    final cached = await _getCached(ticker, 'quarterly');
    if (cached != null) return cached;

    try {
      final info = await _yahoo.getStockInfo(ticker);
      final revenueGrowth =
          (info['revenueGrowth'] as num?)?.toDouble();
      final profitMargin =
          (info['profitMargins'] as num?)?.toDouble();
      final eps = (info['trailingEps'] as num?)?.toDouble();

      final result = {
        'ticker': ticker.toUpperCase(),
        'available': revenueGrowth != null || eps != null,
        'revenue_growth_pct': revenueGrowth != null
            ? double.parse((revenueGrowth * 100).toStringAsFixed(2))
            : null,
        'profit_margin_pct': profitMargin != null
            ? double.parse((profitMargin * 100).toStringAsFixed(2))
            : null,
        'eps': eps,
        'pe_ratio': info['trailingPE'],
        'market_cap': info['marketCap'],
        'fetched_at': DateTime.now().toIso8601String(),
      };

      await _setCached(ticker, 'quarterly', result);
      return result;
    } catch (e) {
      return {
        'ticker': ticker.toUpperCase(),
        'available': false,
        'reason': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> estimateDcf(String ticker) async {
    final cached = await _getCached(ticker, 'dcf');
    if (cached != null) return cached;

    try {
      final info = await _yahoo.getStockInfo(ticker);
      final fcf = (info['freeCashflow'] as num?)?.toDouble();
      final shares = (info['sharesOutstanding'] as num?)?.toDouble();
      final growth = ((info['earningsGrowth'] as num?)?.toDouble() ?? 0.05)
          .clamp(-0.05, 0.15);
      const discount = 0.10;
      const terminal = 0.03;

      if (fcf == null || shares == null || shares <= 0) {
        return {'available': false, 'reason': 'Insufficient FCF data'};
      }

      var pv = 0.0;
      var projected = fcf;
      for (var year = 1; year <= 5; year++) {
        projected *= (1 + growth);
        pv += projected / pow1(discount, year);
      }
      final terminalValue = projected * (1 + terminal) / (discount - terminal);
      pv += terminalValue / pow1(discount, 5);
      final fairValue = pv / shares;
      final price = (info['currentPrice'] as num?)?.toDouble() ?? 0;
      final upside =
          price > 0 ? ((fairValue - price) / price) * 100 : null;

      final result = {
        'available': true,
        'fair_value': double.parse(fairValue.toStringAsFixed(2)),
        'current_price': price,
        'upside_pct': upside != null
            ? double.parse(upside.toStringAsFixed(2))
            : null,
        'assumptions': {
          'growth_rate': growth,
          'discount_rate': discount,
          'terminal_growth': terminal,
        },
      };
      await _setCached(ticker, 'dcf', result);
      return result;
    } catch (e) {
      return {'available': false, 'reason': e.toString()};
    }
  }

  double pow1(double base, int exp) {
    var r = 1.0;
    for (var i = 0; i < exp; i++) {
      r *= base;
    }
    return r;
  }

  Future<List<Map<String, dynamic>>> getPeers(
    String ticker, {
    List<String>? peerTickers,
  }) async {
    final info = await _yahoo.getStockInfo(ticker);
    final sector = info['sector']?.toString() ?? '';
    final peers = peerTickers ??
        _defaultPeers(sector, ticker.toUpperCase());

    final results = <Map<String, dynamic>>[];
    for (final p in peers) {
      try {
        final pi = await _yahoo.getStockInfo(p);
        results.add({
          'symbol': p,
          'pe_ratio': pi['trailingPE'],
          'market_cap': pi['marketCap'],
          'revenue_growth': pi['revenueGrowth'],
          'profit_margin': pi['profitMargins'],
        });
      } catch (_) {}
    }
    return results;
  }

  List<String> _defaultPeers(String sector, String exclude) {
    const bySector = {
      'Technology': ['MSFT', 'GOOGL', 'META', 'NVDA'],
      'Healthcare': ['JNJ', 'UNH', 'PFE', 'ABBV'],
      'Financial Services': ['JPM', 'BAC', 'WFC', 'GS'],
      'Consumer Cyclical': ['AMZN', 'TSLA', 'HD', 'NKE'],
    };
    return (bySector[sector] ?? ['SPY', 'QQQ', 'IWM', 'DIA'])
        .where((s) => s != exclude)
        .take(4)
        .toList();
  }

  Future<Map<String, dynamic>?> _getCached(String ticker, String type) async {
    final cutoff = DateTime.now().subtract(const Duration(hours: cacheHours));
    final row = await (_db.select(_db.financialCache)
          ..where((t) =>
              t.symbol.equals(ticker.toUpperCase()) &
              t.dataType.equals(type) &
              t.fetchedAt.isBiggerOrEqualValue(cutoff)))
        .getSingleOrNull();
    if (row == null) return null;
    return Map<String, dynamic>.from(jsonDecode(row.dataJson) as Map);
  }

  Future<void> _setCached(
    String ticker,
    String type,
    Map<String, dynamic> data,
  ) async {
    await _db.into(_db.financialCache).insertOnConflictUpdate(
          FinancialCacheCompanion.insert(
            symbol: ticker.toUpperCase(),
            dataType: type,
            dataJson: jsonEncode(data),
            fetchedAt: Value(DateTime.now()),
          ),
        );
  }
}
