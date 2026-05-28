import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_settings_store.dart';
import '../datasources/local/database_datasource.dart';

/// Tracks whether the first-run onboarding has been completed.
class OnboardingRepository extends ChangeNotifier {
  OnboardingRepository(this._store);

  /// Fixed state for widget/integration tests (no SQLite).
  OnboardingRepository.testing({bool completed = true})
      : _store = null,
        _completed = completed;

  final AppSettingsStore? _store;
  static const _key = 'onboarding_completed';

  bool? _completed;
  bool get isLoaded => _completed != null;
  bool get isCompleted => _completed ?? false;

  Future<void> load() async {
    if (_store == null) {
      notifyListeners();
      return;
    }
    _completed = await _store!.getBool(_key, defaultValue: false);
    notifyListeners();
  }

  Future<void> complete() async {
    if (_store != null) {
      await _store!.setBool(_key, true);
    }
    _completed = true;
    notifyListeners();
  }

  Future<void> reset() async {
    if (_store != null) {
      await _store!.setBool(_key, false);
    }
    _completed = false;
    notifyListeners();
  }
}

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return OnboardingRepository(AppSettingsStore(db));
});
