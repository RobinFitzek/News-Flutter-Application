import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../../data/database/app_database.dart';
import '../../engine/auto_paper_trader.dart';
import '../../widgets/glass_card.dart';

/// In-app confirmation for pending auto-trade proposals.
class AutoTradeConfirmSheet extends StatelessWidget {
  const AutoTradeConfirmSheet({
    super.key,
    required this.pending,
    required this.trader,
    required this.onDecided,
  });

  final List<AutoTradePendingData> pending;
  final AutoPaperTrader trader;
  final VoidCallback onDecided;

  static Future<void> show(
    BuildContext context, {
    required List<AutoTradePendingData> pending,
    required AutoPaperTrader trader,
    required VoidCallback onDecided,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: StockholmColors.bgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => AutoTradeConfirmSheet(
        pending: pending,
        trader: trader,
        onDecided: onDecided,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Auto-Trade Proposals',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...pending.map((p) => GlassCard(
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${p.ticker} ${p.direction}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Signal: ${p.signal} · Score ${p.score ?? '—'}',
                        style: const TextStyle(fontSize: 12, color: StockholmColors.textSecondary)),
                    Text(
                      'Entry \$${p.proposedEntryPrice.toStringAsFixed(2)} · '
                      'Size \$${p.proposedSizeUsd.toStringAsFixed(0)} · '
                      'TP \$${p.riskTpPrice.toStringAsFixed(2)} · '
                      'SL \$${p.riskSlPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 11),
                    ),
                    Text(
                      'Expires ${p.expiresAt.toLocal().toString().substring(11, 16)}',
                      style: const TextStyle(fontSize: 10, color: StockholmColors.textMuted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              await trader.skipPending(p.token);
                              onDecided();
                              if (context.mounted) Navigator.pop(context);
                            },
                            child: const Text('Skip'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await trader.confirmPending(p.token);
                              onDecided();
                              if (context.mounted) Navigator.pop(context);
                            },
                            child: const Text('Approve'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

Future<void> maybeShowAutoTradeConfirm(
  BuildContext context, {
  required AutoPaperTrader trader,
  required VoidCallback onRefresh,
}) async {
  final pending = await trader.getPendingConfirmations();
  if (pending.isEmpty || !context.mounted) return;
  await AutoTradeConfirmSheet.show(
    context,
    pending: pending,
    trader: trader,
    onDecided: onRefresh,
  );
}
