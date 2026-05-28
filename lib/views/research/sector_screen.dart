import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../engine/sector_momentum.dart';
import '../../widgets/shimmer_loading.dart';

class SectorScreen extends ConsumerStatefulWidget {
  const SectorScreen({super.key});

  @override
  ConsumerState<SectorScreen> createState() => _SectorScreenState();
}

class _SectorScreenState extends ConsumerState<SectorScreen> {
  final _engine = SectorMomentum();
  List<Map<String, dynamic>> _rankings = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      _rankings = await _engine.getSectorRankings();
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  Color _parseColor(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sector Momentum')),
        body: const ShimmerLoading(count: 4),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sector Momentum')),
        body: Center(child: Text(_error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sector Momentum'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _rankings.length,
          itemBuilder: (context, i) {
            final s = _rankings[i];
            final color = _parseColor(s['color'] as String);
            final momentum = s['momentum'] as String;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.2),
                  child: Text('${i + 1}',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                ),
                title: Text('${s['name']} (${s['etf']})',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  '1W: ${s['return_1wk']}% • 1M: ${s['return_1mo']}% • 3M: ${s['return_3mo']}% • RS: ${s['relative_strength']}%',
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: momentum == 'hot'
                        ? Colors.orange.shade100
                        : momentum == 'cold'
                            ? Colors.blue.shade100
                            : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    momentum.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: momentum == 'hot'
                          ? Colors.orange.shade800
                          : momentum == 'cold'
                              ? Colors.blue.shade800
                              : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
