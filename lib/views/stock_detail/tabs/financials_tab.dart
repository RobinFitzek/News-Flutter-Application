import 'package:flutter/material.dart';
import '../../../data/database/app_database.dart';

class FinancialsTab extends StatelessWidget {
  const FinancialsTab({super.key, this.ratios, this.isLoading = false});

  final FinancialRatioData? ratios;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ratios == null) {
      return const Center(child: Text('Financial data unavailable'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Valuation',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildRow(context, 'P/E Ratio', ratios!.peRatio,
                    suffix: 'x'),
                _buildRow(context, 'P/B Ratio', ratios!.pbRatio,
                    suffix: 'x'),
                _buildRow(context, 'EPS', ratios!.eps, prefix: '\$'),
                _buildRow(context, 'Dividend Yield', ratios!.dividendYield,
                    suffix: '%', isPercent: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Risk',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildRow(context, 'Beta', ratios!.beta),
                _buildRow(context, '52-Week High', ratios!.week52High,
                    prefix: '\$'),
                _buildRow(context, '52-Week Low', ratios!.week52Low,
                    prefix: '\$'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profitability',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildRow(context, 'Profit Margin', ratios!.profitMargin,
                    suffix: '%', isPercent: true),
                _buildRow(context, 'Return on Equity', ratios!.roe,
                    suffix: '%', isPercent: true),
                _buildRow(context, 'Revenue Growth', ratios!.revenueGrowth,
                    suffix: '%', isPercent: true),
                _buildRow(context, 'Debt to Equity',
                    ratios!.debtToEquity, suffix: 'x'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String label, dynamic value,
      {String prefix = '', String suffix = '', bool isPercent = false}) {
    String displayValue;
    if (value == null) {
      displayValue = '--';
    } else if (value is String) {
      displayValue = value.isEmpty ? '--' : '$prefix$value$suffix';
    } else if (isPercent) {
      displayValue =
          '$prefix${((value as double) * 100).toStringAsFixed(2)}%';
    } else if (value is double) {
      displayValue = '$prefix${value.toStringAsFixed(2)}$suffix';
    } else {
      displayValue = '$prefix$value$suffix';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(displayValue,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
