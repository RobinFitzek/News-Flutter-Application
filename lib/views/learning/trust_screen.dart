import 'package:flutter/material.dart';
import '../../data/database/app_database.dart';
import '../../engine/mcpt_validator.dart';
import '../../engine/learning_optimizer.dart';
import '../../widgets/glass_card.dart';

/// Trust page / truth banner — mirrors /trust page.
class TrustScreen extends StatefulWidget {
  const TrustScreen({super.key});

  @override
  State<TrustScreen> createState() => _TrustScreenState();
}

class _TrustScreenState extends State<TrustScreen> {
  Map<String, dynamic>? _stats;
  Map<String, dynamic>? _mcpt;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final db = AppDatabase();
    _stats = await LearningOptimizer(db).getLearningStats();
    _mcpt = await McptValidator(db).getLatestResult();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Trust & Truth Banner')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final s = _stats!;
    final hitRate = s['hit_rate'] as double? ?? 0;
    final beatSpy = s['benchmark_beat_rate'] as double? ?? 0;
    final pValue = _mcpt?['p_value'];
    final significant = _mcpt?['significant'] == true;

    return Scaffold(
      appBar: AppBar(title: const Text('Trust & Truth Banner')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('System Performance vs SPY',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    _row('Verified Predictions', '${s['total_verified']}'),
                    _row('Hit Rate', '$hitRate%'),
                    _row('Beat SPY Rate', '$beatSpy%'),
                    _row('Avg Accuracy',
                        '${((s['avg_accuracy'] as double) * 100).toStringAsFixed(1)}%'),
                    if (pValue != null) ...[
                      const Divider(),
                      _row('MCPT p-value', pValue.toString()),
                      _row('Statistically Significant', significant ? 'Yes' : 'No'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  significant
                      ? 'Signals show statistically significant edge (MCPT p < 0.05).'
                      : hitRate >= 60
                          ? 'Strong hit rate but MCPT significance not yet confirmed.'
                          : 'Insufficient verified data for high-confidence trust rating.',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
