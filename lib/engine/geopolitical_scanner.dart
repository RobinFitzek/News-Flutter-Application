import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/provider_factory.dart';
import '../data/repositories/provider_repository.dart';
import '../engine/supply_chain.dart';
import '../models/stage_assignment.dart';

/// Geopolitical scan + parser — mirrors perplexity geo scan + scheduler.
class GeopoliticalScanner {
  GeopoliticalScanner(this._db, {ProviderRepository? providerRepo})
      : _providerRepo = providerRepo;

  final AppDatabase _db;
  final ProviderRepository? _providerRepo;

  Future<GeopoliticalEventData?> getLatestScan({Duration maxAge = const Duration(hours: 24)}) async {
    final row = await (_db.select(_db.geopoliticalEvents)
          ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    if (DateTime.now().difference(row.scannedAt) > maxAge) return null;
    return row;
  }

  Future<GeopoliticalEventData> runScan({ProviderRepository? providerRepo}) async {
    final repo = providerRepo ?? _providerRepo;
    if (repo == null) {
      throw Exception('No provider repository configured');
    }

    final provider = await repo.getByStage(AnalysisStage.newsResearch);
    if (provider == null || provider.apiKey.isEmpty) {
      throw Exception('Configure a news research provider in Settings');
    }

    final client = ProviderFactory.createFromData(provider);
    final raw = await client.generateText(
      'Geopolitischer Markt-Scan (Deutsch). Format:\n'
      'SCHWEREGRAD: [1-10]\n'
      'ZUSAMMENFASSUNG: [2-3 Sätze]\n'
      'EREIGNISSE:\n'
      '- [Headline] | Region: [Region] | SCHWEREGRAD: [1-10]\n'
      'Cover trade wars, central banks, regional conflicts affecting equities.',
    );

    final parsed = parseGeoText(raw);
    final id = await _db.into(_db.geopoliticalEvents).insert(
          GeopoliticalEventsCompanion.insert(
            severity: Value(parsed['severity'] as int),
            summary: parsed['summary'] as String,
            rawSummary: Value(raw),
          ),
        );

    return (await (_db.select(_db.geopoliticalEvents)
          ..where((t) => t.id.equals(id)))
        .getSingle());
  }

  Future<List<Map<String, dynamic>>> getWatchlistExposure(
    List<String> symbols,
  ) async {
    if (symbols.isEmpty) return [];

    final exposures = <Map<String, dynamic>>[];
    for (final symbol in symbols.take(12)) {
      final analysis = await (_db.select(_db.analysisResults)
            ..where((t) => t.symbol.equals(symbol.toUpperCase()))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(1))
          .getSingleOrNull();

      exposures.add({
        'ticker': symbol.toUpperCase(),
        'geo_risk_score': analysis?.geoRiskScore ?? 5,
        'geopolitical_context': analysis?.geopoliticalContext ?? '',
        'timestamp': analysis?.createdAt.toIso8601String(),
      });
    }

    final latest = await getLatestScan();
    if (latest != null) {
      final parsed = parseGeoText(
        latest.rawSummary.isNotEmpty ? latest.rawSummary : latest.summary,
      );
      final events = parsed['events'] as List? ?? [];
      final regions = events
          .map((e) => (e as Map)['region']?.toString() ?? '')
          .where((r) => r.isNotEmpty)
          .toList();
      if (regions.isNotEmpty) {
        final elevated = await SupplyChainMapper(_db).getGeoElevatedTickers(regions);
        for (final e in elevated) {
          final ticker = e['ticker'] as String;
          final idx = exposures.indexWhere((x) => x['ticker'] == ticker);
          if (idx >= 0) {
            final current = exposures[idx]['geo_risk_score'] as int? ?? 5;
            exposures[idx]['geo_risk_score'] =
                (current + (e['geo_risk_elevation'] as int? ?? 2)).clamp(1, 10);
            exposures[idx]['supply_chain_elevation'] = e['reason'];
          }
        }
      }
    }

    return exposures;
  }

  static Map<String, dynamic> parseGeoText(String raw) {
    var severity = 5;
    final severityMatch =
        RegExp(r'SCHWEREGRAD:\s*(\d+)', caseSensitive: false).firstMatch(raw);
    if (severityMatch != null) {
      severity = int.tryParse(severityMatch.group(1)!)?.clamp(1, 10) ?? 5;
    }

    var summary = raw.trim();
    final summaryMatch = RegExp(
      r'ZUSAMMENFASSUNG:\s*(.+?)(?:\nEREIGNISSE|\n\n|$)',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(raw);
    if (summaryMatch != null) {
      summary = summaryMatch.group(1)!.trim();
    } else if (summary.length > 400) {
      summary = '${summary.substring(0, 397)}...';
    }

    final events = <Map<String, dynamic>>[];
    final eventPattern = RegExp(
      r'-\s*(.+?)\s*\|\s*Region:\s*(.+?)\s*\|\s*SCHWEREGRAD:\s*(\d+)',
      caseSensitive: false,
    );
    for (final match in eventPattern.allMatches(raw)) {
      events.add({
        'headline': match.group(1)!.trim(),
        'region': match.group(2)!.trim(),
        'severity': int.tryParse(match.group(3)!) ?? 5,
      });
    }

    return {
      'severity': severity,
      'summary': summary,
      'events': events,
    };
  }
}
