import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../datasources/local/database_datasource.dart';
import '../../engine/geopolitical_scanner.dart';
import 'provider_repository.dart';

abstract class GeopoliticalRepository {
  Future<GeopoliticalEventData?> getLatestScan();
  Future<List<GeopoliticalEventData>> getHistory({int limit = 10});
  Future<GeopoliticalEventData> runScan();
  Future<List<Map<String, dynamic>>> getWatchlistExposure(List<String> symbols);
}

class GeopoliticalRepositoryImpl implements GeopoliticalRepository {
  GeopoliticalRepositoryImpl(this.db, this.providerRepo);

  final AppDatabase db;
  final ProviderRepository providerRepo;

  @override
  Future<GeopoliticalEventData?> getLatestScan() async {
    return GeopoliticalScanner(db, providerRepo: providerRepo)
        .getLatestScan();
  }

  @override
  Future<List<GeopoliticalEventData>> getHistory({int limit = 10}) async {
    return (db.select(db.geopoliticalEvents)
          ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)])
          ..limit(limit))
        .get();
  }

  @override
  Future<GeopoliticalEventData> runScan() async {
    return GeopoliticalScanner(db, providerRepo: providerRepo).runScan();
  }

  @override
  Future<List<Map<String, dynamic>>> getWatchlistExposure(
      List<String> symbols) async {
    return GeopoliticalScanner(db).getWatchlistExposure(symbols);
  }
}

final geopoliticalRepositoryProvider = Provider<GeopoliticalRepository>((ref) {
  return GeopoliticalRepositoryImpl(
    ref.watch(databaseProvider),
    ref.watch(providerRepositoryProvider),
  );
});
