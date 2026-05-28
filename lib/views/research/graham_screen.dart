import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../engine/graham_screener.dart';
import '../../engine/config/engine_config.dart';
import '../../widgets/shimmer_loading.dart';

class GrahamScreen extends ConsumerStatefulWidget {
  const GrahamScreen({super.key});

  @override
  ConsumerState<GrahamScreen> createState() => _GrahamScreenState();
}

class _GrahamScreenState extends ConsumerState<GrahamScreen> {
  final _screener = GrahamScreener();
  List<Map<String, dynamic>> _results = [];
  bool _loading = false;
  double _margin = 0.2;

  Future<void> _runScreen() async {
    setState(() => _loading = true);
    final tickers = <String>{};
    for (final peers in EngineConfig.sectorPeers.values) {
      tickers.addAll(peers.take(4));
    }

    _results = await _screener.screenBatch(
      tickers.take(20).toList(),
      discountFactor: _margin,
    );
    if (mounted) setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _runScreen();
  }

  @override
  Widget build(BuildContext context) {
    final buys = _results.where((r) => r['buy_signal'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graham Value Screen'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _runScreen)],
      ),
      body: _loading
          ? const ShimmerLoading(count: 5)
          : RefreshIndicator(
              onRefresh: _runScreen,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Margin of Safety: ${(_margin * 100).round()}%',
                              style: Theme.of(context).textTheme.titleSmall),
                          Slider(
                            value: _margin,
                            min: 0,
                            max: 0.4,
                            divisions: 4,
                            label: '${(_margin * 100).round()}%',
                            onChanged: (v) => setState(() => _margin = v),
                            onChangeEnd: (_) => _runScreen(),
                          ),
                          Text('${buys.length} buy signals of ${_results.length} screened',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._results.map((r) {
                    final buy = r['buy_signal'] == true;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: buy
                              ? Colors.green.shade100
                              : Colors.grey.shade200,
                          child: Icon(
                            buy ? Icons.check : Icons.remove,
                            color: buy ? Colors.green : Colors.grey,
                          ),
                        ),
                        title: Text(r['ticker'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          'IV: \$${r['intrinsic_value'] ?? 'N/A'} • '
                          'Price: \$${r['current_price'] ?? 'N/A'}\n'
                          '${r['reason']}',
                        ),
                        isThreeLine: true,
                        trailing: r['upside_pct'] != null
                            ? Text(
                                '+${r['upside_pct']}%',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
