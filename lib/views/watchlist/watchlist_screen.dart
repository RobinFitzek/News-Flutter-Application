import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/watchlist_viewmodel.dart';
import '../../widgets/watchlist_tile.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/error_retry_widget.dart';
import '../../data/database/app_database.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

class WatchlistBody extends ConsumerStatefulWidget {
  const WatchlistBody({super.key});

  @override
  ConsumerState<WatchlistBody> createState() => _WatchlistBodyState();
}

class _WatchlistBodyState extends ConsumerState<WatchlistBody> {
  final _symbolController = TextEditingController();
  bool _isAdding = false;
  String? _activeGroupFilter;

  Set<String> _getGroups(List<WatchlistItemData> items) {
    return items.where((i) => i.groupName != null).map((i) => i.groupName!).toSet();
  }

  List<WatchlistItemData> _filtered(List<WatchlistItemData> items) {
    if (_activeGroupFilter == null) return items;
    return items.where((i) => i.groupName == _activeGroupFilter).toList();
  }

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

  Future<void> _importCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'txt'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;
    final text = utf8.decode(bytes);
    final lines = text.split('\n');
    var imported = 0;
    for (final line in lines) {
      final parts = line.split(',');
      if (parts.isEmpty) continue;
      final symbol = parts.first.trim().toUpperCase().replaceAll('"', '');
      if (symbol.isEmpty || symbol == 'SYMBOL' || symbol == 'TICKER') continue;
      if (symbol.length > 6) continue;
      try {
        await ref.read(watchlistViewModelProvider.notifier).addTicker(symbol);
        imported++;
      } catch (_) {}
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imported $imported tickers from CSV')),
      );
    }
  }

  void _showEditDialog(WatchlistItemData item) {
    final noteCtrl = TextEditingController(text: item.note);
    final groupCtrl = TextEditingController(text: item.groupName);
    String tier = item.tier;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (ctx, setDlg) => AlertDialog(
        title: Text('Edit ${item.symbol}'),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          DropdownButtonFormField<String>(
            value: tier,
            decoration: const InputDecoration(labelText: 'Tier', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'core', child: Text('Core')),
              DropdownMenuItem(value: 'swing', child: Text('Swing')),
              DropdownMenuItem(value: 'research', child: Text('Research')),
              DropdownMenuItem(value: 'earnings', child: Text('Earnings')),
            ],
            onChanged: (v) => setDlg(() => tier = v ?? 'core'),
          ),
          const SizedBox(height: 12),
          TextField(controller: groupCtrl, decoration: const InputDecoration(labelText: 'Group Name', hintText: 'e.g. Tech, Dividends', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: noteCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder())),
        ])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(onPressed: () {
            ref.read(watchlistViewModelProvider.notifier).changeTier(item.id, tier);
            ref.read(watchlistViewModelProvider.notifier).updateGroup(item.id, groupCtrl.text.isNotEmpty ? groupCtrl.text : null);
            ref.read(watchlistViewModelProvider.notifier).updateNote(item.id, noteCtrl.text.isNotEmpty ? noteCtrl.text : null);
            Navigator.pop(ctx);
          }, child: const Text('Save')),
        ],
      )),
    );
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
                            if (_getGroups(state.items).isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    FilterChip(label: const Text('All'), selected: _activeGroupFilter == null, onSelected: (_) => setState(() => _activeGroupFilter = null)),
                                    ..._getGroups(state.items).map((g) => Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: FilterChip(label: Text(g), selected: _activeGroupFilter == g, onSelected: (_) => setState(() => _activeGroupFilter = _activeGroupFilter == g ? null : g)),
                                    )),
                                  ]),
                                ),
                              ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _filtered(state.items).length,
                                itemBuilder: (context, index) {
                                  final item = _filtered(state.items)[index];
                                  final quote = state.quotes[item.symbol];
                                  return WatchlistTile(
                                    key: ValueKey(item.id),
                                    item: item,
                                    quote: quote,
                                    onTap: () {
                                      context.push('/stock/${item.symbol}');
                                    },
                                    onLongPress: () => _showEditDialog(item),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.small(
                  heroTag: 'import',
                  onPressed: _importCsv,
                  child: const Icon(Icons.upload_file),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: _showAddDialog,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
