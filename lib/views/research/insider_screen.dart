import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class InsiderScreen extends ConsumerStatefulWidget {
  const InsiderScreen({super.key});

  @override
  ConsumerState<InsiderScreen> createState() => _InsiderScreenState();
}

class _InsiderScreenState extends ConsumerState<InsiderScreen> {
  List<InsiderTransactionData> _data = [];
  bool _loaded = false;
  final _symbolCtrl = TextEditingController();

  Future<void> _load({String? symbol}) async {
    setState(() => _loaded = false);
    final client = YahooFinanceClient();
    final db = ref.read(databaseProvider);
    try {
      if (symbol != null) {
        _data = await (db.select(db.insiderTransactions)..where((t) => t.symbol.equals(symbol.toUpperCase()))).get();
      } else {
        _data = await db.select(db.insiderTransactions).get();
        _data.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
      }
    } catch (_) {}
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() { _symbolCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insider Trading')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: TextField(controller: _symbolCtrl, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Filter by Symbol', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)), onSubmitted: (v) => _load(symbol: v.isNotEmpty ? v : null))),
          const SizedBox(width: 8),
          ElevatedButton(onPressed: () => _load(symbol: _symbolCtrl.text.isNotEmpty ? _symbolCtrl.text : null), child: const Text('Search')),
        ])),
        Expanded(
          child: !_loaded ? const ShimmerLoading(count: 4) : _data.isEmpty ? const Center(child: Text('No insider transactions found.\nData loads from SEC EDGAR when you view a stock detail.')) :
          RefreshIndicator(onRefresh: () => _load(symbol: _symbolCtrl.text.isNotEmpty ? _symbolCtrl.text : null), child: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _data.length, itemBuilder: (_, i) {
            final t = _data[i];
            final isBuy = t.type.toUpperCase().contains('PURCHASE') || t.type.toUpperCase() == 'BUY';
            return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
              leading: CircleAvatar(backgroundColor: isBuy ? Colors.green.shade100 : Colors.red.shade100, child: Icon(isBuy ? Icons.add_circle : Icons.remove_circle, color: isBuy ? Colors.green : Colors.red)),
              title: Row(children: [Text(t.symbol, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 8), Text(t.insiderName.replaceAll(RegExp(r'[-_].*'), ''), style: const TextStyle(fontSize: 13))]),
              subtitle: Text('${t.type} • ${DateFormat('MMM d').format(t.transactionDate)}'),
              trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('\$${t.totalValue > 0 ? NumberFormat.compact().format(t.totalValue) : '--'}', style: const TextStyle(fontWeight: FontWeight.w600)),
                if (t.shares > 0) Text('${NumberFormat.compact().format(t.shares)} sh', style: const TextStyle(fontSize: 11)),
              ]),
            ));
          })),
        ),
      ]),
    );
  }
}
