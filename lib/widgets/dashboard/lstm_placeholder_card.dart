import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../glass_card.dart';

/// Honest placeholder — LSTM requires PyTorch server backend.
class LstmPlaceholderCard extends StatelessWidget {
  const LstmPlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Icon(Icons.memory, color: StockholmColors.textMuted, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LSTM Price Forecast',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: StockholmColors.textPrimary,
                        )),
                const SizedBox(height: 4),
                Text(
                  'Requires Python server with PyTorch — not available in mobile app.',
                  style: TextStyle(
                      fontSize: 12, color: StockholmColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
