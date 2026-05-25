import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/database/app_database.dart';

class InstitutionsTab extends StatelessWidget {
  const InstitutionsTab(
      {super.key, this.holders = const [], this.isLoading = false});

  final List<InstitutionalHolderData> holders;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (holders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text('No institutional holdings data',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              Text(
                  'Institutional holdings data will be available in a future update',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: holders.length,
      itemBuilder: (context, index) {
        final h = holders[index];
        final change = h.change ?? 0;
        final changeIcon = change > 0
            ? Icons.arrow_upward
            : change < 0
                ? Icons.arrow_downward
                : null;
        final changeColor =
            change > 0 ? Colors.green : change < 0 ? Colors.red : null;

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
                    Expanded(
                      child: Text(h.holderName,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Text(
                        '${h.percentOut.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 8),
                _buildDetailRow(context, 'Shares',
                    NumberFormat.compact().format(h.shares)),
                _buildDetailRow(context, 'Value',
                    '\$${NumberFormat.compact().format(h.value)}'),
                _buildDetailRow(context, 'Report Date',
                    DateFormat('MMM d, yyyy').format(h.reportDate)),
                if (changeIcon != null)
                  _buildDetailRow(context, 'Change',
                      '${change > 0 ? "+" : ""}${NumberFormat.compact().format(change.abs())} shares',
                      trailing: Icon(changeIcon,
                          size: 14, color: changeColor)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              if (trailing != null) ...[
                const SizedBox(width: 4),
                trailing,
              ],
            ],
          ),
        ],
      ),
    );
  }
}
