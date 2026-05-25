import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class DatabaseDataSource {
  DatabaseDataSource({required this.db});

  final AppDatabase db;

  Future<String?> getSetting(String key) async {
    final query = db.select(db.userSettings);
    final settings = await query.getSingleOrNull();
    if (settings == null) return null;
    switch (key) {
      case 'themeMode':
        return settings.themeMode;
      case 'geminiApiKey':
        return settings.geminiApiKey;
      case 'perplexityApiKey':
        return settings.perplexityApiKey;
      default:
        return null;
    }
  }

  Future<void> setSetting(String key, String value) async {
    final query = db.select(db.userSettings);
    final existing = await query.getSingleOrNull();

    if (existing == null) {
      await db.into(db.userSettings).insert(
            UserSettingsCompanion(
              geminiApiKey: Value(key == 'geminiApiKey' ? value : null),
              perplexityApiKey:
                  Value(key == 'perplexityApiKey' ? value : null),
              themeMode: Value(key == 'themeMode' ? value : 'system'),
            ),
          );
    } else {
      final companion = UserSettingsCompanion(
        id: Value(existing.id),
        geminiApiKey: Value(
          key == 'geminiApiKey' ? value : existing.geminiApiKey,
        ),
        perplexityApiKey: Value(
          key == 'perplexityApiKey' ? value : existing.perplexityApiKey,
        ),
        themeMode: Value(
          key == 'themeMode' ? value : existing.themeMode,
        ),
      );
      await db.update(db.userSettings).replace(companion);
    }
  }

  Future<String?> getApiKey(String service) async {
    final row = await (db.select(db.apiKeys)
          ..where((t) => t.service.equals(service)))
        .getSingleOrNull();
    return row?.keyValue;
  }

  Future<void> setApiKey(String service, String value) async {
    final existing = await (db.select(db.apiKeys)
          ..where((t) => t.service.equals(service)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.update(db.apiKeys)
            ..where((t) => t.id.equals(existing.id)))
          .write(ApiKeysCompanion(keyValue: Value(value)));
    } else {
      await db.into(db.apiKeys).insert(
            ApiKeysCompanion(
              service: Value(service),
              keyValue: Value(value),
              createdAt: Value(DateTime.now()),
            ),
          );
    }
  }
}

final databaseDataSourceProvider = Provider<DatabaseDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return DatabaseDataSource(db: db);
});
