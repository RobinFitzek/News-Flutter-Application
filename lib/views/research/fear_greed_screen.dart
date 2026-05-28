import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../engine/fear_greed_tracker.dart';
import '../../widgets/shimmer_loading.dart';

class FearGreedScreen extends ConsumerStatefulWidget {
  const FearGreedScreen({super.key});

  @override
  ConsumerState<FearGreedScreen> createState() => _FearGreedScreenState();
}

class _FearGreedScreenState extends ConsumerState<FearGreedScreen> {
  final _tracker = FearGreedTracker();
  Map<String, dynamic>? _data;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      _data = await _tracker.getCurrentSnapshot();
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  Color _color(int score) {
    if (score >= 75) return Colors.green;
    if (score >= 55) return Colors.lightGreen;
    if (score >= 45) return Colors.amber;
    if (score >= 25) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Fear & Greed')),
        body: const ShimmerLoading(count: 2),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Fear & Greed')),
        body: Center(child: Text(_error!)),
      );
    }

    final d = _data!;
    final score = d['score'] as int;
    final color = _color(score);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fear & Greed'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text('$score', style: TextStyle(
                      fontSize: 64, fontWeight: FontWeight.bold, color: color)),
                    Text(d['sentiment'] as String,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: score / 100,
                        minHeight: 12,
                        color: color,
                        backgroundColor: color.withValues(alpha: 0.15),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Extreme Fear', style: TextStyle(fontSize: 11)),
                        Text('Extreme Greed', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _row('VIX', (d['vix'] as num).toStringAsFixed(2)),
                    _row('SPY Change', '${(d['spy_change'] as num).toStringAsFixed(2)}%'),
                    if (d['vix_10d_avg'] != null)
                      _row('VIX 10d Avg', (d['vix_10d_avg'] as num).toStringAsFixed(2)),
                    if (d['vix_20d_avg'] != null)
                      _row('VIX 20d Avg', (d['vix_20d_avg'] as num).toStringAsFixed(2)),
                    _row('Data Source', d['source'] == 'cnn' ? 'CNN Fear & Greed' : 'VIX Fallback'),
                  ],
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
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
