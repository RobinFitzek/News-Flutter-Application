import 'package:flutter/material.dart';
import '../../data/database/app_database.dart';
import '../../engine/top_picks.dart';
import '../../widgets/shimmer_loading.dart';

class TopPicksScreen extends StatefulWidget {
  const TopPicksScreen({super.key});

  @override
  State<TopPicksScreen> createState() => _TopPicksScreenState();
}

class _TopPicksScreenState extends State<TopPicksScreen> {
  Map<String, dynamic>? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    _data = await TopPicksEngine(AppDatabase()).getTopPicks();
    if (mounted) setState(() => _loading = false);
  }

  Color _tierColor(String tier) {
    switch (tier) {
      case 'gold':
        return Colors.amber;
      case 'silver':
        return Colors.blueGrey;
      case 'bronze':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Picks'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
      ),
      body: _loading
          ? const ShimmerLoading(count: 4)
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_data != null) ...[
                    Text('Trusted tickers: ${_data!['total_trusted']}',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 12),
                    ...((_data!['top_picks'] as List).map((p) {
                      final m = p as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                _tierColor(m['trust_tier'] as String).withAlpha(40),
                            child: Text(m['trust_tier'].toString()[0].toUpperCase()),
                          ),
                          title: Text(m['ticker'] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${m['accuracy']}% accuracy · ${m['total_predictions']} predictions'),
                          trailing: Text('${m['pick_score']}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    })),
                    const SizedBox(height: 16),
                    Text('Recent High-Confidence Signals',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    ...((_data!['recent_signals'] as List).take(10).map((s) {
                      final m = s as Map<String, dynamic>;
                      return ListTile(
                        dense: true,
                        title: Text('${m['ticker']} — ${m['signal']}'),
                        trailing: Text('${m['confidence']}%'),
                      );
                    })),
                  ],
                ],
              ),
            ),
    );
  }
}
