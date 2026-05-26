import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class DarkPoolScreen extends ConsumerStatefulWidget {
  const DarkPoolScreen({super.key});
  @override
  ConsumerState<DarkPoolScreen> createState() => _DarkPoolScreenState();
}

class _DarkPoolScreenState extends ConsumerState<DarkPoolScreen> {
  List<Map<String, dynamic>> _signals = [];
  bool _loaded = false;
  final _symbolCtrl = TextEditingController();

  Future<void> _scan({String? symbol}) async {
    setState(() => _loaded = false);
    final symbols = symbol != null ? [symbol] : ['AAPL', 'MSFT', 'NVDA', 'SPY', 'TSLA'];
    final client = YahooFinanceClient();
    final results = <Map<String, dynamic>>[];
    for (final sym in symbols) {
      try {
        final q = await client.getStockQuote(sym);
        final vol = q['volume'] as int;
        results.add({'symbol': sym, 'volume': vol, 'price': q['currentPrice'], 'change': q['changePercent'], 'alert': vol > 50000000 ? 'HIGH' : 'Normal'});
      } catch (_) {}
    }
    results.sort((a, b) => (b['volume'] as int).compareTo(a['volume'] as int));
    if (mounted) setState(() { _signals = results; _loaded = true; });
  }

  @override
  void initState() { super.initState(); _scan(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dark Pool Signals')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: TextField(controller: _symbolCtrl, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)), onSubmitted: (v) => _scan(symbol: v.isNotEmpty ? v : null))),
        Expanded(child: !_loaded ? const ShimmerLoading(count: 4) : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _signals.length, itemBuilder: (_, i) {
          final s = _signals[i];
          final isHigh = s['alert'] == 'HIGH';
          return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
            leading: CircleAvatar(backgroundColor: isHigh ? Colors.purple.shade100 : Colors.grey.shade200, child: Icon(Icons.water_drop, color: isHigh ? Colors.purple : Colors.grey)),
            title: Row(children: [Text(s['symbol'] as String, style: const TextStyle(fontWeight: FontWeight.bold)), if (isHigh) const SizedBox(width: 8), if (isHigh) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('HIGH', style: TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold)))]),
            subtitle: Text('Vol: ${NumberFormat.compact().format(s['volume'])} • \$${(s['price'] as double).toStringAsFixed(2)}'),
            trailing: Text('${(s['change'] as double) >= 0 ? '+' : ''}${(s['change'] as double).toStringAsFixed(2)}%', style: TextStyle(color: (s['change'] as double) >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.w600)),
          ));
        })),
      ]),
    );
  }
}
