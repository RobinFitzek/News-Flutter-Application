import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

class IntelStrip extends StatelessWidget {
  const IntelStrip({super.key, required this.stats});

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    final items = [
      _IntelItem('Hit Rate', '${stats['hit_rate'] ?? 0}%', Icons.track_changes),
      _IntelItem('Verified', '${stats['verified'] ?? 0}', Icons.check_circle_outline),
      _IntelItem('Pending', '${stats['pending'] ?? 0}', Icons.hourglass_empty),
      _IntelItem('Discoveries', '${stats['discoveries_7d'] ?? 0}', Icons.explore),
    ];

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final item = items[i];
          return SizedBox(
            width: 120,
            child: GlassCard(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(8),
              onTap: () => context.push('/learning'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 14, color: StockholmColors.signalNeutral),
                  const SizedBox(height: 4),
                  Text(item.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(item.label, style: const TextStyle(fontSize: 9, color: StockholmColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IntelItem {
  const _IntelItem(this.label, this.value, this.icon);
  final String label;
  final String value;
  final IconData icon;
}
