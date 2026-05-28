import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../glass_card.dart';

class SentimentMoversCard extends StatelessWidget {
  const SentimentMoversCard({super.key, required this.movers});

  final List<Map<String, dynamic>> movers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: GlassCard(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.newspaper, color: Theme.of(context).colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text('Sentiment Movers (24h)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            if (movers.isEmpty)
              const Text('No NLP headline shifts yet.',
                  style: TextStyle(color: StockholmColors.textSecondary, fontSize: 13))
            else
              ...movers.take(5).map((m) {
                final delta = (m['delta'] as num?)?.toDouble() ?? 0;
                final color = delta >= 0
                    ? StockholmColors.signalPositive
                    : StockholmColors.signalNegative;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 52,
                        child: Text(m['ticker']?.toString() ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        child: Text(
                          '${m['total_headlines'] ?? 0} headlines',
                          style: const TextStyle(
                            color: StockholmColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(2)}',
                        style: TextStyle(color: color, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
