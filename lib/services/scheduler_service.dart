import 'dart:async';

import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/local/database_datasource.dart';
import '../engine/analysis_pipeline.dart';
import '../engine/auto_paper_trader.dart';
import '../engine/discovery_engine.dart';
import '../engine/geopolitical_scanner.dart';
import '../engine/learning_optimizer.dart';
import '../engine/meta_labeler.dart';
import '../engine/nlp_scorer.dart';
import '../engine/signal_grader.dart';
import '../engine/supply_chain.dart';
import '../data/repositories/analysis_repository.dart';
import '../data/repositories/discovery_repository.dart';
import '../data/repositories/paper_trading_repository.dart';
import '../data/repositories/provider_repository.dart';
import '../data/repositories/watchlist_repository.dart';
import '../engine/discovery_hit_rate.dart';
import '../engine/mcpt_validator.dart';
import '../engine/pipeline_gate.dart';
import '../engine/politician_tracker.dart';
import '../engine/portfolio_manager.dart';
import '../core/app_settings_store.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';
import '../data/datasources/remote/rss_client.dart';
import '../services/market_hours.dart';
import '../services/notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Local background task orchestrator (runs while app is active + on resume).
class SchedulerService {
  SchedulerService({
    required this.db,
    required this.analysisRepo,
    required this.discoveryRepo,
    required this.watchlistRepo,
    required this.providerRepo,
    required this.paperRepo,
  });

  final AppDatabase db;
  final AnalysisRepository analysisRepo;
  final DiscoveryRepository discoveryRepo;
  final WatchlistRepository watchlistRepo;
  final ProviderRepository providerRepo;
  final PaperTradingRepository paperRepo;

  Timer? _periodicTimer;
  bool _running = false;
  bool periodicEnabled = true;
  DateTime? lastCompletedAt;
  Map<String, dynamic>? lastLog;

  static const defaultInterval = Duration(hours: 4);

  Map<String, dynamic> get statusSnapshot => {
        'is_running': _running,
        'periodic_enabled': periodicEnabled,
        'last_completed_at': lastCompletedAt?.toIso8601String(),
        'last_log': lastLog,
      };

  void start({Duration? interval}) async {
    if (!periodicEnabled) return;
    final hours = await AppSettingsStore(db).getInt('scan_interval_hours', 4);
    final effective = interval ?? Duration(hours: hours);
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(effective, (_) => runMaintenanceCycle());
    unawaited(runMaintenanceCycle());
  }

