import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/geopolitical_repository.dart';
import '../../data/database/app_database.dart';
import '../../engine/geopolitical_scanner.dart';
import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_loading.dart';

class GeopoliticalScreen extends ConsumerStatefulWidget {
  const GeopoliticalScreen({super.key});

  @override
  ConsumerState<GeopoliticalScreen> createState() => _GeopoliticalScreenState();
}

class _GeopoliticalScreenState extends ConsumerState<GeopoliticalScreen> {
  GeopoliticalEventData? _scan;
  List<GeopoliticalEventData> _history = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(geopoliticalRepositoryProvider);
      _scan = await repo.getLatestScan();
      _history = await repo.getHistory(limit: 5);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _scanNow() async {
    setState(() { _loading = true; _error = null; });
    try {
      final repo = ref.read(geopoliticalRepositoryProvider);
      _scan = await repo.runScan();
      _history = await repo.getHistory(limit: 5);
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final events = _scan != null
        ? GeopoliticalScanner.parseGeoText(_scan!.rawSummary)['events'] as List
        : <dynamic>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geopolitical Radar'),
        actions: [
          IconButton(onPressed: _loading ? null : _scanNow, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _loading && _scan == null
          ? const ShimmerLoading(count: 3)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_error != null)
                  GlassCard(
                    child: Text(_error!, style: const TextStyle(color: StockholmColors.signalNegative)),
                  ),
                if (_scan != null) ...[
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Severity ${_scan!.severity}',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                              _scan!.scannedAt.toLocal().toString().substring(0, 16),
                              style: const TextStyle(fontSize: 11, color: StockholmColors.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(_scan!.summary, style: const TextStyle(fontSize: 14, height: 1.5)),
                      ],
                    ),
                  ),
                  if (events.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text('Events', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...events.map((e) => GlassCard(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Expanded(child: Text(e['headline']?.toString() ?? '')),
                              Text('S${e['severity']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                  ],
                ] else
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.public, size: 64, color: StockholmColors.textMuted),
                        const SizedBox(height: 16),
                        const Text('No geopolitical scan yet'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(onPressed: _scanNow, icon: const Icon(Icons.search), label: const Text('Scan Now')),
                      ],
                    ),
                  ),
                if (_history.length > 1) ...[
                  const SizedBox(height: 16),
                  Text('History', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  ..._history.skip(1).map((h) => GlassCard(
                        margin: const EdgeInsets.only(top: 6),
                        child: Text('${h.scannedAt.toLocal().toString().substring(0, 16)} · Severity ${h.severity}\n${h.summary}',
                            maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                      )),
                ],
              ],
            ),
    );
  }
}
