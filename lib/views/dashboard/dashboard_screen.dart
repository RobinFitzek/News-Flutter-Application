import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../config/theme.dart';
import '../../widgets/shimmer_loading.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Map<String, double>? _marketData;
  bool _marketLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardViewModelProvider.notifier).loadDashboard();
      _loadMarketData();
    });
  }

  Future<void> _loadMarketData() async {
    try {
      final client = YahooFinanceClient();
      final spy = await client.getStockQuote('SPY');
      final qqq = await client.getStockQuote('QQQ');
      final vix = await client.getStockQuote('^VIX');
      if (mounted) setState(() {
        _marketData = {
          'SPY': (spy['changePercent'] as num).toDouble(),
          'QQQ': (qqq['changePercent'] as num).toDouble(),
          'VIX': (vix['currentPrice'] as num).toDouble(),
        };
        _marketLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _marketLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.trending_up, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          const Text('AI Stock Prediction'),
        ]),
        actions: [
          IconButton(icon: const Icon(Icons.description_outlined), tooltip: 'Report', onPressed: () => context.push('/report')),
          IconButton(icon: const Icon(Icons.settings), tooltip: 'Settings', onPressed: () => context.push('/settings')),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(dashboardViewModelProvider.notifier).loadDashboard();
          await _loadMarketData();
        },
        child: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 24), children: [
          // Market bar
          if (_marketLoading) const SizedBox(height: 60, child: ShimmerLoading(count: 1))
          else if (_marketData != null) _MarketBar(data: _marketData!),
          const SizedBox(height: 12),

          // Quick Actions Grid
          _SectionTitle(title: 'Quick Access'),
          const SizedBox(height: 6),
          _QuickGrid(context),

          const SizedBox(height: 16),

          // Portfolio Snapshot
          if (state.watchlistCount > 0)
            _SnapshotCard(count: state.watchlistCount, context: context),
          if (state.watchlistCount > 0) const SizedBox(height: 16),

          // Top Movers
          if (state.topMovers.isNotEmpty) ...[
            _SectionTitle(title: 'Top Movers'),
            const SizedBox(height: 6),
            ...state.topMovers.map((m) => _MoverTile(item: m)),
            const SizedBox(height: 16),
          ],

          // Recent Analyses
          _SectionTitle(title: 'Recent Analyses'),
          const SizedBox(height: 6),
          if (state.recentAnalyses.isEmpty)
            _EmptyPrompt(icon: Icons.psychology, text: 'No analyses yet', action: 'Analyze', onTap: () => context.goNamed('analyze'))
          else ...[
            ...state.recentAnalyses.take(3).map((a) => _AnalysisTile(analysis: a)),
            const SizedBox(height: 4),
            Center(child: TextButton(onPressed: () => context.goNamed('analyze'), child: const Text('View all analyses →'))),
          ],

          if (state.errorMessage != null)
            Padding(padding: const EdgeInsets.only(top: 16), child: Card(color: Colors.red.shade50, child: Padding(padding: const EdgeInsets.all(12), child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)))))
        ]),
      ),
    );
  }
}

class _MarketBar extends StatelessWidget {
  final Map<String, double> data;
  const _MarketBar({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _MarketChip('S&P 500', data['SPY']!),
        Container(width: 1, height: 24, color: Colors.grey.shade200),
        _MarketChip('NASDAQ', data['QQQ']!),
        Container(width: 1, height: 24, color: Colors.grey.shade200),
        _MarketChip('VIX', data['VIX']!, isVix: true),
      ])),
    );
  }
}

class _MarketChip extends StatelessWidget {
  final String label;
  final double value;
  final bool isVix;
  const _MarketChip(this.label, this.value, {this.isVix = false});

  @override
  Widget build(BuildContext context) {
    final color = isVix ? (value > 25 ? Colors.red : value > 20 ? Colors.orange : Colors.green) : (value >= 0 ? Colors.green : Colors.red);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
      const SizedBox(height: 2),
      Text(isVix ? value.toStringAsFixed(1) : '${value >= 0 ? '+' : ''}${value.toStringAsFixed(2)}%', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
    ]);
  }
}

class _QuickGrid extends StatelessWidget {
  final BuildContext context;
  const _QuickGrid(this.context);

