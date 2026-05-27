import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

class MarketRegimeCard extends StatelessWidget {
  const MarketRegimeCard({super.key, required this.regime});

  final Map<String, dynamic>? regime;

  @override
  Widget build(BuildContext context) {
    if (regime == null) {
      return const GlassCard(child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    final name = regime!['regime']?.toString() ?? 'choppy';
    final spy = regime!['spy_price'] as num?;
    final vix = regime!['vix'] as num?;
    final yield10 = regime!['ten_year_yield'] as num?;
    final sma50 = regime!['sma50'] as num?;
    final sma200 = regime!['sma200'] as num?;

    Color badgeColor;
    String label;
    switch (name) {
      case 'bull':
        badgeColor = StockholmColors.signalPositive;
        label = 'Bull';
        break;
      case 'bear':
        badgeColor = StockholmColors.signalNegative;
        label = 'Bear';
        break;
      default:
        badgeColor = StockholmColors.signalNeutral;
        label = 'Choppy';
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Market Regime', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: badgeColor.withValues(alpha: 0.4)),
                ),
                child: Text(label, style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _row('SPY', spy != null ? '\$${spy.toStringAsFixed(2)}' : '—'),
          _row('VIX', vix?.toStringAsFixed(1) ?? '—'),
          _row('10Y Yield', yield10 != null ? '${yield10.toStringAsFixed(2)}%' : '—'),
          if (sma50 != null && sma200 != null)
            _row('SMA50/200', sma50 > sma200 ? 'Bullish cross' : 'Bearish cross'),
        ],
      ),
    );
  }

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
