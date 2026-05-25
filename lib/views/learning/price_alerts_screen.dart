import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceAlertsScreen extends ConsumerStatefulWidget {
  const PriceAlertsScreen({super.key});

  @override
  ConsumerState<PriceAlertsScreen> createState() => _PriceAlertsScreenState();
}

class _PriceAlertsScreenState extends ConsumerState<PriceAlertsScreen> {
  final _symbolCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final List<Map<String, String>> _alerts = [];

  @override
  void dispose() { _symbolCtrl.dispose(); _priceCtrl.dispose(); super.dispose(); }

  void _addAlert() {
    final symbol = _symbolCtrl.text.trim().toUpperCase();
    final price = _priceCtrl.text.trim();
    if (symbol.isNotEmpty && price.isNotEmpty) {
      setState(() => _alerts.add({'symbol': symbol, 'price': price, 'created': DateTime.now().toString().substring(0, 16)}));
      _symbolCtrl.clear();
      _priceCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Alerts')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: TextField(controller: _symbolCtrl, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder()))),
          const SizedBox(width: 8),
          SizedBox(width: 120, child: TextField(controller: _priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()))),
          const SizedBox(width: 8),
          IconButton(onPressed: _addAlert, icon: const Icon(Icons.add_circle, color: Colors.green)),
        ])),
        Expanded(
          child: _alerts.isEmpty
            ? const Center(child: Text('No price alerts set'))
            : ListView.builder(
                itemCount: _alerts.length,
                itemBuilder: (_, i) {
                  final a = _alerts[i];
                  return Card(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), child: ListTile(
                    leading: CircleAvatar(child: Text(a['symbol']?[0] ?? '?')),
                    title: Text(a['symbol'] ?? ''),
                    subtitle: Text('\$${a['price']} • ${a['created']}'),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => _alerts.removeAt(i))),
                  ));
                },
              ),
        ),
      ]),
    );
  }
}
