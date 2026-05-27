import 'package:drift/drift.dart';
import 'package:workmanager/workmanager.dart';

import '../data/database/app_database.dart';
import '../data/repositories/paper_trading_repository.dart';
import '../engine/auto_paper_trader.dart';
import '../engine/discovery_engine.dart';
import '../engine/learning_optimizer.dart';
import '../engine/meta_labeler.dart';
import '../engine/signal_grader.dart';

const backgroundTaskName = 'stockholmMaintenance';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task != backgroundTaskName) return Future.value(true);

    try {
      final db = AppDatabase();

      final learning = LearningOptimizer(db);
      await learning.verifyPredictions();

      final grader = SignalGrader(db);
      await grader.gradePendingSignals();

      final meta = MetaLabeler(db);
      await meta.loadModel();
      await meta.train(force: false);

      final paperRepo = PaperTradingRepositoryImpl(db);
      final autoTrader = AutoPaperTrader(db, paperRepo: paperRepo);
      await autoTrader.processNewSignals();
      await autoTrader.checkOpenPositions();

      final discovery = DiscoveryEngine();
      final discoveries = await discovery.discoverTrending(
        watchlistSymbols: {},
        limit: 5,
      );
      if (discoveries.isNotEmpty) {
        for (final d in discoveries) {
          await db.into(db.discoveries).insert(
                DiscoveriesCompanion.insert(
                  symbol: d.symbol,
                  companyName: Value(d.companyName),
                  reason: d.reason,
                  strategy: Value(d.strategy),
                  currentPrice: d.currentPrice,
                  confidence: d.confidence,
                ),
                mode: InsertMode.insertOrIgnore,
              );
        }
      }

      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  });
}

Future<void> registerBackgroundTasks() async {
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Workmanager().registerPeriodicTask(
    backgroundTaskName,
    backgroundTaskName,
    frequency: const Duration(hours: 4),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}
