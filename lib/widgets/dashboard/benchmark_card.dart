import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

class BenchmarkCard extends StatelessWidget {
  const BenchmarkCard({super.key, required this.data});

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    if (data == null || (data!['labels'] as List?)?.isEmpty != false) {
      final alpha = (data?['alpha'] as num?)?.toDouble();
      if (data != null && alpha != null && data!['message'] == null) {
        return _summaryOnly(context, data!);
      }
      return GlassCard(
        onTap: () => context.goNamed('portfolio'),
        child: const Text(
          'Add portfolio holdings to see benchmark vs SPY.',
          style: TextStyle(fontSize: 13, color: StockholmColors.textSecondary),
        ),
      );
    }

    final alpha = (data!['alpha'] as num).toDouble();
    final portRet = (data!['portfolio_return_pct'] as num).toDouble();
    final spyRet = (data!['spy_return_pct'] as num).toDouble();
    final alphaColor = alpha >= 0
        ? StockholmColors.signalPositive
        : StockholmColors.signalNegative;

    final labels = List<String>.from(data!['labels'] as List);
    final portSeries =
        List<double>.from(data!['portfolio_series'] as List);
    final spySeries = List<double>.from(data!['spy_series'] as List);

    return GlassCard(
      onTap: () => context.goNamed('portfolio'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Portfolio vs SPY',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: alphaColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Alpha ${alpha >= 0 ? '+' : ''}${alpha.toStringAsFixed(1)}%',
                  style: TextStyle(
                      color: alphaColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _legend('Portfolio', StockholmColors.signalNeutral, portRet),
              const SizedBox(width: 16),
              _legend('SPY', StockholmColors.textMuted, spyRet),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                minY: _minY(portSeries, spySeries),
                maxY: _maxY(portSeries, spySeries),
                lineBarsData: [
                  LineChartBarData(
                    spots: _spots(portSeries),
                    isCurved: true,
                    color: StockholmColors.signalNeutral,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: _spots(spySeries),
                    isCurved: true,
                    color: StockholmColors.textMuted,
                    barWidth: 1.5,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          if (labels.isNotEmpty)
            Text(
              '${labels.first} → ${labels.last}',
              style: const TextStyle(
                  fontSize: 10, color: StockholmColors.textMuted),
            ),
        ],
      ),
    );
  }

  Widget _summaryOnly(BuildContext context, Map<String, dynamic> data) {
    final alpha = (data['alpha'] as num).toDouble();
    final color = alpha >= 0
        ? StockholmColors.signalPositive
        : StockholmColors.signalNegative;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Portfolio vs SPY',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Alpha ${alpha >= 0 ? '+' : ''}${alpha.toStringAsFixed(1)}%',
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _legend(String label, Color color, double ret) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 10, height: 3, color: color),
          const SizedBox(width: 6),
          Text('$label ${ret >= 0 ? '+' : ''}${ret.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 11)),
        ],
      );

  List<FlSpot> _spots(List<double> values) =>
      List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i]));

  double _minY(List<double> a, List<double> b) {
    final all = [...a, ...b];
    if (all.isEmpty) return 90;
    return all.reduce((x, y) => x < y ? x : y) - 2;
  }

  double _maxY(List<double> a, List<double> b) {
    final all = [...a, ...b];
    if (all.isEmpty) return 110;
    return all.reduce((x, y) => x > y ? x : y) + 2;
  }
}
