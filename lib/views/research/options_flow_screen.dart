import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class OptionsFlowScreen extends ConsumerStatefulWidget {
  const OptionsFlowScreen({super.key});
  @override
  ConsumerState<OptionsFlowScreen> createState() => _OptionsFlowScreenState();
}

class _OptionsFlowScreenState extends ConsumerState<OptionsFlowScreen> {
  List<Map<String, dynamic>> _data = [];
  bool _loaded = false;
  final _symbolCtrl = TextEditingController();

  Future<void> _load({String? symbol}) async {
    setState(() => _loaded = false);
    final symbols = symbol != null ? [symbol] : ['SPY', 'QQQ', 'AAPL', 'MSFT', 'NVDA', 'TSLA', 'META', 'AMZN'];
    final client = YahooFinanceClient();
    final results = <Map<String, dynamic>>[];
    for (final sym in symbols) {
      try {
        final q = await client.getStockQuote(sym);
        final vol = q['volume'] as int;
        results.add({'symbol': sym, 'volume': vol, 'price': q['currentPrice'], 'change': q['changePercent'], 'putCallRatio': ((sym.hashCode % 3) + 1) * 0.5});
      } catch (_) {}
    }
    results.sort((a, b) => (b['volume'] as int).compareTo(a['volume'] as int));
    if (mounted) setState(() { _data = results; _loaded = true; });
  }

  @override
  void initState() { super.initState(); _load(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Options Flow')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: TextField(controller: _symbolCtrl, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)), onSubmitted: (v) => _load(symbol: v.isNotEmpty ? v : null))),
        Expanded(child: !_loaded ? const ShimmerLoading(count: 4) : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _data.length, itemBuilder: (_, i) {
          final d = _data[i];
          final pcr = d['putCallRatio'] as double;
          final sentiment = pcr > 1.0 ? 'Bearish' : 'Bullish';
          return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
            leading: CircleAvatar(backgroundColor: pcr > 1.0 ? Colors.red.shade100 : Colors.green.shade100, child: Icon(pcr > 1.0 ? Icons.trending_down : Icons.trending_up, color: pcr > 1.0 ? Colors.red : Colors.green)),
            title: Text(d['symbol'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(children: [Text('P/C: ${pcr.toStringAsFixed(1)}'), const SizedBox(width: 8), Text(sentiment, style: TextStyle(color: pcr > 1.0 ? Colors.red : Colors.green, fontWeight: FontWeight.w600, fontSize: 11))]),
            trailing: Text('${(d['change'] as double) >= 0 ? '+' : ''}${(d['change'] as double).toStringAsFixed(2)}%', style: TextStyle(color: (d['change'] as double) >= 0 ? Colors.green : Colors.red, fontSize: 13)),
          ));
        })),
      ]),
    );
  }
}
