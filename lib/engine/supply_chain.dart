import 'dart:convert';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/provider_factory.dart';
import '../data/repositories/provider_repository.dart';
import '../models/stage_assignment.dart';

/// Supply chain mapping via Perplexity — mirrors supply_chain.py.
class SupplyChainMapper {
  SupplyChainMapper(
    this._db, {
    ProviderRepository? providerRepo,
  }) : _providerRepo = providerRepo;

  final AppDatabase _db;
  final ProviderRepository? _providerRepo;
  static const cacheDays = 90;

  static const _prompt = '''
What are the top 5 suppliers and top 3 key customers of {company} ({ticker})?
For each, provide: company name, their ticker symbol if publicly traded, and relationship type (supplier/customer).

Respond ONLY as a JSON array with objects:
[
  {{"company_name": "...", "ticker": "..." or null, "relationship_type": "supplier"|"customer", "description": "..."}},
  ...
]
Do not include any explanation outside the JSON array.
''';

  Future<Map<String, dynamic>> getSupplyChain(
    String ticker, {
    String? companyName,
    bool forceRefresh = false,
  }) async {
    ticker = ticker.toUpperCase();
    if (!forceRefresh && await _isCached(ticker)) {
      return _getCachedSupplyChain(ticker);
    }

    final entries = await _fetchSupplyChain(ticker, companyName);
    if (entries.isNotEmpty) {
      await _saveSupplyChain(ticker, entries);
    }
    return _getCachedSupplyChain(ticker);
  }

  Future<List<Map<String, dynamic>>> getGeoElevatedTickers(
    List<String> flaggedRegions,
  ) async {
    if (flaggedRegions.isEmpty) return [];

    final regionKeywords = flaggedRegions.map((r) => r.toLowerCase()).toList();
    final tickers = await (_db.selectOnly(_db.supplyChainEntries)
          ..addColumns([_db.supplyChainEntries.ticker])
          ..where(_db.supplyChainEntries.relationshipType.equals('supplier')))
        .map((row) => row.read(_db.supplyChainEntries.ticker)!)
        .get();
    final uniqueTickers = tickers.toSet();

    final elevated = <Map<String, dynamic>>[];
    for (final ticker in uniqueTickers) {
      final suppliers = await (_db.select(_db.supplyChainEntries)
            ..where((t) =>
                t.ticker.equals(ticker) &
                t.relationshipType.equals('supplier')))
          .get();
      for (final s in suppliers) {
        final text = '${s.companyName} ${s.description ?? ''}'.toLowerCase();
        if (regionKeywords.any(text.contains)) {
          elevated.add({
            'ticker': ticker,
            'reason': "Supplier '${s.companyName}' in flagged region",
            'geo_risk_elevation': 2,
          });
          break;
        }
      }
    }
    return elevated;
  }

  Future<int> refreshStaleTickers(List<Map<String, String>> watchlist) async {
    final cutoff = DateTime.now().subtract(const Duration(days: cacheDays));
    final recent = await (_db.selectOnly(_db.supplyChainEntries)
          ..addColumns([_db.supplyChainEntries.ticker])
          ..where(_db.supplyChainEntries.cachedAt.isBiggerOrEqualValue(cutoff)))
        .map((row) => row.read(_db.supplyChainEntries.ticker)!)
        .get();
    final cachedRecent = recent.toSet();

    var refreshed = 0;
    for (final row in watchlist) {
      final ticker = row['ticker']!.toUpperCase();
      if (cachedRecent.contains(ticker)) continue;
      final entries = await _fetchSupplyChain(ticker, row['company_name']);
      if (entries.isNotEmpty) {
        await _saveSupplyChain(ticker, entries);
        refreshed++;
      }
    }
    return refreshed;
  }

  Future<bool> _isCached(String ticker) async {
    final cutoff = DateTime.now().subtract(const Duration(days: cacheDays));
    final row = await (_db.select(_db.supplyChainEntries)
          ..where((t) =>
              t.ticker.equals(ticker) &
              t.cachedAt.isBiggerOrEqualValue(cutoff))
          ..limit(1))
        .getSingleOrNull();
    return row != null;
  }

  Future<List<Map<String, dynamic>>> _fetchSupplyChain(
    String ticker,
    String? companyName,
  ) async {
    if (_providerRepo == null) return [];

    try {
      final provider = await _providerRepo.getByStage(AnalysisStage.newsResearch);
      if (provider == null || provider.apiKey.isEmpty) return [];

      final client = ProviderFactory.createFromData(provider);
      final name = companyName ?? ticker;
      final prompt = _prompt
          .replaceAll('{company}', name)
          .replaceAll('{ticker}', ticker);
      final response = await client.generateText(prompt);
      if (response.trim().isEmpty) return [];

      final match = RegExp(r'\[.*\]', dotAll: true).firstMatch(response);
      if (match == null) return [];

      final raw = jsonDecode(match.group(0)!);
      if (raw is! List) return [];

      final validated = <Map<String, dynamic>>[];
      for (final item in raw) {
        if (item is! Map) continue;
        final company = item['company_name']?.toString();
        final rel = item['relationship_type']?.toString();
        if (company == null || rel == null) continue;
        validated.add({
          'company_name': company.length > 200 ? company.substring(0, 200) : company,
          'related_ticker': item['ticker']?.toString(),
          'relationship_type': rel.length > 20 ? rel.substring(0, 20) : rel,
          'description': item['description']?.toString(),
        });
      }
      return validated.take(8).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveSupplyChain(
    String ticker,
    List<Map<String, dynamic>> entries,
  ) async {
    final now = DateTime.now();
    for (final e in entries) {
      await _db.into(_db.supplyChainEntries).insertOnConflictUpdate(
            SupplyChainEntriesCompanion.insert(
              ticker: ticker,
              relatedTicker: Value(e['related_ticker']?.toString()),
              companyName: e['company_name'] as String,
              relationshipType: e['relationship_type'] as String,
              description: Value(e['description']?.toString()),
              cachedAt: Value(now),
            ),
          );
    }
  }

  Future<Map<String, dynamic>> _getCachedSupplyChain(String ticker) async {
    final rows = await (_db.select(_db.supplyChainEntries)
          ..where((t) => t.ticker.equals(ticker))
          ..orderBy([(t) => OrderingTerm.asc(t.relationshipType)]))
        .get();

    final suppliers = rows
        .where((r) => r.relationshipType == 'supplier')
        .map((r) => _entryMap(r))
        .toList();
    final customers = rows
        .where((r) => r.relationshipType == 'customer')
        .map((r) => _entryMap(r))
        .toList();
    final partners = rows
        .where((r) => r.relationshipType == 'partner')
        .map((r) => _entryMap(r))
        .toList();

    return {
      'ticker': ticker,
      'suppliers': suppliers,
      'customers': customers,
      'partners': partners,
      'cached_at': rows.isNotEmpty ? rows.first.cachedAt.toIso8601String() : null,
      'source': rows.isEmpty ? 'empty' : 'cache',
    };
  }

  Map<String, dynamic> _entryMap(SupplyChainEntryData row) => {
        'company_name': row.companyName,
        'related_ticker': row.relatedTicker,
        'relationship_type': row.relationshipType,
        'description': row.description,
        'cached_at': row.cachedAt.toIso8601String(),
      };
}
