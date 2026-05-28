import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/stockholm_colors.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../widgets/glass_card.dart';

class PriceAlertsScreen extends ConsumerStatefulWidget {
  const PriceAlertsScreen({super.key});

  @override
  ConsumerState<PriceAlertsScreen> createState() => _PriceAlertsScreenState();
}

class _PriceAlertsScreenState extends ConsumerState<PriceAlertsScreen> {
  final _symbolCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  String _direction = 'above';
  List<PriceAlertData> _alerts = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    final rows = await (db.select(db.priceAlerts)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    if (mounted) setState(() => _alerts = rows);
  }

  Future<void> _addAlert() async {
    final symbol = _symbolCtrl.text.trim().toUpperCase();
    final price = double.tryParse(_priceCtrl.text.trim());
    if (symbol.isEmpty || price == null) return;

    final db = ref.read(databaseProvider);
    await db.into(db.priceAlerts).insert(
          PriceAlertsCompanion.insert(
            symbol: symbol,
            targetPrice: price,
            direction: Value(_direction),
          ),
        );
    _symbolCtrl.clear();
    _priceCtrl.clear();
    await _load();
  }

  Future<void> _deleteAlert(int id) async {
    final db = ref.read(databaseProvider);
    await (db.delete(db.priceAlerts)..where((t) => t.id.equals(id))).go();
    await _load();
  }

  @override
  void dispose() {
    _symbolCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Alerts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GlassCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _symbolCtrl,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Symbol',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _priceCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: _direction,
                        items: const [
                          DropdownMenuItem(
                              value: 'above', child: Text('Above')),
                          DropdownMenuItem(
                              value: 'below', child: Text('Below')),
                        ],
                        onChanged: (v) => setState(() => _direction = v ?? 'above'),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: _addAlert,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Alert'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _alerts.isEmpty
                ? const Center(child: Text('No price alerts set'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _alerts.length,
                    itemBuilder: (_, i) {
                      final a = _alerts[i];
                      return GlassCard(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(a.symbol[0]),
                          ),
                          title: Text(a.symbol,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            '${a.direction == 'above' ? '≥' : '≤'} \$${a.targetPrice.toStringAsFixed(2)} · '
                            '${a.triggered ? 'Triggered' : 'Active'}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _deleteAlert(a.id),
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
}
