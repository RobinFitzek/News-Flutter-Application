import 'package:flutter/material.dart';
import '../../data/database/app_database.dart';
import '../../engine/top_picks.dart';
import '../../widgets/shimmer_loading.dart';

class GraveyardScreen extends StatefulWidget {
  const GraveyardScreen({super.key});

  @override
  State<GraveyardScreen> createState() => _GraveyardScreenState();
}

class _GraveyardScreenState extends State<GraveyardScreen> {
  List<Map<String, dynamic>> _results = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final db = AppDatabase();
    _results = await GraveyardTracker(db).getPerformance();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticker Graveyard')),
      body: _loading
          ? const ShimmerLoading(count: 3)
          : _results.isEmpty
              ? const Center(child: Text('No graveyard entries yet'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _results.length,
                  itemBuilder: (_, i) {
                    final r = _results[i];
                    final pct = r['change_pct'] as double;
                    return Card(
                      child: ListTile(
                        title: Text(r['ticker'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${r['reason']}\nRemoved ${r['removed_at']}'),
                        trailing: Text(
                          '${pct >= 0 ? '+' : ''}${pct.toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: pct >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
