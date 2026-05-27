import 'package:flutter/material.dart';
import '../../engine/politician_tracker.dart';
import '../../widgets/shimmer_loading.dart';

class PoliticianScreen extends StatefulWidget {
  const PoliticianScreen({super.key});

  @override
  State<PoliticianScreen> createState() => _PoliticianScreenState();
}

class _PoliticianScreenState extends State<PoliticianScreen> {
  final _tracker = PoliticianTracker();
  List<Map<String, dynamic>> _top = [];
  List<Map<String, dynamic>> _recent = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    _top = await _tracker.getTopTradedTickers();
    _recent = await _tracker.getRecentTrades(days: 30);
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politician Trades'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
      ),
      body: _loading
          ? const ShimmerLoading(count: 4)
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Top Traded (90d)',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  ..._top.map((t) => Card(
                        child: ListTile(
                          title: Text(t['ticker'] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${t['total_trades']} trades · ${t['buy_count']} buys · ${t['unique_senators']} senators'),
                          trailing: Text('\$${((t['total_volume_mid'] as num) / 1000).toStringAsFixed(0)}k'),
                        ),
                      )),
                  const SizedBox(height: 16),
                  Text('Recent Trades (30d)',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  ..._recent.take(50).map((t) => ListTile(
                        dense: true,
                        title: Text('${t['ticker']} — ${t['senator']}'),
                        subtitle: Text('${t['date']} · ${t['tx_type']}'),
                        trailing: Icon(
                          t['is_buy'] == true
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: t['is_buy'] == true ? Colors.green : Colors.red,
                          size: 18,
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
