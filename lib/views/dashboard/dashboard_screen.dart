import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../viewmodels/dashboard_viewmodel.dart';
import '../../data/database/app_database.dart';
import '../../config/stockholm_colors.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/dashboard/system_command_center.dart';
import '../../widgets/dashboard/market_regime_card.dart';
import '../../widgets/dashboard/fear_greed_dash_card.dart';
import '../../widgets/dashboard/intel_strip.dart';
import '../../widgets/dashboard/geo_radar_card.dart';
import '../../widgets/dashboard/auto_trade_card.dart';
import '../../widgets/dashboard/benchmark_card.dart';
import '../../widgets/dashboard/economic_calendar_card.dart';
import '../../widgets/dashboard/sentiment_movers_card.dart';
import '../../widgets/dashboard/graham_dash_card.dart';
import '../../widgets/dashboard/portfolio_anomaly_card.dart';
import '../../widgets/dashboard/lstm_signals_card.dart';
import '../../widgets/dashboard/auto_trade_confirm_sheet.dart';
import '../../widgets/glass_card.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/paper_trading_repository.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../engine/auto_paper_trader.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _confirmShown = false;
  List<PositionData> _holdings = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(_initialLoad);
  }

  Future<void> _initialLoad() async {
    _holdings = await ref.read(portfolioRepositoryProvider).getAllPositions();
    await ref.read(dashboardViewModelProvider.notifier).loadDashboard();
    await _maybeShowAutoConfirm();
  }

  Future<void> _refresh() async {
    _holdings = await ref.read(portfolioRepositoryProvider).getAllPositions();
    await ref.read(dashboardViewModelProvider.notifier).loadDashboard();
    await _maybeShowAutoConfirm();
  }

  Future<void> _maybeShowAutoConfirm() async {
    if (_confirmShown || !mounted) return;
    final pending = ref.read(dashboardViewModelProvider).pendingAutoTrades;
    if (pending.isEmpty) return;
    _confirmShown = true;
    final trader = AutoPaperTrader(
      ref.read(databaseProvider),
      paperRepo: ref.read(paperTradingRepositoryProvider),
    );
    await maybeShowAutoTradeConfirm(context, trader: trader, onRefresh: () async {
      _confirmShown = false;
      await _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardViewModelProvider);
    final regime = state.marketRegime;
    final spyChange = regime?['spy_change_pct'] as num?;

    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.hub, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          const Text('Stockholm Command Center'),
        ]),
        actions: [
          IconButton(icon: const Icon(Icons.description_outlined), tooltip: 'Report', onPressed: () => context.push('/report')),
          IconButton(icon: const Icon(Icons.settings), tooltip: 'Settings', onPressed: () => context.push('/settings')),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: state.isLoading && state.watchlistCount == 0
            ? ListView(children: const [SizedBox(height: 200, child: ShimmerLoading(count: 3))])
            : ListView(padding: const EdgeInsets.fromLTRB(0, 8, 0, 24), children: [
                SystemCommandCenter(onRefresh: _refresh),
                if (regime != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _MarketBar(regime: regime, spyChange: spyChange),
                  ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: MarketRegimeCard(regime: regime)),
                      const SizedBox(width: 8),
                      Expanded(child: FearGreedDashCard(data: state.fearGreed)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: IntelStrip(stats: state.intelStats),
                ),
                const SizedBox(height: 8),
                GeoRadarCard(scan: state.geoScan, exposures: state.geoExposures),
                AutoTradeCard(
                  status: state.autoTradeStatus,
                  pendingCount: state.pendingAutoTrades.length,
                  onToggle: _refresh,
                  onReviewPending: () async {
                    _confirmShown = false;
                    await _maybeShowAutoConfirm();
                  },
                ),
                BenchmarkCard(data: state.benchmark),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GrahamDashCard(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PortfolioAnomalyCard(holdings: _holdings),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LstmSignalsCard(),
                ),
                const SizedBox(height: 8),
                EconomicCalendarCard(events: state.calendarEvents),
                SentimentMoversCard(movers: state.sentimentMovers),
                if (state.paperSummary.isNotEmpty) _PaperSnapshot(summary: state.paperSummary),
                _SectionTitle(title: 'Quick Access'),
                _QuickGrid(context),
                if (state.topMovers.isNotEmpty) ...[
                  _SectionTitle(title: 'Top Movers'),
                  ...state.topMovers.map((m) => _MoverTile(item: m)),
                ],
                _SectionTitle(title: 'Recent Analyses'),
                if (state.recentAnalyses.isEmpty)
                  _EmptyPrompt(icon: Icons.psychology, text: 'No analyses yet', action: 'Analyze', onTap: () => context.goNamed('analyze'))
                else ...[
                  ...state.recentAnalyses.take(3).map((a) => _AnalysisTile(analysis: a)),
                  Center(child: TextButton(onPressed: () => context.goNamed('analyze'), child: const Text('View all analyses →'))),
                ],
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: GlassCard(
                      child: Text(state.errorMessage!, style: const TextStyle(color: StockholmColors.signalNegative)),
                    ),
                  ),
              ]),
      ),
    );
  }
}

