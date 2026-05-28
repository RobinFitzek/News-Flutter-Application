import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class JournalRepository {
  Future<List<JournalEntryData>> getAll();
  Future<List<JournalEntryData>> getOpen();
  Future<JournalEntryData> add(JournalEntryData entry);
  Future<void> update(JournalEntryData entry);
  Future<void> close(int id, {required double exitPrice, required DateTime exitDate, required double pnl});
  Future<void> delete(int id);
}

class JournalRepositoryImpl implements JournalRepository {
  JournalRepositoryImpl(this.db);
  final AppDatabase db;

  @override
  Future<List<JournalEntryData>> getAll() async {
    return (db.select(db.journalEntries)..orderBy([(t) => OrderingTerm.desc(t.entryDate)])).get();
  }

  @override
  Future<List<JournalEntryData>> getOpen() async {
    return (db.select(db.journalEntries)..where((t) => t.isClosed.equals(false))..orderBy([(t) => OrderingTerm.desc(t.entryDate)])).get();
  }

  @override
  Future<JournalEntryData> add(JournalEntryData entry) async {
    final id = await db.into(db.journalEntries).insert(entry.toCompanion(true));
    return (db.select(db.journalEntries)..where((t) => t.id.equals(id))).getSingle();
  }

  @override
  Future<void> update(JournalEntryData entry) async {
    await (db.update(db.journalEntries)..where((t) => t.id.equals(entry.id))).write(entry.toCompanion(true));
  }

  @override
  Future<void> close(int id, {required double exitPrice, required DateTime exitDate, required double pnl}) async {
    await (db.update(db.journalEntries)..where((t) => t.id.equals(id))).write(JournalEntriesCompanion(
      exitPrice: Value(exitPrice),
      exitDate: Value(exitDate),
      pnl: Value(pnl),
      isClosed: const Value(true),
    ));
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.journalEntries)..where((t) => t.id.equals(id))).go();
  }
}

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return JournalRepositoryImpl(db);
});
