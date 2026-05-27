import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

class EconomicCalendarCard extends StatelessWidget {
  const EconomicCalendarCard({super.key, required this.events});

  final List<Map<String, dynamic>> events;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () => context.push('/research/calendar'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Economic Calendar',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text('${events.length} upcoming',
                  style: const TextStyle(
                      fontSize: 11, color: StockholmColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          if (events.isEmpty)
            const Text('No events in the next 14 days.',
                style: TextStyle(fontSize: 12, color: StockholmColors.textSecondary))
          else
            ...events.take(4).map((e) {
              final impact = e['impact']?.toString() ?? 'medium';
              final color = impact == 'high'
                  ? StockholmColors.signalNegative
                  : impact == 'medium'
                      ? StockholmColors.signalWarning
                      : StockholmColors.signalNeutral;
              final date = e['date'] as DateTime;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 28,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e['name']?.toString() ?? e['type']?.toString() ?? '',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${e['symbol']} · ${DateFormat('MMM d').format(date)}',
                            style: const TextStyle(
                                fontSize: 10, color: StockholmColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
