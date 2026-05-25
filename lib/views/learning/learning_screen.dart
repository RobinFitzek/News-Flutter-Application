import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/analysis_repository.dart';
import '../../data/repositories/paper_trading_repository.dart';
import '../../widgets/shimmer_loading.dart';

class LearningViewModel {
  final AppDatabase db;
  LearningViewModel({required this.db});

  bool isLoading = false;
  Map<String, dynamic>? stats;
  String? error;

  Future<void> load() async {
    isLoading = true;
    error = null;
    try {
      final analyses = await (db.select(db.analysisResults)).get();
      final trades = await (db.select(db.paperTrades)..where((t) => t.status.equals('CLOSED'))).get();

      final totalAnalyses = analyses.length;
      final buyCount = analyses.where((a) => a.recommendation == 'BUY').length;
      final sellCount = analyses.where((a) => a.recommendation == 'SELL').length;
      final avgConfidence = totalAnalyses > 0 ? analyses.fold<double>(0, (s, a) => s + a.confidence) / totalAnalyses : 0.0;

      final totalTrades = trades.length;
      final wins = trades.where((t) => (t.realizedPnl ?? 0) > 0).length;
      final winRate = totalTrades > 0 ? (wins / totalTrades * 100) : 0.0;
      final totalPnl = trades.fold<double>(0, (s, t) => s + (t.realizedPnl ?? 0));
      final avgPnl = totalTrades > 0 ? totalPnl / totalTrades : 0.0;

      stats = {
        'totalAnalyses': totalAnalyses,
        'buyCount': buyCount,
        'sellCount': sellCount,
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
}

class LearningScreen extends ConsumerStatefulWidget {
  const LearningScreen({super.key});

  @override
  ConsumerState<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends ConsumerState<LearningScreen> {
  LearningViewModel? _vm;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _vm = LearningViewModel(db: ref.read(databaseProvider));
    Future.microtask(() async { await _vm!.load(); if (mounted) setState(() => _loaded = true); });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return Scaffold(appBar: AppBar(title: const Text('Learning & Performance')), body: const ShimmerLoading(count: 3));

    final s = _vm!.stats!;
    final confColor = (s['avgConfidence'] as double) >= 0.7 ? Colors.green : (s['avgConfidence'] as double) >= 0.5 ? Colors.amber : Colors.red;
    final pnlColor = (s['totalPnl'] as double) >= 0 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(title: const Text('Learning & Performance')),
      body: RefreshIndicator(
        onRefresh: () async { await _vm!.load(); if (mounted) setState(() {}); },
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('AI Analysis Stats', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _statRow(context, 'Total Analyses', '${s['totalAnalyses']}'),
            _statRow(context, 'BUY Recommendations', '${s['buyCount']}'),
            _statRow(context, 'SELL Recommendations', '${s['sellCount']}'),
            _statRow(context, 'Avg Confidence', '${((s['avgConfidence'] as double) * 100).toStringAsFixed(1)}%', valueColor: confColor),
          ]))),
          const SizedBox(height: 16),
          Text('Paper Trading Performance', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _statRow(context, 'Total Trades', '${s['totalTrades']}'),
            _statRow(context, 'Win Rate', '${(s['winRate'] as double).toStringAsFixed(1)}%'),
            _statRow(context, 'Wins / Losses', '${s['wins']} / ${(s['totalTrades'] as int) - (s['wins'] as int)}'),
            _statRow(context, 'Total P&L', '\$${(s['totalPnl'] as double).toStringAsFixed(2)}', valueColor: pnlColor),
            _statRow(context, 'Avg P&L/Trade', '\$${(s['avgPnl'] as double).toStringAsFixed(2)}', valueColor: pnlColor),
          ]))),
          const SizedBox(height: 16),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Win Rate', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            SizedBox(height: 40, child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Stack(children: [
              Container(color: Colors.red.shade100),
              FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: (s['winRate'] as double) / 100, child: Container(color: Colors.green)),
              Center(child: Text('${(s['winRate'] as double).toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold))),
            ]))),
          ]))),
        ]),
      ),
    );
  }

  Widget _statRow(BuildContext context, String label, String value, {Color? valueColor}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 14)),
      Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: valueColor)),
    ]),
  );
}
