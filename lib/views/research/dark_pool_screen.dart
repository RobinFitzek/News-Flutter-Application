import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../engine/dark_pool_tracker.dart';
import '../../engine/config/engine_config.dart';
import '../../widgets/shimmer_loading.dart';

class DarkPoolScreen extends ConsumerStatefulWidget {
  const DarkPoolScreen({super.key});

  @override
  ConsumerState<DarkPoolScreen> createState() => _DarkPoolScreenState();
}

class _DarkPoolScreenState extends ConsumerState<DarkPoolScreen> {
  final _tracker = DarkPoolTracker();
  final _symbolCtrl = TextEditingController();
  List<Map<String, dynamic>> _signals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _scan();
  }

  Future<void> _scan({String? symbol}) async {
    setState(() => _loading = true);
    final symbols = symbol != null && symbol.isNotEmpty
        ? [symbol.toUpperCase()]
        : [
            ...EngineConfig.sectorPeers['Technology']!.take(3),
            'SPY',
            'TSLA',
          ];

    final results = await _tracker.scanBatch(symbols);
    if (mounted) {
      setState(() {
        _signals = results;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Pool Signals'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () => _scan())],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _symbolCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Symbol',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (v) => _scan(symbol: v),
            ),
          ),
          Expanded(
            child: _loading
                ? const ShimmerLoading(count: 4)
                : _signals.isEmpty
                    ? const Center(child: Text('No unusual volume signals detected'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _signals.length,
                        itemBuilder: (_, i) {
                          final s = _signals[i];
                          final isDark = s['signal_type'] == 'dark_pool_proxy';
                          final isBlock = s['is_large_block'] == true;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isDark
                                    ? Colors.purple.shade100
                                    : Colors.orange.shade100,
                                child: Icon(
                                  Icons.water_drop,
                                  color: isDark ? Colors.purple : Colors.orange,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(s['symbol'] as String,
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  if (isBlock)
                                    _badge('BLOCK', Colors.red),
                                  if (isDark)
                                    _badge('DARK POOL', Colors.purple),
                                ],
                              ),
                              subtitle: Text(
                                '${s['description']}\nVol: ${s['volume_ratio']}x avg • Move: ${s['price_move_pct']}%',
                              ),
                              isThreeLine: true,
                              trailing: Text(
                                '\$${(s['current_price'] as num).toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(label, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold)),
  );
}
