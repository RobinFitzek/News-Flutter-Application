import '../core/app_settings_store.dart';
import '../data/database/app_database.dart';
import 'learning_optimizer.dart';
import 'portfolio_manager.dart';
import '../services/market_hours.dart';

/// Central gate checks before running analysis pipeline.
class PipelineGate {
  PipelineGate(this._db)
      : _settings = AppSettingsStore(_db),
        _learning = LearningOptimizer(_db),
        _portfolio = PortfolioManager(_db);

  final AppDatabase _db;
  final AppSettingsStore _settings;
  final LearningOptimizer _learning;
  final PortfolioManager _portfolio;

  Future<Map<String, dynamic>> check({DateTime? now}) async {
    now ??= DateTime.now();
    final reasons = <String>[];

    if (await _settings.getBool('system_paused_accuracy')) {
      reasons.add('Accuracy kill switch active (manual pause)');
    } else if (await _learning.isAccuracyKillSwitchActive()) {
      await _settings.setBool('system_paused_accuracy', true);
      reasons.add('Accuracy kill switch triggered (<50% with 20+ verified)');
    }

    final skipHolidays =
        await _settings.getBool('skip_us_holidays', defaultValue: true);
    if (skipHolidays && MarketHours.isUsMarketHoliday(now)) {
      reasons.add('US market holiday');
    }

    final activeHoursEnabled =
        await _settings.getBool('active_hours_enabled', defaultValue: true);
    if (activeHoursEnabled) {
      final start = await _settings.getInt('active_hours_start', 7);
      final end = await _settings.getInt('active_hours_end', 22);
      if (!MarketHours.isWithinActiveHours(now: now, startHour: start, endHour: end)) {
        reasons.add('Outside active hours ($start:00–${end}:00)');
      }
    }

    final riskGate = await _portfolio.getRiskGateStatus();
    if (riskGate['active'] == true) {
      reasons.add(riskGate['reason']?.toString() ?? 'Portfolio risk guard active');
    }

    return {
      'allowed': reasons.isEmpty,
      'reasons': reasons,
      'risk_gate': riskGate,
    };
  }

  Future<void> clearAccuracyKillSwitch() async {
    await _settings.setBool('system_paused_accuracy', false);
  }
}
