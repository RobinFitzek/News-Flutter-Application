import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../viewmodels/learning_viewmodel.dart';
import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_loading.dart';

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
    final ls = _vm!.learningStats ?? {};
    final confColor = (s['avgConfidence'] as double) >= 0.7 ? Colors.green : (s['avgConfidence'] as double) >= 0.5 ? Colors.amber : Colors.red;
    final pnlColor = (s['totalPnl'] as double) >= 0 ? Colors.green : Colors.red;
    final accuracy = (ls['avg_accuracy'] as num?)?.toDouble() ?? 0.5;

    return Scaffold(
      appBar: AppBar(title: const Text('Learning & Performance')),
      body: RefreshIndicator(
        onRefresh: () async { await _vm!.load(); if (mounted) setState(() {}); },
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('Signal Accuracy (Self-Learning)', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _statRow(context, 'Verified Predictions', '${ls['total_verified'] ?? 0}'),
            _statRow(context, 'Pending Verification', '${ls['pending_verification'] ?? 0}'),
            _statRow(context, 'Hit Rate', '${ls['hit_rate'] ?? 0}%'),
            _statRow(context, 'Avg Accuracy', '${(accuracy * 100).toStringAsFixed(1)}%', valueColor: accuracy >= 0.6 ? Colors.green : accuracy >= 0.5 ? Colors.amber : Colors.red),
            _statRow(context, 'Beat SPY Rate', '${ls['benchmark_beat_rate'] ?? 0}%'),
            _statRow(context, 'Correct / Wrong', '${ls['correct_predictions'] ?? 0} / ${ls['wrong_predictions'] ?? 0}'),
          ]))),
          if (_vm!.calibration?['sufficient_data'] == true) ...[
            const SizedBox(height: 16),
            Text('Calibration', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: StockholmColors.signalNeutral, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GlassCard(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _statRow(context, 'Brier Score', '${_vm!.calibration!['brier_score']}'),
              _statRow(context, 'Calibration Error', '${_vm!.calibration!['calibration_error']}%'),
              Text(_vm!.calibration!['interpretation']?.toString() ?? '', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              ...((_vm!.calibration!['buckets'] as List).map((b) => _statRow(context, '${b['range']} (${b['count']})', '${b['hit_rate']}% hit'))),
            ]))),
          ],
          if (_vm!.signalDecay?['sufficient_data'] == true) ...[
            const SizedBox(height: 16),
            Text('Signal Decay', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: StockholmColors.signalNeutral, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GlassCard(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_vm!.signalDecay!['interpretation']?.toString() ?? '', style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 8),
              ...((_vm!.signalDecay!['windows'] as List).map((w) =>
                _statRow(context, w['label'], '${w['accuracy_pct']}% (${w['avg_return']}% avg)'))),
            ]))),
          ],
          if (_vm!.abComparison?['sufficient_data'] == true) ...[
            const SizedBox(height: 16),
            Text('A/B: Quant vs Quant+AI', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: StockholmColors.signalNeutral, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GlassCard(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
              _statRow(context, 'Quant Only', '${(_vm!.abComparison!['quant_only'] as Map)['win_rate']}% (${(_vm!.abComparison!['quant_only'] as Map)['count']})'),
              _statRow(context, 'Quant + AI', '${(_vm!.abComparison!['quant_ai'] as Map)['win_rate']}% (${(_vm!.abComparison!['quant_ai'] as Map)['count']})'),
              _statRow(context, 'Verdict', _vm!.abComparison!['verdict_text']?.toString() ?? ''),
            ]))),
          ],
          if (_vm!.weightHistory.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Weight History', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: StockholmColors.signalNeutral, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._vm!.weightHistory.take(5).map((w) => GlassCard(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text('#${w['id']} · ${w['trigger']}', style: const TextStyle(fontSize: 13)),
                subtitle: Text(w['reason']?.toString() ?? w['timestamp']?.toString() ?? ''),
                trailing: w['trigger'] != 'rollback'
                    ? IconButton(
                        icon: const Icon(Icons.restore, size: 18),
                        onPressed: () async {
                          await _vm!.rollbackWeight(w['id'] as int);
                          await _vm!.load();
                          if (mounted) setState(() {});
                        },
                      )
                    : null,
              ),
            )),
          ],
          const SizedBox(height: 16),
          Text('Signal Grader (30/60/90d)', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _statRow(context, 'Graded Signals', '${_vm!.gradeStats?['total'] ?? 0}'),
            _statRow(context, 'Hit Rate', '${_vm!.gradeStats?['hit_rate'] ?? 0}%'),
            _statRow(context, 'Correct / Partial / Wrong',
                '${_vm!.gradeStats?['correct'] ?? 0} / ${_vm!.gradeStats?['partially_correct'] ?? 0} / ${_vm!.gradeStats?['incorrect'] ?? 0}'),
            _statRow(context, 'Pending Grades', '${_vm!.gradeStats?['pending'] ?? 0}'),
          ]))),
          const SizedBox(height: 16),
          Text('Meta-Labeler', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _statRow(context, 'Model Ready', _vm!.metaLabelerStatus?['ready'] == true ? 'Yes' : 'No'),
            _statRow(context, 'Version', '${_vm!.metaLabelerStatus?['version'] ?? 0}'),
            _statRow(context, 'Last Train',
                (_vm!.metaLabelerStatus?['train_result'] as Map?)?['trained'] == true
                    ? 'OK (${(_vm!.metaLabelerStatus!['train_result'] as Map)['samples']} samples)'
                    : (_vm!.metaLabelerStatus?['train_result'] as Map?)?['reason']?.toString() ?? '—'),
          ]))),
          const SizedBox(height: 16),
          if (_vm!.weightSuggestion?['sufficient_data'] == true) ...[
            Text('Weight Optimization', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Suggested quant screener weights based on ${(_vm!.weightSuggestion!['prediction_count'])} verified predictions:',
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 8),
                ...((_vm!.weightSuggestion!['suggested_weights'] as Map<String, dynamic>).entries.map((e) =>
                  _statRow(context, e.key, '${((e.value as num) * 100).toStringAsFixed(0)}%'))),
              ],
            ))),
            const SizedBox(height: 16),
          ],
          Text('AI Analysis Stats', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _statRow(context, 'Total Analyses', '${s['totalAnalyses']}'),
            _statRow(context, 'Opportunity Signals', '${s['opportunityCount']}'),
            _statRow(context, 'Caution Signals', '${s['cautionCount']}'),
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
