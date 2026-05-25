import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../widgets/shimmer_loading.dart';

class EconomicCalendarScreen extends ConsumerStatefulWidget {
  const EconomicCalendarScreen({super.key});

  @override
  ConsumerState<EconomicCalendarScreen> createState() => _EconomicCalendarScreenState();
}

class _EconomicCalendarScreenState extends ConsumerState<EconomicCalendarScreen> {
  List<Map<String, dynamic>> _events = [];
  bool _loaded = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loaded = false; _error = null; });
    try {
      final client = YahooFinanceClient();
      final db = ref.read(databaseProvider);
      final items = await db.select(db.watchlistItems).get();
      final symbols = items.map((i) => i.symbol).toList();
      if (symbols.isEmpty) {
        symbols.addAll(['AAPL', 'MSFT', 'SPY']);
      }

      for (final sym in symbols.take(10)) {
        try {
          final earnings = await client.getEarningsHistory(sym);
          for (final e in earnings) {
            final date = DateTime.parse(e['reportDate'] as String);
            if (date.isAfter(DateTime.now().subtract(const Duration(days: 30)))) {
              _events.add({
                'symbol': sym,
                'type': 'earnings',
                'date': date,
                'description': '${e['period'] ?? 'Q'} earnings',
                'estimated': e['estimatedEps'],
              });
            }
          }
        } catch (_) {}
      }

      try {
        final spyDivs = await client.getCorporateActions('SPY');
        for (final d in spyDivs.where((d) => d['type'] == 'dividend')) {
          final date = DateTime.parse(d['date'] as String);
          if (date.isAfter(DateTime.now().subtract(const Duration(days: 30)))) {
            _events.add({
              'symbol': 'SPY',
              'type': 'dividend',
              'date': date,
              'description': d['description'],
              'amount': d['amount'],
            });
          }
        }
      } catch (_) {}

      _events.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Economic Calendar')),
      body: !_loaded ? const ShimmerLoading(count: 5) : RefreshIndicator(
        onRefresh: _load,
        child: _error != null ? Center(child: Text(_error!)) : _events.isEmpty ? const Center(child: Text('No upcoming events')) :
        ListView.builder(
          itemCount: _events.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            final e = _events[i];
            final isEarnings = e['type'] == 'earnings';
            final date = e['date'] as DateTime;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isEarnings ? Colors.orange.shade100 : Colors.green.shade100,
                  child: Icon(isEarnings ? Icons.trending_up : Icons.monetization_on, color: isEarnings ? Colors.orange : Colors.green),
                ),
                title: Row(children: [
                  Text(e['symbol'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isEarnings ? Colors.orange.withAlpha(30) : Colors.green.withAlpha(30), borderRadius: BorderRadius.circular(4)), child: Text(e['type'] as String, style: const TextStyle(fontSize: 11))),
                ]),
                subtitle: Text(e['description'] as String? ?? ''),
                trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(DateFormat('MMM d').format(date), style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (e['estimated'] != null) Text('Est: \$${e['estimated']?.toStringAsFixed(2)}', style: const TextStyle(fontSize: 11)),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
