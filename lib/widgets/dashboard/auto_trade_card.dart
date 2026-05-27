import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/stockholm_colors.dart';
import '../../engine/auto_paper_trader.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/paper_trading_repository.dart';
import '../../widgets/glass_card.dart';

class AutoTradeCard extends ConsumerWidget {
  const AutoTradeCard({
    super.key,
    required this.status,
    required this.onToggle,
    this.pendingCount = 0,
    this.onReviewPending,
  });

  final Map<String, dynamic>? status;
  final VoidCallback onToggle;
  final int pendingCount;
  final VoidCallback? onReviewPending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (status == null) {
      return const GlassCard(child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    final enabled = status!['enabled'] == true;
    final open = status!['open_positions'] as int? ?? 0;
    final winRate = status!['win_rate'] as num? ?? 0;
    final pnl = status!['total_pnl_pct'] as num? ?? 0;
    final trusted = (status!['trust_gate'] as Map?)?['trusted'] == true;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Auto Paper Trade',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Switch(
                value: enabled,
                onChanged: (_) async {
                  final db = ref.read(databaseProvider);
                  final trader = AutoPaperTrader(
                    db,
                    paperRepo: ref.read(paperTradingRepositoryProvider),
                  );
                  await trader.setEnabled(!enabled);
                  onToggle();
                },
              ),
            ],
          ),
          Row(
            children: [
              _chip(enabled ? 'Active' : 'Paused',
                  enabled ? StockholmColors.signalPositive : StockholmColors.textMuted),
              const SizedBox(width: 6),
              _chip(trusted ? 'Trusted' : 'Learning',
                  trusted ? StockholmColors.signalNeutral : StockholmColors.signalWarning),
            ],
          ),
          const SizedBox(height: 10),
          _row('Open positions', '$open'),
          _row('Win rate', '${winRate.toStringAsFixed(1)}%'),
          _row('Total P&L', '${pnl >= 0 ? '+' : ''}${pnl.toStringAsFixed(1)}%'),
          if (pendingCount > 0) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onReviewPending,
                icon: const Icon(Icons.notifications_active, size: 16),
                label: Text('Review $pendingCount proposal${pendingCount == 1 ? '' : 's'}'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _chip(String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
      );

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(fontSize: 12, color: StockholmColors.textSecondary)),
            Text(v, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
