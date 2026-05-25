import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class PairsViewModel {
  final YahooFinanceClient _client;
  PairsViewModel() : _client = YahooFinanceClient();
  bool isLoading = false;
  List<Map<String, dynamic>> pairs = [];
  String? error;

  static const _commonPairs = [
    ('KO', 'PEP', 'Consumer Staples'),
    ('JPM', 'BAC', 'Big Banks'),
    ('XOM', 'CVX', 'Oil Majors'),
    ('HD', 'LOW', 'Home Improvement'),
    ('PFE', 'MRK', 'Pharma'),
    ('MA', 'V', 'Payments'),
    ('CAT', 'DE', 'Industrial'),
    ('NEE', 'DUK', 'Utilities'),
  ];

  Future<void> load() async {
    isLoading = true;
    error = null;
    pairs = [];

    for (final pair in _commonPairs) {
      try {
        final q1 = await _client.getStockQuote(pair.$1);
        final q2 = await _client.getStockQuote(pair.$2);
        final c1 = q1['changePercent'] as double;
        final c2 = q2['changePercent'] as double;
        final spread = (c1 - c2).abs();
        pairs.add({
          'symbol1': pair.$1,
          'symbol2': pair.$2,
          'sector': pair.$3,
          'change1': c1,
          'change2': c2,
          'spread': spread,
          'signal': spread > 2 ? (c1 > c2 ? 'LONG ${pair.$2} / SHORT ${pair.$1}' : 'LONG ${pair.$1} / SHORT ${pair.$2}') : 'No signal',
          'price1': q1['currentPrice'],
          'price2': q2['currentPrice'],
        });
      } catch (_) {}
    }
    pairs.sort((a, b) => (b['spread'] as double).compareTo(a['spread'] as double));
    isLoading = false;
  }
}

class PairsScreen extends ConsumerStatefulWidget {
  const PairsScreen({super.key});

  @override
  ConsumerState<PairsScreen> createState() => _PairsScreenState();
}

class _PairsScreenState extends ConsumerState<PairsScreen> {
  final _vm = PairsViewModel();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async { await _vm.load(); if (mounted) setState(() => _loaded = true); });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return Scaffold(appBar: AppBar(title: const Text('Pairs Trading')), body: const ShimmerLoading(count: 4));

    return Scaffold(
      appBar: AppBar(title: const Text('Pairs Trading')),
      body: RefreshIndicator(
        onRefresh: () async { await _vm.load(); if (mounted) setState(() {}); },
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('Common Pairs', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._vm.pairs.map((p) {
            final spread = p['spread'] as double;
            final signal = p['signal'] as String;
            final hasSignal = spread > 2;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${p['symbol1']} / ${p['symbol2']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4)), child: Text(p['sector'] as String, style: const TextStyle(fontSize: 11))),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${p['symbol1']}: \$${(p['price1'] as double).toStringAsFixed(2)}', style: const TextStyle(fontSize: 13)),
                    Text('${p['symbol2']}: \$${(p['price2'] as double).toStringAsFixed(2)}', style: const TextStyle(fontSize: 13)),
                  ]),
                  const Spacer(),
                  Text('Spread: ${spread.toStringAsFixed(2)}%', style: TextStyle(color: hasSignal ? Colors.orange : Colors.grey, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 4),
                Text(signal, style: TextStyle(fontSize: 12, color: hasSignal ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant)),
              ])),
            );
          }),
        ]),
      ),
    );
  }
}
