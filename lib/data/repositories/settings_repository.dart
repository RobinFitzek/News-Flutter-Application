import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/local/database_datasource.dart';

class SettingsRepository {
  SettingsRepository({required this.dataSource});

  final DatabaseDataSource dataSource;

  Future<String?> getGeminiKey() => dataSource.getSetting('geminiApiKey');

  Future<void> setGeminiKey(String key) =>
      dataSource.setSetting('geminiApiKey', key);

  Future<String?> getPerplexityKey() => dataSource.getSetting('perplexityApiKey');

  Future<void> setPerplexityKey(String key) =>
      dataSource.setSetting('perplexityApiKey', key);

  Future<String?> getThemeMode() => dataSource.getSetting('themeMode');

  Future<void> setThemeMode(String mode) =>
      dataSource.setSetting('themeMode', mode);
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dataSource = ref.watch(databaseDataSourceProvider);
  return SettingsRepository(dataSource: dataSource);
});
