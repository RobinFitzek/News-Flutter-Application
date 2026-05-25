import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/stock_detail_viewmodel.dart';
import '../../widgets/shimmer_loading.dart';
import '../../config/theme.dart';
import 'tabs/overview_tab.dart';
import 'tabs/financials_tab.dart';
import 'tabs/earnings_tab.dart';
import 'tabs/insider_tab.dart';
import 'tabs/institutions_tab.dart';
import '../research/corporate_actions_screen.dart';

class StockDetailScreen extends ConsumerStatefulWidget {
  const StockDetailScreen({super.key, required this.symbol});

  final String symbol;

  @override
  ConsumerState<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends ConsumerState<StockDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    Future.microtask(() {
      ref
          .read(stockDetailViewModelProvider(widget.symbol).notifier)
          .loadStock();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(stockDetailViewModelProvider(widget.symbol).notifier)
                .loadStock(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Financials'),
            Tab(text: 'Earnings'),
            Tab(text: 'Insider'),
            Tab(text: 'Institutions'),
            Tab(text: 'Actions'),
          ],
        ),
      ),
      body: state.isLoadingQuote
          ? const ShimmerLoading(count: 3)
          : TabBarView(
              controller: _tabController,
              children: [
                OverviewTab(
                  quote: state.quote,
                  chartData: state.chartData,
                  isLoadingChart: state.isLoadingChart,
                  gainLossColor: (c) => _gainLossColor(context, c),
                  symbol: widget.symbol,
                  onRefresh: () => ref
                      .read(stockDetailViewModelProvider(widget.symbol).notifier)
                      .loadStock(),
                  onChartRangeChanged: (range) => ref
                      .read(stockDetailViewModelProvider(widget.symbol).notifier)
                      .loadChart(range: range),
                ),
                FinancialsTab(
                  ratios: state.financialRatios,
                  isLoading: state.isLoadingDetails,
                ),
                EarningsTab(
                  earnings: state.earnings,
                  isLoading: state.isLoadingDetails,
                ),
                InsiderTab(
                  transactions: state.insiderTransactions,
                  isLoading: state.isLoadingDetails,
                ),
                InstitutionsTab(
                  holders: state.institutionalHolders,
                  isLoading: state.isLoadingDetails,
                ),
                CorporateActionsScreen(
                  actions: state.corporateActions,
                ),
              ],
            ),
    );
  }
}
