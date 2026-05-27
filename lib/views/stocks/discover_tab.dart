import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/discovery_viewmodel.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../engine/discovery_hit_rate.dart';
import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

class DiscoverTab extends ConsumerStatefulWidget {
  const DiscoverTab({super.key});

  @override
  ConsumerState<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends ConsumerState<DiscoverTab> {
  Map<String, dynamic>? _hitRate;
  List<Map<String, dynamic>> _strategyRates = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(discoveryViewModelProvider.notifier).loadDiscoveries();
      _loadHitRates();
    });
  }

  Future<void> _loadHitRates() async {
    final engine = DiscoveryHitRate(ref.read(databaseProvider));
    await engine.checkOutcomes();
    final overall = await engine.getOverallHitRate();
    final strategies = await engine.getStrategyHitRates();
    if (mounted) {
      setState(() {
        _hitRate = overall;
        _strategyRates = strategies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoveryViewModelProvider);

    return Stack(
      children: [
        if (state.isDiscovering)
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Scanning with quant engine...'),
              ],
            ),
          )
        else if (state.discoveries.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.explore,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(height: 16),
                  Text('Discover new opportunities',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Quant momentum scan (free) + optional AI enrichment',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => ref
                        .read(discoveryViewModelProvider.notifier)
                        .runDiscovery(),
                    icon: const Icon(Icons.analytics),
                    label: const Text('Run Discovery Scan'),
                  ),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(state.errorMessage!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                        textAlign: TextAlign.center),
                  ],
                ],
              ),
            ),
          )
        else
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.discoveries.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_hitRate?['available'] == true)
                      GlassCard(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Discovery Hit Rates',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              _hitRow('30d',
                                  '${_hitRate!['hit_rate_30d']}% avg ${_hitRate!['avg_return_30d']}%'),
                              _hitRow('90d',
                                  '${_hitRate!['hit_rate_90d']}% avg ${_hitRate!['avg_return_90d']}%'),
                              if (_strategyRates.isNotEmpty) ...[
                                const Divider(height: 16),
                                ..._strategyRates.take(3).map((s) => _hitRow(
                                      s['strategy'],
                                      '30d ${s['hit_rate_30d']}% · 60d ${s['hit_rate_60d']}% · 90d ${s['hit_rate_90d']}%',
                                    )),
                              ],
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${state.discoveries.length} discoveries',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      fontWeight: FontWeight.bold)),
                          TextButton.icon(
                            onPressed: () {
                              ref
                                  .read(discoveryViewModelProvider.notifier)
                                  .runDiscovery();
                              _loadHitRates();
                            },
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              final d = state.discoveries[index - 1];
              return _DiscoveryCard(
                discovery: d,
                onPromote: () => _promoteToWatchlist(d),
                onDismiss: () =>
                    ref.read(discoveryViewModelProvider.notifier).dismissDiscovery(d.id),
              );
            },
          ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: state.isDiscovering
                ? null
                : () => ref
                    .read(discoveryViewModelProvider.notifier)
                    .runDiscovery(),
            child: const Icon(Icons.psychology),
          ),
        ),
      ],
    );
  }

  Widget _hitRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: StockholmColors.textSecondary)),
            Text(value,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      );

  Future<void> _promoteToWatchlist(DiscoveryData d) async {
    try {
      final repo = ref.read(watchlistRepositoryProvider);
      final existing = await repo.getBySymbol(d.symbol);
      if (!mounted) return;
      if (existing != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${d.symbol} already in watchlist')));
        return;
      }
      await repo.add(d.symbol);
      await ref.read(discoveryViewModelProvider.notifier).promoteToWatchlist(d.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${d.symbol} added to watchlist')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed: $e')));
    }
  }
}

class _DiscoveryCard extends StatelessWidget {
  const _DiscoveryCard({
    required this.discovery,
    required this.onPromote,
    required this.onDismiss,
  });

  final DiscoveryData discovery;
  final VoidCallback onPromote;
  final VoidCallback onDismiss;

  Color _strategyColor(String strategy) {
    switch (strategy.toLowerCase()) {
      case 'value':
        return Colors.blue;
      case 'growth':
        return Colors.green;
      case 'momentum':
        return Colors.orange;
      case 'dividend':
        return Colors.teal;
      case 'turnaround':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _strategyColor(discovery.strategy),
                  radius: 18,
                  child: Text(
                    discovery.symbol.length > 4
                        ? discovery.symbol.substring(0, 4)
                        : discovery.symbol,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(discovery.symbol,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (discovery.companyName.isNotEmpty)
                        Text(discovery.companyName,
                            style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        '\$${discovery.currentPrice.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontWeight: FontWeight.w600)),
                    if (discovery.potentialUpside != null)
                      Text(
                          '+${discovery.potentialUpside!.toStringAsFixed(1)}%',
                          style: TextStyle(
                              color: Colors.green.shade700, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _strategyColor(discovery.strategy).withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(discovery.strategy,
                  style: TextStyle(
                      color: _strategyColor(discovery.strategy),
                      fontWeight: FontWeight.w600,
                      fontSize: 11)),
            ),
            const SizedBox(height: 8),
            Text(discovery.reason, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.auto_awesome, size: 12, color: Colors.amber.shade700),
                const SizedBox(width: 4),
                Text(
                    '${(discovery.confidence * 100).toStringAsFixed(0)}% confidence',
                    style: TextStyle(
                        fontSize: 11, color: Colors.amber.shade700)),
                const Spacer(),
                if (!discovery.isPromoted) ...[
                  TextButton.icon(
                    onPressed: onPromote,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add', style: TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8)),
                  ),
                  const SizedBox(width: 4),
                ],
                TextButton.icon(
                  onPressed: onDismiss,
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Dismiss', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
