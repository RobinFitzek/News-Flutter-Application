import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/stockholm_colors.dart';
import '../../data/database/app_database.dart';
import '../../widgets/glass_card.dart';

class GeoRadarCard extends StatelessWidget {
  const GeoRadarCard({
    super.key,
    required this.scan,
    required this.exposures,
  });

  final GeopoliticalEventData? scan;
  final List<Map<String, dynamic>> exposures;

  @override
  Widget build(BuildContext context) {
    final severity = scan?.severity ?? 0;
    Color sevColor;
    if (severity >= 8) {
      sevColor = StockholmColors.signalNegative;
    } else if (severity >= 5) {
      sevColor = StockholmColors.signalWarning;
    } else {
      sevColor = StockholmColors.signalPositive;
    }

    return GlassCard(
      onTap: () => context.push('/research/geo'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.public, size: 18, color: StockholmColors.signalNeutral),
              const SizedBox(width: 8),
              Text('Geopolitical Radar',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              if (scan != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: sevColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Severity $severity',
                      style: TextStyle(color: sevColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            scan?.summary ?? 'No recent scan — tap to run geopolitical assessment.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, height: 1.4, color: StockholmColors.textSecondary),
          ),
          if (exposures.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: exposures.take(12).map((e) {
                final score = (e['geo_risk_score'] as num?)?.toInt() ?? 5;
                final color = score >= 7
                    ? StockholmColors.signalNegative
                    : score >= 4
                        ? StockholmColors.signalWarning
                        : StockholmColors.signalPositive;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    e['ticker']?.toString() ?? '',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
