import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/stockholm_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../widgets/glass_card.dart';

class InsiderTab extends StatelessWidget {
  const InsiderTab({
    super.key,
    this.transactions = const [],
    this.isLoading = false,
  });

  final List<InsiderTransactionData> transactions;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    if (transactions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_search,
                  size: 48, color: StockholmColors.textMuted),
              const SizedBox(height: 16),
              Text('No insider transactions found',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              const Text(
                'SEC Form 4 filings are pulled from EDGAR when available.',
                style: TextStyle(color: StockholmColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final buys = transactions.where((t) => _isBuy(t.type)).length;
    final sells = transactions.length - buys;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryChip('Buys', buys, StockholmColors.signalPositive),
              _summaryChip('Sells', sells, StockholmColors.signalNegative),
              _summaryChip('Total', transactions.length, StockholmColors.signalNeutral),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...transactions.map((t) {
          final isBuy = _isBuy(t.type);
          final typeColor =
              isBuy ? StockholmColors.signalPositive : StockholmColors.signalNegative;

          return GlassCard(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(t.insiderName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: typeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(t.type,
                          style: TextStyle(
                              color: typeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                  ],
                ),
                Text(t.title,
                    style: const TextStyle(
                        fontSize: 12, color: StockholmColors.textSecondary)),
                const SizedBox(height: 8),
                _row('Shares', NumberFormat.compact().format(t.shares)),
                _row('Price', '\$${t.price.toStringAsFixed(2)}'),
                _row('Value', '\$${NumberFormat.compact().format(t.totalValue)}'),
                _row('Date',
                    DateFormat('MMM d, yyyy').format(t.transactionDate)),
              ],
            ),
          );
        }),
      ],
    );
  }

  bool _isBuy(String type) {
    final u = type.toUpperCase();
    return u == 'BUY' || u == 'PURCHASE' || u == 'A';
  }

  Widget _summaryChip(String label, int count, Color color) => Column(
        children: [
          Text('$count',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: color)),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: StockholmColors.textSecondary)),
        ],
      );

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(fontSize: 13)),
            Text(v, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      );
}
