import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';
import 'dart:math';

class ComparisonViewModel {
  final YahooFinanceClient _client = YahooFinanceClient();
  bool isLoading = false;
  Map<String, Map<String, dynamic>> data = {};
  String? error;

  Future<void> load(List<String> symbols) async {
    isLoading = true;
    error = null;
    data = {};
    for (final s in symbols) {
      try {
        final q = await _client.getStockQuote(s);
        data[s.toUpperCase()] = {
          'symbol': s.toUpperCase(),
          'companyName': q['companyName'],
          'price': q['currentPrice'],
          'change': q['changePercent'],
          'pe': q['trailingPE'] ?? '--',
          'marketCap': q['marketCap'],
          'beta': q['beta'] ?? '--',
          'dividend': q['dividendYield'] ?? '--',
        };
      } catch (_) {}
    }
    isLoading = false;
  }
}

class ComparisonScreen extends ConsumerStatefulWidget {
  const ComparisonScreen({super.key, this.initialSymbols});

  final String? initialSymbols;

  @override
  ConsumerState<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends ConsumerState<ComparisonScreen> {
  final _vm = ComparisonViewModel();
  final _inputCtrl = TextEditingController(text: 'AAPL,MSFT,GOOGL');
  bool _loaded = false;
  List<String> _symbols = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialSymbols != null) _inputCtrl.text = widget.initialSymbols!;
    _load();
  }

  Future<void> _load() async {
    _symbols = _inputCtrl.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    await _vm.load(_symbols);
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() { _inputCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Comparison')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: TextField(controller: _inputCtrl, decoration: const InputDecoration(labelText: 'Symbols (comma-separated)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)))),
          const SizedBox(width: 8),
          ElevatedButton(onPressed: _load, child: const Text('Compare')),
        ])),
        Expanded(
          child: !_loaded ? const ShimmerLoading(count: 4) : _vm.error != null ? Center(child: Text(_vm.error!)) : _vm.data.isEmpty ? const Center(child: Text('Enter symbols to compare')) :
          SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: [
            const DataColumn(label: Text('Metric')),
            ..._symbols.map((s) => DataColumn(label: Text(_vm.data[s]?['symbol'] ?? s))),
          ], rows: [
            _row('Price', (d) => '\$${(d?['price'] as double?)?.toStringAsFixed(2) ?? '--'}'),
            _row('Change', (d) {
              final c = d?['change'];
              return c != null ? '${(c as double) >= 0 ? '+' : ''}${c.toStringAsFixed(2)}%' : '--';
            }),
            _row('Market Cap', (d) {
              final mc = d?['marketCap'];
              return mc != null ? '\$${(mc / 1e9).toStringAsFixed(1)}B' : '--';
            }),
            _row('P/E Ratio', (d) => d?['pe']?.toString() ?? '--'),
            _row('Beta', (d) => d?['beta']?.toString() ?? '--'),
            _row('Dividend', (d) {
              final div = d?['dividend'];
              return div != null ? '${(div * 100).toStringAsFixed(2)}%' : '--';
            }),
          ])),
        ),
      ]),
    );
  }

  DataRow _row(String metric, String? Function(Map<String, dynamic>?) getValue) => DataRow(cells: [
    DataCell(Text(metric, style: const TextStyle(fontWeight: FontWeight.w600))),
    ..._symbols.map((s) => DataCell(Text(getValue(_vm.data[s]) ?? '--'))),
  ]);
}
