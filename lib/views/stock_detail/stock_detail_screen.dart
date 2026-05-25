import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/stock_detail_viewmodel.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/error_retry_widget.dart';
import '../../config/theme.dart';

class StockDetailScreen extends ConsumerStatefulWidget {
  const StockDetailScreen({super.key, required this.symbol});

  final String symbol;

  @override
  ConsumerState<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends ConsumerState<StockDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(stockDetailViewModelProvider(widget.symbol).notifier)
          .loadStock();
    });
  }

  Color _gainLossColor(BuildContext context, double change) {
    final colors = Theme.of(context).extension<StockColors>() ??
        const StockColors(gainColor: Colors.green, lossColor: Colors.red);
    return change >= 0 ? colors.gainColor : colors.lossColor;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stockDetailViewModelProvider(widget.symbol));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.symbol),
      ),
      body: state.isLoadingQuote
          ? const ShimmerLoading(count: 3)
          : state.quote == null && state.errorMessage != null
              ? ErrorRetryWidget(
                  message: state.errorMessage!,
                  onRetry: () => ref
                      .read(
                          stockDetailViewModelProvider(widget.symbol).notifier)
                      .loadStock(),
                )
              : RefreshIndicator(
                  onRefresh: () => ref
                      .read(stockDetailViewModelProvider(widget.symbol).notifier)
                      .loadStock(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.quote != null) ...[
                          _QuoteCard(
                            quote: state.quote!,
                            gainLossColor: (change) =>
                                _gainLossColor(context, change),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (state.chartData != null &&
                            state.chartData!.dataPoints.isNotEmpty) ...[
                          _MiniChart(chartData: state.chartData!),
                          const SizedBox(height: 16),
                        ] else if (state.isLoadingChart) ...[
                          const Card(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (state.quote != null) ...[
                          _KeyStatsCard(quote: state.quote!),
                          const SizedBox(height: 16),
                        ],
                        _ActionsRow(symbol: widget.symbol),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.quote, required this.gainLossColor});

  final dynamic quote;
  final Color Function(double change) gainLossColor;

  @override
  Widget build(BuildContext context) {
    final change = quote.change ?? 0.0;
    final changePercent = quote.changePercent ?? 0.0;
    final isPositive = change >= 0;
    final color = gainLossColor(change);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (quote.companyName != null && quote.companyName.isNotEmpty)
              Text(
                quote.companyName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${(quote.currentPrice as double).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        isPositive
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: color,
                        size: 18,
                      ),
                      Text(
                        '${isPositive ? "+" : ""}${change.toStringAsFixed(2)} (${isPositive ? "+" : ""}${changePercent.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (quote.dayHigh != null)
              Row(
                children: [
                  Text(
                    'Day Range: \$${(quote.dayLow as double).toStringAsFixed(2)} - \$${(quote.dayHigh as double).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Volume: ${NumberFormat.compact().format(quote.volume)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                if (quote.marketCap != null)
                  Text(
                    'Mkt Cap: ${NumberFormat.compact().format(quote.marketCap)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniChart extends StatelessWidget {
  const _MiniChart({required this.chartData});

  final dynamic chartData;

  @override
  Widget build(BuildContext context) {
    final points = chartData.dataPoints as List;
    if (points.isEmpty) return const SizedBox.shrink();

    final closes = points.map((p) => (p.close as num).toDouble()).toList();
    final minY = closes.reduce((a, b) => a < b ? a : b);
    final maxY = closes.reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;
    final isPositive = closes.last >= closes.first;
    final color = isPositive ? Colors.green : Colors.red;

    final spots = <FlSpot>[];
    for (int i = 0; i < closes.length && i < 22; i++) {
      spots.add(FlSpot(i.toDouble(), closes[i]));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1 Month Chart',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: minY - padding,
                  maxY: maxY + padding,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: (maxY - minY) / 4,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '\$${value.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: (spots.length / 4).ceilToDouble(),
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx >= 0 && idx < points.length) {
                            final date = points[idx].timestamp as DateTime;
                            return Text(
                              DateFormat('M/d').format(date),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: color,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: color.withAlpha(30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyStatsCard extends StatelessWidget {
  const _KeyStatsCard({required this.quote});

  final dynamic quote;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Statistics',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _StatRow(
              label: 'Open',
              value: quote.dayLow != null ? '\$${(quote.dayLow as double).toStringAsFixed(2)}' : '--',
            ),
            _StatRow(
              label: 'Previous Close',
              value: '\$${(quote.previousClose as double).toStringAsFixed(2)}',
            ),
            _StatRow(
              label: 'Day High',
              value: '\$${(quote.dayHigh as double).toStringAsFixed(2)}',
            ),
            _StatRow(
              label: 'Day Low',
              value: '\$${(quote.dayLow as double).toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}

class _ActionsRow extends ConsumerWidget {
  const _ActionsRow({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              try {
                final watchlistRepo = ref.read(watchlistRepositoryProvider);
                final existing = await watchlistRepo.getBySymbol(symbol);
                if (!context.mounted) return;
                if (existing != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$symbol is already in your watchlist')),
                  );
                } else {
                  await watchlistRepo.add(symbol);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$symbol added to watchlist')),
                  );
                }
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed: $e')),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Add to Watchlist'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.analytics),
            label: const Text('Analyze'),
          ),
        ),
      ],
    );
  }
}
