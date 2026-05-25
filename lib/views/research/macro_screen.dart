import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class MacroViewModel {
  MacroViewModel();
  bool _isLoading = false;
  Map<String, dynamic>? _data;
  String? _error;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get data => _data;
  String? get error => _error;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    try {
      final client = YahooFinanceClient();
      final indicators = <String, Map<String, dynamic>>{};

      for (final symbol in ['^GSPC', '^IXIC', '^DJI', '^VIX', 'TLT', 'GLD', 'USO', 'UUP']) {
        try {
          final quote = await client.getStockQuote(symbol);
          indicators[symbol] = {
            'price': quote['currentPrice'],
            'change': quote['change'],
            'changePercent': quote['changePercent'],
            'name': _getName(symbol),
          };
        } catch (_) {}
      }
      _data = indicators;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
  }

  String _getName(String symbol) {
    switch (symbol) {
      case '^GSPC': return 'S&P 500';
      case '^IXIC': return 'Nasdaq';
      case '^DJI': return 'Dow Jones';
      case '^VIX': return 'VIX Volatility';
      case 'TLT': return '20Y Treasury Bonds';
      case 'GLD': return 'Gold';
      case 'USO': return 'Oil';
      case 'UUP': return 'US Dollar';
      default: return symbol;
    }
  }
}

class MacroScreen extends ConsumerStatefulWidget {
  const MacroScreen({super.key});

  @override
  ConsumerState<MacroScreen> createState() => _MacroScreenState();
}

class _MacroScreenState extends ConsumerState<MacroScreen> {
  final _vm = MacroViewModel();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _vm.load();
      if (mounted) setState(() => _loaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return Scaffold(appBar: AppBar(title: const Text('Macro Dashboard')), body: const ShimmerLoading(count: 4));
    if (_vm.error != null) return Scaffold(appBar: AppBar(title: const Text('Macro Dashboard')), body: Center(child: Text(_vm.error!)));

    final data = _vm.data;

    return Scaffold(
      appBar: AppBar(title: const Text('Macro Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async { await _vm.load(); if (mounted) setState(() {}); },
        child: ListView(padding: const EdgeInsets.all(16), children: [
          _section(context, 'Indices'),
          _indicatorCard(context, data?['^GSPC']),
          _indicatorCard(context, data?['^IXIC']),
          _indicatorCard(context, data?['^DJI']),
          const SizedBox(height: 16),
          _section(context, 'Volatility & Bonds'),
          _indicatorCard(context, data?['^VIX']),
          _indicatorCard(context, data?['TLT']),
          const SizedBox(height: 16),
          _section(context, 'Commodities'),
          _indicatorCard(context, data?['GLD']),
          _indicatorCard(context, data?['USO']),
          _indicatorCard(context, data?['UUP']),
        ]),
      ),
    );
  }

  Widget _section(BuildContext context, String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
  );

  Widget _indicatorCard(BuildContext context, Map<String, dynamic>? data) {
    if (data == null) return const SizedBox.shrink();
    final price = data['price'] as double;
    final change = data['change'] as double;
    final changePct = data['changePercent'] as double;
    final isPositive = change >= 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(data['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
          Text('${isPositive ? "+" : ""}${change.toStringAsFixed(2)} (${isPositive ? "+" : ""}${changePct.toStringAsFixed(2)}%)',
              style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12)),
        ]),
      ),
    );
  }
}
