import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../config/stockholm_colors.dart';
import '../../services/scheduler_service.dart';
import '../../widgets/glass_card.dart';

class SystemCommandCenter extends ConsumerWidget {
  const SystemCommandCenter({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduler = ref.watch(schedulerServiceProvider);
    final status = scheduler.statusSnapshot;
    final running = status['is_running'] == true;
    final periodic = status['periodic_enabled'] == true;
    final lastRun = status['last_completed_at'] as String?;
    final lastLog = status['last_log'] as Map<String, dynamic>?;

    Color dotColor;
    String stateLabel;
    if (running) {
      dotColor = StockholmColors.signalWarning;
      stateLabel = 'Running';
    } else if (periodic) {
      dotColor = StockholmColors.signalPositive;
      stateLabel = 'Active';
    } else {
      dotColor = StockholmColors.textMuted;
      stateLabel = 'Stopped';
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text('System Command Center',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(stateLabel, style: TextStyle(color: dotColor, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: running
                      ? null
                      : () async {
                          await ref.read(schedulerServiceProvider).runMaintenanceCycle();
                          onRefresh();
                        },
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Scan Now'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    if (periodic) {
                      ref.read(schedulerServiceProvider).stopPeriodic();
                    } else {
                      ref.read(schedulerServiceProvider).startPeriodic();
                    }
                    onRefresh();
                  },
                  icon: Icon(periodic ? Icons.pause : Icons.play_circle_outline, size: 18),
                  label: Text(periodic ? 'Pause' : 'Start'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _diag('Last run', lastRun != null ? _formatTime(lastRun) : '—'),
          if (lastLog != null) ...[
            _diag('Predictions verified', '${lastLog['predictions_verified'] ?? 0}'),
            _diag('Signals graded', '${lastLog['signals_graded'] ?? 0}'),
            _diag('Discoveries', '${lastLog['discoveries_saved'] ?? 0}'),
            _diag('Auto entries', '${lastLog['auto_entries'] ?? 0}'),
            _diag('Auto exits', '${lastLog['auto_exits'] ?? 0}'),
            _diag('Pipeline results', '${lastLog['pipeline_results'] ?? 0}'),
            _diag('Discovery outcomes', '${lastLog['discovery_outcomes'] ?? 0}'),
            _diag('Price alerts', '${lastLog['price_alerts_triggered'] ?? 0}'),
            if (lastLog['mcpt'] is Map)
              _diag('MCPT p-value', '${(lastLog['mcpt'] as Map)['p_value'] ?? '—'}')
            else
              _diag('MCPT', '${lastLog['mcpt'] ?? '—'}'),
            if (lastLog['error'] != null)
              _diag('Error', lastLog['error'].toString()),
          ],
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('HH:mm:ss').format(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: StockholmColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _diag(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: StockholmColors.textSecondary)),
            Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      );

  String _formatTime(String iso) {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    return DateFormat('MMM d, HH:mm').format(dt);
  }
}
