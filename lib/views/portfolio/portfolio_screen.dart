import 'package:flutter/material.dart';
import 'holdings_tab.dart';
import 'paper_trading_tab.dart';
import 'backtest_tab.dart';
import 'journal_tab.dart';

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
            BacktestTab(),
            JournalTab(),
          ],
        ),
      ),
    );
  }
}
