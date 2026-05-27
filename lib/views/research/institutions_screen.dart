import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/stockholm_colors.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/institutional_repository.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../widgets/glass_card.dart';

class InstitutionsScreen extends ConsumerStatefulWidget {
  const InstitutionsScreen({super.key});

  @override
  ConsumerState<InstitutionsScreen> createState() => _InstitutionsScreenState();
}

class _InstitutionsScreenState extends ConsumerState<InstitutionsScreen> {
  List<InstitutionalHolderData> _holders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final watchlist = await ref.read(watchlistRepositoryProvider).getAll();
    final symbols = watchlist.map((w) => w.symbol).toList();
    final holders =
        await ref.read(institutionalRepositoryProvider).getForSymbols(symbols);
    if (mounted) {
      setState(() {
        _holders = holders;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<InstitutionalHolderData>>{};
    for (final h in _holders) {
      grouped.putIfAbsent(h.symbol, () => []).add(h);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Institutional Holdings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _load,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : _holders.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.account_balance,
                            size: 48, color: StockholmColors.textMuted),
                        const SizedBox(height: 16),
                        const Text('No institutional data cached yet'),
                        const SizedBox(height: 8),
                        Text(
                          'Open a stock detail page to fetch Yahoo institutional ownership.',
                          style: TextStyle(
                            color: StockholmColors.textSecondary.withValues(alpha: 0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    GlassCard(
                      margin: EdgeInsets.zero,
                      child: Text(
                        '${_holders.length} holder records across ${grouped.length} watchlist symbols',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...grouped.entries.map((entry) {
                      final symbol = entry.key;
                      final rows = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () => context.push('/stock/$symbol'),
                              child: Text(
                                symbol,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ...rows.take(5).map(_holderTile),
                          const SizedBox(height: 12),
                        ],
                      );
                    }),
                  ],
                ),
    );
  }

  Widget _holderTile(InstitutionalHolderData h) {
    final change = h.change ?? 0;
    final changeColor = change > 0
        ? StockholmColors.signalPositive
        : change < 0
            ? StockholmColors.signalNegative
            : StockholmColors.textMuted;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(h.holderName,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${h.percentOut.toStringAsFixed(2)}% • \$${_formatValue(h.value)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: StockholmColors.textSecondary,
                ),
              ),
              if (change != 0)
                Text(
                  '${change > 0 ? '+' : ''}${change.toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 12, color: changeColor),
                ),
            ],
          ),
          Text(
            DateFormat.yMMMd().format(h.reportDate),
            style: const TextStyle(fontSize: 11, color: StockholmColors.textMuted),
          ),
        ],
      ),
    );
  }

  String _formatValue(double value) {
    if (value >= 1e9) return '${(value / 1e9).toStringAsFixed(1)}B';
    if (value >= 1e6) return '${(value / 1e6).toStringAsFixed(1)}M';
    return value.toStringAsFixed(0);
  }
}
