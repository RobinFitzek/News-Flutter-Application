import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class FearGreedViewModel {
  final YahooFinanceClient _client = YahooFinanceClient();
  bool isLoading = false;
  Map<String, dynamic>? data;
  String? error;

  Future<void> load() async {
    isLoading = true;
    error = null;
    try {
      final vixQ = await _client.getStockQuote('^VIX');
      final spyQ = await _client.getStockQuote('SPY');
      final vix = (vixQ['currentPrice'] as num).toDouble();
      final spyChange = (spyQ['changePercent'] as num).toDouble();

      int score;
      String sentiment;
      if (vix < 15) {
        score = 75 + spyChange.clamp(-5, 5).toInt() * 2;
        sentiment = score > 70 ? 'Extreme Greed' : 'Greed';
      } else if (vix < 20) {
        score = 50 + spyChange.clamp(-5, 5).toInt() * 2;
        sentiment = 'Neutral';
      } else if (vix < 30) {
        score = 30 + spyChange.clamp(-5, 5).toInt();
        sentiment = 'Fear';
      } else {
        score = 15;
        sentiment = 'Extreme Fear';
      }
      score = score.clamp(0, 100);

      data = {
        'score': score,
        'sentiment': sentiment,
        'vix': vix,
        'spyChange': spyChange,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
  }
}

class FearGreedScreen extends ConsumerStatefulWidget {
  const FearGreedScreen({super.key});

  @override
  ConsumerState<FearGreedScreen> createState() => _FearGreedScreenState();
}

class _FearGreedScreenState extends ConsumerState<FearGreedScreen> {
  final _vm = FearGreedViewModel();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async { await _vm.load(); if (mounted) setState(() => _loaded = true); });
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
    if (!_loaded) return Scaffold(appBar: AppBar(title: const Text('Fear & Greed')), body: const ShimmerLoading(count: 2));
    if (_vm.error != null) return Scaffold(appBar: AppBar(title: const Text('Fear & Greed')), body: Center(child: Text(_vm.error!)));

    final d = _vm.data!;
    final score = d['score'] as int;
    final color = _color(score);

    return Scaffold(
      appBar: AppBar(title: const Text('Fear & Greed Index')),
      body: RefreshIndicator(
        onRefresh: () async { await _vm.load(); if (mounted) setState(() {}); },
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                Text(d['sentiment'] as String, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(height: 160, child: Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 140, height: 140, child: CircularProgressIndicator(value: score / 100, strokeWidth: 12, backgroundColor: Colors.grey.shade200, color: color)),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('$score', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: color, fontWeight: FontWeight.bold)),
                    const Text('/ 100', style: TextStyle(fontSize: 12)),
                  ]),
                ])),
                const SizedBox(height: 24),
                _indicatorRow(context, 'VIX', d['vix'].toStringAsFixed(2), Icons.trending_up),
                _indicatorRow(context, 'S&P 500', '${d['spyChange'] >= 0 ? '+' : ''}${(d['spyChange'] as double).toStringAsFixed(2)}%', Icons.show_chart),
                const SizedBox(height: 12),
                Text('Last updated: ${DateTime.now().toString().substring(0, 19)}', style: const TextStyle(fontSize: 11)),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Scale', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _scaleRow(context, 'Extreme Greed', 90, Colors.green),
              _scaleRow(context, 'Greed', 70, Colors.lightGreen),
              _scaleRow(context, 'Neutral', 50, Colors.amber),
              _scaleRow(context, 'Fear', 30, Colors.orange),
              _scaleRow(context, 'Extreme Fear', 10, Colors.red),
            ])),
          ),
        ]),
      ),
    );
  }

  Widget _indicatorRow(BuildContext context, String label, String value, IconData icon) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [Icon(icon, size: 16), const SizedBox(width: 8), Text(label)]),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _scaleRow(BuildContext context, String label, int value, Color color) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      SizedBox(width: 20, child: LinearProgressIndicator(value: value / 100, color: color, minHeight: 4)),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontSize: 12)),
    ]),
  );
}
