import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class SectorViewModel {
  final YahooFinanceClient _client = YahooFinanceClient();
  List<Map<String, dynamic>> _sectors = [];
  Map<String, List<Map<String, dynamic>>> _sectorStocks = {};
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get sectors => _sectors;
  Map<String, List<Map<String, dynamic>>> get sectorStocks => _sectorStocks;
  String? get error => _error;

  static const _sectorEtfs = {
    'Technology': 'XLK', 'Finance': 'XLF', 'Healthcare': 'XLV',
    'Consumer Cyclical': 'XLY', 'Communication': 'XLC', 'Industrials': 'XLI',
    'Consumer Defensive': 'XLP', 'Energy': 'XLE', 'Utilities': 'XLU',
    'Real Estate': 'XLRE', 'Materials': 'XLB',
  };

  static const _sectorSymbols = {
    'Technology': ['AAPL', 'MSFT', 'NVDA'],
    'Finance': ['JPM', 'BAC', 'WFC'],
    'Healthcare': ['JNJ', 'UNH', 'PFE'],
    'Consumer Cyclical': ['AMZN', 'TSLA', 'HD'],
    'Communication': ['GOOGL', 'META', 'NFLX'],
    'Industrials': ['CAT', 'BA', 'GE'],
    'Consumer Defensive': ['WMT', 'PG', 'KO'],
    'Energy': ['XOM', 'CVX', 'COP'],
    'Utilities': ['NEE', 'DUK', 'SO'],
    'Real Estate': ['PLD', 'AMT', 'EQIX'],
    'Materials': ['LIN', 'SHW', 'FCX'],
  };

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    _sectors = [];
    _sectorStocks = {};

    try {
      for (final entry in _sectorEtfs.entries) {
        try {
          final quote = await _client.getStockQuote(entry.value);
          final change = quote['changePercent'] as double;
          _sectors.add({
            'name': entry.key,
            'symbol': entry.value,
            'change': change,
          });
        } catch (_) {}
      }

      _sectors.sort((a, b) => (b['change'] as double).compareTo(a['change'] as double));

      for (final entry in _sectorSymbols.entries) {
        final stocks = <Map<String, dynamic>>[];
        for (final sym in entry.value) {
          try {
            final q = await _client.getStockQuote(sym);
            stocks.add({
              'symbol': sym,
              'companyName': q['companyName'],
              'price': q['currentPrice'],
              'change': q['changePercent'],
            });
          } catch (_) {}
        }
        stocks.sort((a, b) => (b['change'] as double).compareTo(a['change'] as double));
        _sectorStocks[entry.key] = stocks;
      }
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
  }
}

final sectorViewModel = SectorViewModel();

class SectorScreen extends ConsumerStatefulWidget {
  const SectorScreen({super.key});

  @override
  ConsumerState<SectorScreen> createState() => _SectorScreenState();
}

class _SectorScreenState extends ConsumerState<SectorScreen> {
  bool _loaded = false;
  SectorViewModel? _vm;

  @override
  void initState() {
    super.initState();
    _vm = SectorViewModel();
    Future.microtask(() async {
      await _vm!.load();
      if (mounted) setState(() => _loaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = _vm!;
    if (!_loaded) return Scaffold(appBar: AppBar(title: const Text('Sector Momentum')), body: const ShimmerLoading(count: 6));

    return Scaffold(
      appBar: AppBar(title: const Text('Sector Momentum')),
      body: RefreshIndicator(
        onRefresh: () async { await vm.load(); if (mounted) setState(() {}); },
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('Sector ETFs', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...vm.sectors.map((s) {
            final change = s['change'] as double;
            final color = change >= 0 ? Colors.green : Colors.red;
            return Card(
              margin: const EdgeInsets.only(bottom: 6),
              child: ListTile(
                title: Row(children: [
                  Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(s['symbol'] as String, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ]),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(4)),
                  child: Text('${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }),
          if (vm.sectorStocks.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...vm.sectorStocks.entries.map((e) => _sectorSection(context, e.key, e.value)),
          ],
        ]),
      ),
    );
  }

  Widget _sectorSection(BuildContext context, String name, List<Map<String, dynamic>> stocks) {
    if (stocks.isEmpty) return const SizedBox.shrink();
    return ExpansionTile(
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: stocks.map((s) {
        final change = s['change'] as double;
        final color = change >= 0 ? Colors.green : Colors.red;
        return ListTile(
          title: Text(s['symbol'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(s['companyName'] as String, style: const TextStyle(fontSize: 12)),
          trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('\$${(s['price'] as double).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
            Text('${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%', style: TextStyle(color: color, fontSize: 11)),
          ]),
        );
      }).toList(),
    );
  }
}