  @override
  Widget build(BuildContext context) {
    final items = [
      _GridItem(Icons.list_alt, 'Watchlist', () => context.goNamed('stocks')),
      _GridItem(Icons.psychology, 'Analyze', () => context.goNamed('analyze')),
      _GridItem(Icons.account_balance_wallet, 'Portfolio', () => context.goNamed('portfolio')),
      _GridItem(Icons.explore, 'Discover', () => context.push('/stocks')),
      _GridItem(Icons.public, 'Macro', () => context.push('/research/macro')),
      _GridItem(Icons.pie_chart, 'Sectors', () => context.push('/research/sector')),
      _GridItem(Icons.mood, 'Fear&Greed', () => context.push('/research/feargreed')),
      _GridItem(Icons.compare_arrows, 'Compare', () => context.push('/compare')),
    ];
    return Card(
      child: Padding(padding: const EdgeInsets.all(8), child: Wrap(spacing: 4, runSpacing: 4, children: items.map((i) => SizedBox(width: (MediaQuery.of(context).size.width - 64) / 4, child: InkWell(
        onTap: i.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(i.icon, color: Theme.of(context).colorScheme.primary, size: 22),
          const SizedBox(height: 4),
          Text(i.label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
        ])),
      ))).toList())),
    );
  }
}

class _GridItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _GridItem(this.icon, this.label, this.onTap);
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
  );
}

class _SnapshotCard extends StatelessWidget {
  final int count;
  final BuildContext context;
  const _SnapshotCard({required this.count, required this.context});

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(onTap: () => context.goNamed('portfolio'), borderRadius: BorderRadius.circular(12), child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
      Icon(Icons.account_balance_wallet, color: Theme.of(context).colorScheme.primary, size: 28),
      const SizedBox(width: 12),
      Expanded(child: Text('You are tracking $count stock${count != 1 ? 's' : ''}', style: Theme.of(context).textTheme.bodyLarge)),
      const Icon(Icons.chevron_right),
    ]))),
  );
}

class _MoverTile extends StatelessWidget {
  final WatchlistItemData item;
  const _MoverTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final change = item.lastPriceChange ?? 0;
    final isPositive = change >= 0;
    final color = isPositive ? Colors.green : Colors.red;
    final price = item.lastPrice;

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primaryContainer, child: Text(item.symbol.length > 4 ? item.symbol.substring(0, 4) : item.symbol, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        title: Text(item.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: price != null ? Text('\$${price.toStringAsFixed(2)}') : null,
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: color, size: 18),
          Text('${isPositive ? '+' : ''}${change.toStringAsFixed(2)}', style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        ]),
        onTap: () => context.push('/stock/${item.symbol}'),
      ),
    );
  }
}

class _AnalysisTile extends StatelessWidget {
  final AnalysisResultData analysis;
  const _AnalysisTile({required this.analysis});

  @override
  Widget build(BuildContext context) {
    final recColor = analysis.recommendation == 'BUY' ? Colors.green : analysis.recommendation == 'SELL' ? Colors.red : Colors.amber;
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: recColor.withAlpha(30), child: Text(analysis.symbol, style: TextStyle(color: recColor, fontWeight: FontWeight.bold, fontSize: 12))),
        title: Row(children: [
          Text(analysis.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: recColor.withAlpha(30), borderRadius: BorderRadius.circular(4)), child: Text(analysis.recommendation, style: TextStyle(color: recColor, fontSize: 10, fontWeight: FontWeight.bold))),
        ]),
        subtitle: Text('\$${analysis.predictedPrice.toStringAsFixed(2)} • ${(analysis.confidence * 100).toStringAsFixed(0)}% conf.'),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () => context.push('/analysis/${analysis.id}'),
      ),
    );
  }
}

class _EmptyPrompt extends StatelessWidget {
  final IconData icon;
  final String text;
  final String action;
  final VoidCallback onTap;
  const _EmptyPrompt({required this.icon, required this.text, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
      Icon(icon, size: 32, color: Colors.grey),
      const SizedBox(height: 8),
      Text(text, style: const TextStyle(color: Colors.grey)),
      const SizedBox(height: 8),
      TextButton(onPressed: onTap, child: Text(action)),
    ])),
  );
}
