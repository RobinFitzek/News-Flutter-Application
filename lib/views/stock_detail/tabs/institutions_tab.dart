import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/stockholm_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../widgets/glass_card.dart';

class InstitutionsTab extends StatelessWidget {
  const InstitutionsTab({
    super.key,
    this.holders = const [],
    this.isLoading = false,
  });

  final List<InstitutionalHolderData> holders;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    if (holders.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance,
                  size: 48, color: StockholmColors.textMuted),
              SizedBox(height: 16),
              Text('No institutional holdings data'),
              SizedBox(height: 8),
              Text(
                'Yahoo Finance institutional ownership will appear after refresh.',
                style: TextStyle(color: StockholmColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final totalPct =
        holders.fold<double>(0, (s, h) => s + h.percentOut);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${holders.length} holders tracked',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('Top ${totalPct.toStringAsFixed(1)}% reported',
                  style: const TextStyle(
                      fontSize: 12, color: StockholmColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...holders.map((h) {
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
                Row(
                  children: [
                    Expanded(
                      child: Text(h.holderName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text('${h.percentOut.toStringAsFixed(1)}%',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                _row('Shares', NumberFormat.compact().format(h.shares)),
                _row('Value', '\$${NumberFormat.compact().format(h.value)}'),
                _row('Report', DateFormat('MMM d, yyyy').format(h.reportDate)),
                if (change != 0)
                  _row('Position change',
                      '${change > 0 ? '+' : ''}${NumberFormat.compact().format(change)}',
                      color: changeColor),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _row(String k, String v, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(fontSize: 13)),
            Text(v,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color)),
          ],
        ),
      );
}