class _MarketBar extends StatelessWidget {
  const _MarketBar({required this.regime, this.spyChange});
  final Map<String, dynamic> regime;
  final num? spyChange;

  @override
  Widget build(BuildContext context) {
    final spy = regime['spy_price'] as num?;
    final vix = regime['vix'] as num?;
    final change = spyChange ?? 0;

    return GlassCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _chip('SPY', spy != null ? '\$${spy.toStringAsFixed(2)}' : '—', change >= 0),
          _chip('VIX', vix?.toStringAsFixed(1) ?? '—', null),
          _chip('Regime', regime['regime']?.toString().toUpperCase() ?? '—', null),
        ],
      ),
    );
  }

  Widget _chip(String label, String value, bool? positive) {
    Color? color;
    if (positive != null) {
      color = positive ? StockholmColors.signalPositive : StockholmColors.signalNegative;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: StockholmColors.textSecondary)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
      ],
    );
  }
}

class _PaperSnapshot extends StatelessWidget {
  const _PaperSnapshot({required this.summary});
  final Map<String, dynamic> summary;

  @override
  Widget build(BuildContext context) {
    final pnl = summary['realized_pnl'] as num? ?? 0;
    return GlassCard(
      onTap: () => context.goNamed('portfolio'),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet, color: StockholmColors.signalNeutral),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Paper Portfolio', style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  'Cash \$${(summary['cash'] as num?)?.toStringAsFixed(0) ?? '0'} · '
                  '${summary['open_trades']} open · P&L ${pnl >= 0 ? '+' : ''}\$${pnl.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12, color: StockholmColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: StockholmColors.textMuted),
        ],
      ),
    );
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
      _GridItem(Icons.public, 'Geo Radar', () => context.push('/research/geo')),
      _GridItem(Icons.show_chart, 'Options', () => context.push('/research/options')),
      _GridItem(Icons.pie_chart, 'Sectors', () => context.push('/research/sector')),
      _GridItem(Icons.mood, 'Fear&Greed', () => context.push('/research/feargreed')),
      _GridItem(Icons.warning_amber, 'Scenarios', () => context.push('/scenarios')),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: items.map((i) => SizedBox(
          width: (MediaQuery.of(context).size.width - 48) / 4,
          child: InkWell(
            onTap: i.onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(i.icon, color: StockholmColors.signalNeutral, size: 22),
                const SizedBox(height: 4),
                Text(i.label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
              ]),
            ),
          ),
        )).toList(),
      ),
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
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
    child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: StockholmColors.signalNeutral, fontWeight: FontWeight.bold)),
  );
}

class _MoverTile extends StatelessWidget {
  final WatchlistItemData item;
  const _MoverTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final change = item.lastPriceChange ?? 0;
    final isPositive = change >= 0;
    final color = isPositive ? StockholmColors.signalPositive : StockholmColors.signalNegative;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onTap: () => context.push('/stock/${item.symbol}'),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: StockholmColors.glassTint,
            child: Text(item.symbol.length > 4 ? item.symbol.substring(0, 4) : item.symbol,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(item.symbol, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text('${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
              style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _AnalysisTile extends StatelessWidget {
  final AnalysisResultData analysis;
  const _AnalysisTile({required this.analysis});

  @override
  Widget build(BuildContext context) {
    final signal = analysis.signal;
    Color recColor;
    if (signal == 'Opportunity') {
      recColor = StockholmColors.signalPositive;
    } else if (signal == 'Caution') {
      recColor = StockholmColors.signalNegative;
    } else {
      recColor = StockholmColors.signalWarning;
    }

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onTap: () => context.push('/analysis/${analysis.id}'),
      child: Row(
        children: [
          Text(analysis.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(color: recColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
            child: Text(signal, style: TextStyle(color: recColor, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Text('${(analysis.confidence * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 12, color: StockholmColors.textSecondary)),
          const Icon(Icons.chevron_right, size: 18, color: StockholmColors.textMuted),
        ],
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
  Widget build(BuildContext context) => GlassCard(
    child: Column(children: [
      Icon(icon, size: 32, color: StockholmColors.textMuted),
      const SizedBox(height: 8),
      Text(text, style: const TextStyle(color: StockholmColors.textSecondary)),
      TextButton(onPressed: onTap, child: Text(action)),
    ]),
  );
}
