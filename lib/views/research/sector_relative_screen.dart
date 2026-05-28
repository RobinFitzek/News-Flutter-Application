import 'package:flutter/material.dart';
import '../../engine/sector_relative_screener.dart';
import '../../widgets/shimmer_loading.dart';

class SectorRelativeScreen extends StatefulWidget {
  const SectorRelativeScreen({super.key});

  @override
  State<SectorRelativeScreen> createState() => _SectorRelativeScreenState();
}

class _SectorRelativeScreenState extends State<SectorRelativeScreen> {
  final _screener = SectorRelativeScreener();
  Map<String, dynamic>? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    _data = await _screener.runScreen();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sector Screen'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
      ),
      body: _loading
          ? const ShimmerLoading(count: 4)
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_data?['contrarian'] != null) ...[
                    Text('Contrarian Pick',
                        style: Theme.of(context).textTheme.titleSmall),
                    _contrarianCard(_data!['contrarian'] as Map<String, dynamic>),
                    const SizedBox(height: 16),
                  ],
                  Text('Top Momentum Sectors',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  ...((_data?['sectors'] as List? ?? []).map((s) {
                    final sector = s as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('#${sector['rank']} ${sector['name']} (${sector['etf']})',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('1M: ${sector['return_1mo']}% · ${sector['momentum']}'),
                            const Divider(),
                            ...((sector['stocks'] as List).map((st) {
                              final stock = st as Map<String, dynamic>;
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text('${stock['ticker']} — score ${stock['score']}'),
                                subtitle: Text(
                                    'P/E ${stock['pe_ratio']} · ${stock['signal']} · \$${stock['price']}'),
                              );
                            })),
                          ],
                        ),
                      ),
                    );
                  })),
                ],
              ),
            ),
    );
  }

  Widget _contrarianCard(Map<String, dynamic> c) {
    final stock = c['stock'] as Map<String, dynamic>?;
    return Card(
      color: Colors.orange.shade50,
      child: ListTile(
        title: Text('${c['name']} (${c['etf']}) — worst sector'),
        subtitle: stock != null
            ? Text(
                '${stock['ticker']}: P/E ${stock['pe_ratio']}, score ${stock['score']}')
            : null,
      ),
    );
  }
}
