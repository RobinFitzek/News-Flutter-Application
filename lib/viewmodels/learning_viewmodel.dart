import '../../data/database/app_database.dart';
import '../../engine/learning_optimizer.dart';
import '../../engine/meta_labeler.dart';
import '../../engine/signal_grader.dart';

class LearningViewModel {
  LearningViewModel({required this.db}) : _optimizer = LearningOptimizer(db);

  final AppDatabase db;
  final LearningOptimizer _optimizer;

  bool isLoading = false;
  Map<String, dynamic>? stats;
  Map<String, dynamic>? learningStats;
  Map<String, dynamic>? weightSuggestion;
  Map<String, dynamic>? gradeStats;
  Map<String, dynamic>? metaLabelerStatus;
  Map<String, dynamic>? calibration;
  Map<String, dynamic>? signalDecay;
  Map<String, dynamic>? abComparison;
  List<Map<String, dynamic>> weightHistory = [];
  String? error;

  Future<void> load() async {
    isLoading = true;
    error = null;
    try {
      await _optimizer.verifyPredictions();
      learningStats = await _optimizer.getLearningStats();
      weightSuggestion = await _optimizer.calculateOptimalWeights();
      calibration = await _optimizer.calculateCalibration();
      signalDecay = await _optimizer.calculateSignalDecay();
      abComparison = await _optimizer.calculateAbComparison();
      weightHistory = await _optimizer.getWeightHistory();

      final grader = SignalGrader(db);
      await grader.syncNewSignals();
      gradeStats = await grader.getGradeStats();

      final meta = MetaLabeler(db);
      await meta.loadModel();
      metaLabelerStatus = {
        'ready': meta.isReady,
        'version': meta.version,
        'train_result': await meta.train(force: false),
      };

      final analyses = await (db.select(db.analysisResults)).get();
      final trades = await (db.select(db.paperTrades)
            ..where((t) => t.status.equals('CLOSED')))
          .get();

      final totalAnalyses = analyses.length;
      final opportunityCount =
          analyses.where((a) => a.signal == 'Opportunity').length;
      final cautionCount = analyses.where((a) => a.signal == 'Caution').length;
      final avgConfidence = totalAnalyses > 0
          ? analyses.fold<double>(0, (s, a) => s + a.confidence) / totalAnalyses
          : 0.0;

      final totalTrades = trades.length;
      final wins = trades.where((t) => (t.realizedPnl ?? 0) > 0).length;
      final winRate = totalTrades > 0 ? (wins / totalTrades * 100) : 0.0;
      final totalPnl =
          trades.fold<double>(0, (s, t) => s + (t.realizedPnl ?? 0));
      final avgPnl = totalTrades > 0 ? totalPnl / totalTrades : 0.0;

      stats = {
        'totalAnalyses': totalAnalyses,
        'opportunityCount': opportunityCount,
        'cautionCount': cautionCount,
        'avgConfidence': avgConfidence,
        'totalTrades': totalTrades,
        'wins': wins,
        'winRate': winRate,
        'totalPnl': totalPnl,
        'avgPnl': avgPnl,
      };
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
  }

  Future<Map<String, dynamic>> rollbackWeight(int versionId) async {
    return _optimizer.rollbackWeights(versionId);
  }

  Future<Map<String, dynamic>> applyWeights({bool dryRun = true}) async {
    return _optimizer.autoAdjustWeights(dryRun: dryRun);
  }
}