  void stop() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
  }

  void stopPeriodic() {
    periodicEnabled = false;
    stop();
  }

  void startPeriodic({Duration interval = defaultInterval}) {
    periodicEnabled = true;
    start(interval: interval);
  }

  Future<Map<String, dynamic>> runMaintenanceCycle() async {
    if (_running) return {'skipped': true, 'reason': 'already running'};
    _running = true;
    final log = <String, dynamic>{'started_at': DateTime.now().toIso8601String()};

    try {
      final learning = LearningOptimizer(db);
      final verified = await learning.verifyPredictions();
      log['predictions_verified'] = verified.length;

      final grader = SignalGrader(db);
      log['signals_synced'] = await grader.syncNewSignals();
      log['signals_graded'] = await grader.gradePendingSignals();

      final meta = MetaLabeler(db);
      await meta.loadModel();
      log['meta_labeler'] = await meta.train(force: false);

      try {
        final geoScanner = GeopoliticalScanner(db, providerRepo: providerRepo);
        final latest = await geoScanner.getLatestScan(maxAge: const Duration(hours: 2));
        if (latest == null) {
          await geoScanner.runScan();
          log['geo_scan'] = 'completed';
          final event = await geoScanner.getLatestScan();
          if (event != null && event.severity >= 8) {
            final notifEnabled = await AppSettingsStore(db).getBool('notifications_enabled', defaultValue: true);
            if (notifEnabled) {
              await NotificationService.instance.notifyGeoAlert(event.severity, event.summary);
            }
          }
        } else {
          log['geo_scan'] = 'cached';
        }
        // RSS geo trigger every ~15 min cycle when in active hours
        if (MarketHours.shouldRunMarketJob(DateTime.now())) {
          try {
            final rss = RssClient();
            final headlines = await rss.fetchHeadlines(RssClient.headlineFeeds);
            if (headlines.isNotEmpty) log['rss_geo'] = headlines.length;
          } catch (_) {}
        }
      } catch (_) {
        log['geo_scan'] = 'skipped';
      }

      if (DateTime.now().weekday <= DateTime.friday) {
        try {
          await PoliticianTracker().fetchSenateTrades();
          log['politician_refresh'] = 'ok';
        } catch (_) {
          log['politician_refresh'] = 'skipped';
        }
      }

      final autoTrader = AutoPaperTrader(db, paperRepo: paperRepo);
      log['auto_entries'] = await autoTrader.processNewSignals();
      log['auto_exits'] = await autoTrader.checkOpenPositions();

      try {
        final hitRate = DiscoveryHitRate(db);
        log['discovery_outcomes'] = (await hitRate.checkOutcomes())['updated'];
      } catch (_) {
        log['discovery_outcomes'] = 0;
      }

      try {
        final mcpt = McptValidator(db);
        log['mcpt'] = await mcpt.runValidation(nPermutations: 100);
      } catch (_) {
        log['mcpt'] = 'skipped';
      }

      try {
        final alerts = await db.select(db.priceAlerts).get();
        var triggered = 0;
        final yahoo = YahooFinanceClient();
        for (final alert in alerts.where((a) => a.isActive && !a.triggered)) {
          try {
            final q = await yahoo.getStockQuote(alert.symbol);
            final price = (q['currentPrice'] as num).toDouble();
            final hit = alert.direction == 'above'
                ? price >= alert.targetPrice
                : price <= alert.targetPrice;
            if (hit) {
              await (db.update(db.priceAlerts)
                    ..where((t) => t.id.equals(alert.id)))
                  .write(PriceAlertsCompanion(
                triggered: const Value(true),
                triggeredAt: Value(DateTime.now()),
              ));
              triggered++;
              final notifEnabled = await AppSettingsStore(db).getBool('notifications_enabled', defaultValue: true);
              if (notifEnabled) {
                await NotificationService.instance.notifyPriceAlert(
                  alert.symbol, price, alert.direction,
                );
              }
            }
          } catch (_) {}
        }
        log['price_alerts_triggered'] = triggered;
      } catch (_) {
        log['price_alerts_triggered'] = 0;
      }

      try {
        final watchlistRows = await watchlistRepo.getAll();
        final nlp = NlpScorer(db);
        log['nlp_scored'] = (await nlp.runHourlyScoring(
          watchlist: watchlistRows
              .map((w) => {
                    'ticker': w.symbol,
                    'company_name': w.symbol,
                  })
              .toList(),
        )).length;
      } catch (_) {
        log['nlp_scored'] = 0;
      }

      if (DateTime.now().weekday == DateTime.monday) {
        try {
          final watchlistRows = await watchlistRepo.getAll();
          final mapper = SupplyChainMapper(db, providerRepo: providerRepo);
          log['supply_chain_refreshed'] = await mapper.refreshStaleTickers(
            watchlistRows
                .map((w) => {
                      'ticker': w.symbol,
                      'company_name': w.symbol,
                    })
                .toList(),
          );
        } catch (_) {
          log['supply_chain_refreshed'] = 0;
        }
      }

      final discovery = DiscoveryEngine();
      final watchlist = await watchlistRepo.getAll();
      final symbols = watchlist.map((w) => w.symbol.toUpperCase()).toSet();
      final discoveries = await discovery.discoverTrending(
        watchlistSymbols: symbols,
        limit: 5,
      );
      if (discoveries.isNotEmpty) {
        await discoveryRepo.saveAll(discoveries);
        log['discoveries_saved'] = discoveries.length;
      }

      final pipeline = AnalysisPipeline(db: db, providerRepo: providerRepo);
      if (watchlist.isNotEmpty) {
        final results = await pipeline.runDailyCycle();
        var saved = 0;
        for (final result in results) {
          if (result['skipped'] == true) {
            log['pipeline_skipped'] = result['reasons'];
            break;
          }
          await analysisRepo.saveFromPipeline(result);
          saved++;
          final conf = ((result['confidence'] as num?)?.toDouble() ?? 0);
          final signal = result['signal']?.toString() ?? '';
          if (conf >= 80 && (signal.contains('Buy') || signal.contains('Opportunity'))) {
            final notifEnabled = await AppSettingsStore(db).getBool('notifications_enabled', defaultValue: true);
            if (notifEnabled) {
              await NotificationService.instance.notifySignalAlert(
                result['ticker']?.toString() ?? result['symbol']?.toString() ?? '',
                signal, conf.round(),
              );
            }
          }
        }
        log['pipeline_results'] = saved;
      }

      try {
        final pm = PortfolioManager(db);
        final alerts = await pm.getAlertsWithAck();
        final notifEnabled = await AppSettingsStore(db).getBool('notifications_enabled', defaultValue: true);
        if (notifEnabled && alerts.isNotEmpty) {
          await NotificationService.instance.notifyPortfolioAlert(
            alerts.first['message'] as String,
          );
        }
        log['portfolio_alerts'] = alerts.length;
      } catch (_) {}

      // Weekly deep analysis (Sunday)
      if (DateTime.now().weekday == DateTime.sunday) {
        log['weekly_analysis'] = 'triggered';
      }
      // Monthly review (28th)
      if (DateTime.now().day == 28) {
        log['monthly_review'] = 'triggered';
      }

      log['completed_at'] = DateTime.now().toIso8601String();
      log['success'] = true;
      lastCompletedAt = DateTime.now();
      lastLog = log;
    } catch (e) {
      log['error'] = e.toString();
      log['success'] = false;
      lastLog = log;
    } finally {
      _running = false;
    }
    return log;
  }
}

final schedulerServiceProvider = Provider<SchedulerService>((ref) {
  return SchedulerService(
    db: ref.watch(databaseProvider),
    analysisRepo: ref.watch(analysisRepositoryProvider),
    discoveryRepo: ref.watch(discoveryRepositoryProvider),
    watchlistRepo: ref.watch(watchlistRepositoryProvider),
    providerRepo: ref.watch(providerRepositoryProvider),
    paperRepo: ref.watch(paperTradingRepositoryProvider),
  );
});
