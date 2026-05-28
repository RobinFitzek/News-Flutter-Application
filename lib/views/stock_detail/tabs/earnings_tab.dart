import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/database/app_database.dart';

class EarningsTab extends StatelessWidget {
  const EarningsTab({super.key, this.earnings = const [], this.isLoading = false});

  final List<EarningsEventData> earnings;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (earnings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text('No earnings history available',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              Text(
                  'Earnings data is fetched from Yahoo Finance when available',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: earnings.length,
      itemBuilder: (context, index) {
        final e = earnings[index];
        final surprise = e.surprise ?? 0;
        final isBeat = surprise > 0;
        final beatColor = isBeat ? Colors.green : Colors.red;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.period.isNotEmpty ? e.period : 'Quarterly',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(DateFormat('MMM d, yyyy').format(e.reportDate),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDetailRow(context, 'Estimated EPS',
                    e.estimatedEps != null ? '\$${e.estimatedEps!.toStringAsFixed(2)}' : '--'),
                _buildDetailRow(context, 'Actual EPS',
                    e.actualEps != null ? '\$${e.actualEps!.toStringAsFixed(2)}' : '--'),
                _buildDetailRow(context, 'Surprise',
                    e.surprise != null ? '\$${e.surprise!.toStringAsFixed(2)} (${e.surprisePercent?.toStringAsFixed(1) ?? '0'}%)' : '--',
                    valueColor: beatColor),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: ((e.surprisePercent ?? 0).abs() / 50).clamp(0.05, 1.0),
                  color: beatColor,
                  minHeight: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor,
              )),
        ],
      ),
    );
  }
}
