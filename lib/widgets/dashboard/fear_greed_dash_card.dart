import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

class FearGreedDashCard extends StatelessWidget {
  const FearGreedDashCard({super.key, required this.data});

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const GlassCard(child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    final score = (data!['score'] as num?)?.toDouble() ??
        (data!['fg_value'] as num?)?.toDouble() ??
        50;
    final label = data!['sentiment']?.toString() ??
        data!['fg_label']?.toString() ??
        'Neutral';
    final vix = data!['vix'] as num?;

    Color color;
    if (score <= 25) {
      color = StockholmColors.signalNegative;
    } else if (score >= 75) {
      color = StockholmColors.signalPositive;
    } else {
      color = StockholmColors.signalWarning;
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fear & Greed', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('${score.round()}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 6,
              backgroundColor: StockholmColors.borderPrimary,
              color: color,
            ),
          ),
          if (vix != null) ...[
            const SizedBox(height: 8),
            Text('VIX ${vix.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 11, color: StockholmColors.textSecondary)),
          ],
        ],
      ),
    );
  }
}
