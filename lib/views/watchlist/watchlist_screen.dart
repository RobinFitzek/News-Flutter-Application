import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/watchlist_viewmodel.dart';
import '../../widgets/watchlist_tile.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/error_retry_widget.dart';
import 'package:go_router/go_router.dart';

class WatchlistBody extends ConsumerStatefulWidget {
  const WatchlistBody({super.key});

  @override
  ConsumerState<WatchlistBody> createState() => _WatchlistBodyState();
}

class _WatchlistBodyState extends ConsumerState<WatchlistBody> {
  final _symbolController = TextEditingController();
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(watchlistViewModelProvider.notifier).loadWatchlist();
    });
  }

  @override
  void dispose() {
    _symbolController.dispose();
    super.dispose();
  }

  Future<void> _showAddDialog() async {
    _symbolController.clear();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            title: const Text('Add Stock'),
            content: TextField(
              controller: _symbolController,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Ticker Symbol',
                hintText: 'e.g. AAPL',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  Navigator.pop(ctx, value.trim().toUpperCase());
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _isAdding
                    ? null
                    : () {
                        final symbol = _symbolController.text.trim();
                        if (symbol.isNotEmpty) {
                          Navigator.pop(ctx, symbol.toUpperCase());
                        }
                      },
                child: _isAdding
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Add'),
              ),
            ],
          );
        },
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() => _isAdding = true);
      await ref.read(watchlistViewModelProvider.notifier).addTicker(result);
      setState(() => _isAdding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(watchlistViewModelProvider);

    return Stack(
      children: [
        state.isLoading && state.items.isEmpty
            ? const ShimmerLoading(count: 5)
            : state.errorMessage != null && state.items.isEmpty
                ? ErrorRetryWidget(
                    message: state.errorMessage!,
                    onRetry: () => ref
                        .read(watchlistViewModelProvider.notifier)
                        .loadWatchlist(),
                  )
                : state.items.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.show_chart,
                                size: 64,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No stocks in your watchlist',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add your first stock to start tracking',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: _showAddDialog,
                                icon: const Icon(Icons.add),
                                label: const Text('Add Your First Stock'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => ref
                            .read(watchlistViewModelProvider.notifier)
                            .refreshAllQuotes(),
                        child: Column(
                          children: [
                            if (state.isLoading)
                              LinearProgressIndicator(
                                minHeight: 2,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.items.length,
                                itemBuilder: (context, index) {
                                  final item = state.items[index];
                                  final quote = state.quotes[item.symbol];
                                  return WatchlistTile(
                                    key: ValueKey(item.id),
                                    item: item,
                                    quote: quote,
                                    onTap: () {
                                      context.push('/stock/${item.symbol}');
                                    },
                                    onDelete: () {
                                      ref
                                          .read(watchlistViewModelProvider
                                              .notifier)
                                          .removeTicker(item.id);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
        if (state.items.isNotEmpty)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _showAddDialog,
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }
}
