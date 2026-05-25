import 'package:flutter/material.dart';
import '../watchlist/watchlist_screen.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stocks'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Watchlist', icon: Icon(Icons.list)),
              Tab(text: 'Discover', icon: Icon(Icons.explore)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            WatchlistBody(),
            DiscoverPlaceholder(),
          ],
        ),
      ),
    );
  }
}

class DiscoverPlaceholder extends StatelessWidget {
  const DiscoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Discovery — coming soon'),
    );
  }
}
