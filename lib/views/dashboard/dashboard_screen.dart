import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../config/theme.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/error_retry_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardViewModelProvider.notifier).loadDashboard();
    });
  }

  Color _gainLossColor(BuildContext context, double change) {
    final colors = Theme.of(context).extension<StockColors>() ??
        const StockColors(gainColor: Colors.green, lossColor: Colors.red);
    return change >= 0 ? colors.gainColor : colors.lossColor;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Stock Prediction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: state.isLoading
          ? const ShimmerLoading(count: 4)
          : state.errorMessage != null && state.topMovers.isEmpty
              ? ErrorRetryWidget(
                  message: state.errorMessage!,
                  onRetry: () => ref
                      .read(dashboardViewModelProvider.notifier)
                      .loadDashboard(),
                )
              : RefreshIndicator(
                  onRefresh: () => ref
                      .read(dashboardViewModelProvider.notifier)
                      .loadDashboard(),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _MarketStatusCard(),
                      const SizedBox(height: 16),
                      _WatchlistSummaryCard(count: state.watchlistCount),
                      const SizedBox(height: 16),
                      if (state.topMovers.isNotEmpty) ...[
                        _SectionHeader(title: 'Top Movers'),
                        const SizedBox(height: 8),
                        ...state.topMovers.map((item) => _MoverCard(
                              item: item,
                              gainLossColor: (change) =>
                                  _gainLossColor(context, change),
                            )),
                      ],
                      const SizedBox(height: 16),
                      _QuickActionsRow(),
                    ],
                  ),
                ),
    );
  }
}

class _MarketStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isWeekday =
        now.weekday >= DateTime.monday && now.weekday <= DateTime.friday;
    final utcHour = now.toUtc().hour + now.toUtc().minute / 60;
    final isMarketOpen = isWeekday && utcHour >= 13.5 && utcHour < 20;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isMarketOpen ? Icons.trending_up : Icons.bedtime,
              color: isMarketOpen ? Colors.green : Colors.grey,
              size: 32,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMarketOpen ? 'Market Open' : 'Market Closed',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.timeZoneName}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WatchlistSummaryCard extends StatelessWidget {
  const _WatchlistSummaryCard({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          final shell = StatefulNavigationShell.of(context);
          shell.goBranch(1);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.list_alt,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  count > 0
                      ? "You're tracking $count stock${count != 1 ? 's' : ''}"
                      : 'No stocks tracked yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _MoverCard extends StatelessWidget {
  const _MoverCard({
    required this.item,
    required this.gainLossColor,
  });

  final dynamic item;
  final Color Function(double change) gainLossColor;

  @override
  Widget build(BuildContext context) {
    final change = item.lastPriceChange ?? 0.0;
    final isPositive = change >= 0;
    final color = gainLossColor(change);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            item.symbol,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        title: Text(
          item.symbol,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: item.lastPrice != null
            ? Text('\$${item.lastPrice!.toStringAsFixed(2)}')
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: color,
              size: 20,
            ),
            Text(
              '${isPositive ? "+" : ""}${change.toStringAsFixed(2)} (${isPositive ? "+" : ""}${(item.lastPriceChange != null && item.lastPrice != null ? ((item.lastPriceChange! / item.lastPrice!) * 100).toStringAsFixed(2) : "0.00")}%)',
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.add),
            label: const Text('Add Stock'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.analytics),
            label: const Text('Run Analysis'),
          ),
        ),
      ],
    );
  }
}
