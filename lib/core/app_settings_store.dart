import 'package:drift/drift.dart';

import '../data/database/app_database.dart';

/// Key-value settings backed by [AppSettings] table.
class AppSettingsStore {
  AppSettingsStore(this._db);

  final AppDatabase _db;

  Future<String?> get(String key) async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> set(String key, String? value) async {
    if (value == null) {
      await (_db.delete(_db.appSettings)..where((t) => t.key.equals(key))).go();
      return;
    }
    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.appSettings)..where((t) => t.id.equals(existing.id)))
          .write(AppSettingsCompanion(value: Value(value)));
    } else {
      await _db.into(_db.appSettings).insert(
            AppSettingsCompanion.insert(key: key, value: value),
          );
    }
  }

  Future<double> getDouble(String key, double defaultValue) async {
    final v = await get(key);
    return double.tryParse(v ?? '') ?? defaultValue;
  }

  Future<int> getInt(String key, int defaultValue) async {
    final v = await get(key);
    return int.tryParse(v ?? '') ?? defaultValue;
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final v = await get(key);
    if (v == null) return defaultValue;
    return v == 'true' || v == '1';
  }

  Future<void> setBool(String key, bool value) => set(key, value.toString());

  Future<void> setDouble(String key, double value) => set(key, value.toString());

  Future<void> setInt(String key, int value) => set(key, value.toString());
}
