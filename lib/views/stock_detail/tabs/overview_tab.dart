import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../widgets/error_retry_widget.dart';
import '../widgets/technical_intel_section.dart';
import '../../../data/repositories/watchlist_repository.dart';

class OverviewTab extends ConsumerWidget {
  const OverviewTab({
    super.key,
    required this.quote,
    this.chartData,
    this.isLoadingChart = false,
    required this.gainLossColor,
    required this.symbol,
    this.onRefresh,
    this.onChartRangeChanged,
  });

  final StockCacheData? quote;
  final dynamic chartData;
  final bool isLoadingChart;
  final Color Function(double change) gainLossColor;
  final String symbol;
  final VoidCallback? onRefresh;
  final Function(String range)? onChartRangeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (quote == null) {
      return Center(
        child: ErrorRetryWidget(
          message: 'Failed to load stock data',
          onRetry: onRefresh,
        ),
      );
    }

    final change = quote!.change;
    final changePercent = quote!.changePercent;
    final isPositive = change >= 0;
    final color = gainLossColor(change);

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuoteCard(context, isPositive, color, change, changePercent),
            const SizedBox(height: 16),
            _buildChartCard(context),
            const SizedBox(height: 16),
            _buildKeyStatsCard(context),
            const SizedBox(height: 16),
            TechnicalIntelSection(symbol: symbol),
            const SizedBox(height: 16),
            _buildStockNotes(context, ref),
            const SizedBox(height: 16),
            _buildActionsRow(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context, bool isPositive, Color color,
      double change, double changePercent) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (quote!.companyName.isNotEmpty)
              Text(
                quote!.companyName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${quote!.currentPrice.toStringAsFixed(2)}',
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
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Day Range: \$${quote!.dayLow.toStringAsFixed(2)} - \$${quote!.dayHigh.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Volume: ${NumberFormat.compact().format(quote!.volume)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                if (quote!.marketCap != null)
                  Text(
                    'Mkt Cap: ${NumberFormat.compact().format(quote!.marketCap!)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(BuildContext context) {
    if (isLoadingChart) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (chartData == null) return const SizedBox.shrink();

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
            Text('1 Month Chart',
                style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(children: [
            _rangeChip(context, '1W', '5d'),
            _rangeChip(context, '1M', '1mo'),
            _rangeChip(context, '3M', '3mo'),
            _rangeChip(context, '6M', '6mo'),
          ]),
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
                        getTitlesWidget: (value, meta) => Text(
                          '\$${value.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 10),
                        ),
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
                            return Text(DateFormat('M/d').format(date),
                                style: const TextStyle(fontSize: 10));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
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

  Widget _rangeChip(BuildContext context, String label, String range) => Padding(
    padding: const EdgeInsets.only(right: 6),
    child: ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      onPressed: () => onChartRangeChanged?.call(range),
      visualDensity: VisualDensity.compact,
    ),
  );

  Widget _buildKeyStatsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Key Statistics',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _statRow(context, 'Previous Close',
                '\$${quote!.previousClose.toStringAsFixed(2)}'),
            _statRow(context, 'Day High',
                '\$${quote!.dayHigh.toStringAsFixed(2)}'),
            _statRow(context, 'Day Low',
                '\$${quote!.dayLow.toStringAsFixed(2)}'),
            if (quote!.marketCap != null)
              _statRow(context, 'Market Cap',
                  NumberFormat.compact().format(quote!.marketCap!)),
          ],
        ),
      ),
    );
  }

  Widget _statRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildStockNotes(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _NoteField(symbol: symbol),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsRow(BuildContext context, WidgetRef ref) {
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('$symbol is already in your watchlist')));
                } else {
                  await watchlistRepo.add(symbol);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$symbol added to watchlist')));
                }
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Failed: $e')));
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Watchlist'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.push('/analyze?symbol=$symbol'),
            icon: const Icon(Icons.analytics),
            label: const Text('Analyze'),
          ),
        ),
      ],
    );
  }
}

class _NoteField extends ConsumerStatefulWidget {
  const _NoteField({required this.symbol});
  final String symbol;

  @override
  ConsumerState<_NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends ConsumerState<_NoteField> {
  final _ctrl = TextEditingController();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final repo = ref.read(watchlistRepositoryProvider);
      final item = await repo.getBySymbol(widget.symbol);
      if (mounted) {
        _ctrl.text = item?.note ?? '';
        setState(() => _loaded = true);
      }
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _ctrl,
      maxLines: 3,
      decoration: const InputDecoration(hintText: 'Add your notes about this stock...', border: OutlineInputBorder()),
      onChanged: (val) async {
        final repo = ref.read(watchlistRepositoryProvider);
        final item = await repo.getBySymbol(widget.symbol);
        if (item != null) {
          await repo.updateNote(item.id, val.isNotEmpty ? val : null);
        }
      },
    );
  }
}
