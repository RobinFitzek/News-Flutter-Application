import 'package:flutter/material.dart';
import 'holdings_tab.dart';
import 'paper_trading_tab.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Portfolio'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Holdings'),
              Tab(text: 'Paper Trade'),
              Tab(text: 'Backtest'),
              Tab(text: 'Journal'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HoldingsTab(),
            PaperTradingTab(),
            _PlaceholderTab(label: 'Backtest'),
            _PlaceholderTab(label: 'Journal'),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$label — coming soon'),
    );
  }
}
