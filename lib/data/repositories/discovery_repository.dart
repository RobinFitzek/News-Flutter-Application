import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class DiscoveryRepository {
  Future<List<DiscoveryData>> getAll();
  Future<List<DiscoveryData>> getActive();
  Future<void> saveAll(List<DiscoveryData> discoveries);
  Future<void> promote(int id);
  Future<void> dismiss(int id);
  Future<void> clearAll();
}

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  DiscoveryRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<DiscoveryData>> getAll() async {
    return (db.select(db.discoveries)
          ..orderBy([(t) => OrderingTerm.desc(t.discoveredAt)]))
        .get();
  }

  @override
  Future<List<DiscoveryData>> getActive() async {
    return (db.select(db.discoveries)
          ..where((t) => t.isDismissed.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.discoveredAt)]))
        .get();
  }

  @override
  Future<void> saveAll(List<DiscoveryData> discoveries) async {
    await db.batch((batch) {
      for (final d in discoveries) {
        batch.insert(db.discoveries, d, mode: InsertMode.insertOrReplace);
      }
    });
  }

  @override
  Future<void> promote(int id) async {
    await (db.update(db.discoveries)..where((t) => t.id.equals(id)))
        .write(const DiscoveriesCompanion(isPromoted: Value(true)));
  }

  @override
  Future<void> dismiss(int id) async {
    await (db.update(db.discoveries)..where((t) => t.id.equals(id)))
        .write(const DiscoveriesCompanion(isDismissed: Value(true)));
  }

  @override
  Future<void> clearAll() async {
    await db.delete(db.discoveries).go();
  }
}

final discoveryRepositoryProvider = Provider<DiscoveryRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DiscoveryRepositoryImpl(db);
});
