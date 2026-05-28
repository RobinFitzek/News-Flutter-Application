import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../viewmodels/paper_trading_viewmodel.dart';
import '../../config/theme.dart';

class PaperTradingTab extends ConsumerStatefulWidget {
  const PaperTradingTab({super.key});

  @override
  ConsumerState<PaperTradingTab> createState() => _PaperTradingTabState();
}

class _PaperTradingTabState extends ConsumerState<PaperTradingTab> {
  bool _settingsExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(paperTradingViewModelProvider.notifier).loadTrades();
    });
  }

  Color _gainLossColor(BuildContext context, double val) {
    final colors = Theme.of(context).extension<StockColors>() ??
        const StockColors(gainColor: Colors.green, lossColor: Colors.red);
    return val >= 0 ? colors.gainColor : colors.lossColor;
  }

  Future<void> _showNewTradeDialog() async {
    final symbolController = TextEditingController();
    final sharesController = TextEditingController();
    final priceController = TextEditingController();
    String type = 'BUY';

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('New Paper Trade'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'BUY', label: Text('BUY')),
                    ButtonSegment(value: 'SELL', label: Text('SELL')),
                  ],
                  selected: {type},
                  onSelectionChanged: (v) => setDialogState(() => type = v.first),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: symbolController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(labelText: 'Symbol', hintText: 'e.g. AAPL', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(controller: sharesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Shares', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder())),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Execute')),
          ],
        ),
      ),
    );

    if (result == true && symbolController.text.isNotEmpty) {
      final shares = double.tryParse(sharesController.text) ?? 0;
      final price = double.tryParse(priceController.text) ?? 0;
      if (shares > 0 && price > 0) {
        try {
          await ref.read(paperTradingViewModelProvider.notifier).openTrade(
                symbol: symbolController.text.toUpperCase(),
                type: type,
                shares: shares,
                price: price,
              );
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      }
    }
  }

  Future<void> _showCloseDialog(PaperTradeData trade) async {
    final priceController = TextEditingController(text: trade.price.toString());
    String reason = 'manual';

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Close ${trade.symbol} ${trade.type}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Exit Price', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: reason,
                decoration: const InputDecoration(labelText: 'Reason', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'manual', child: Text('Manual')),
                  DropdownMenuItem(value: 'take_profit', child: Text('Take Profit')),
                  DropdownMenuItem(value: 'stop_loss', child: Text('Stop Loss')),
                ],
                onChanged: (v) => setDialogState(() => reason = v ?? 'manual'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Close Trade')),
          ],
        ),
      ),
    );

    if (result == true) {
      final price = double.tryParse(priceController.text) ?? trade.price;
      await ref.read(paperTradingViewModelProvider.notifier).closeTrade(
            trade.id,
            exitPrice: price,
            reason: reason,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paperTradingViewModelProvider);

    if (state.isLoading && state.trades.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => ref.read(paperTradingViewModelProvider.notifier).loadTrades(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Paper Account', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Cash'), Text('\$${state.cashBalance.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600))]),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Open Trades'), Text('${state.openTrades.length}')]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Settings'),
                      trailing: Icon(_settingsExpanded ? Icons.expand_less : Icons.expand_more),
                      onTap: () => setState(() => _settingsExpanded = !_settingsExpanded),
                    ),
                    if (_settingsExpanded) _SettingsForm(key: ValueKey(state.trades.length)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.openTrades.isNotEmpty) ...[
                Text('Open Trades', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...state.openTrades.map((t) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(t.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: t.type == 'BUY' ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(t.type, style: TextStyle(fontSize: 11, color: t.type == 'BUY' ? Colors.green : Colors.red, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        subtitle: Text('${t.shares} shares @ \$${t.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12)),
                        trailing: TextButton(onPressed: () => _showCloseDialog(t), child: const Text('Close')),
                      ),
                    )),
                const SizedBox(height: 16),
              ],
              if (state.trades.any((t) => t.status == 'CLOSED')) ...[
                Text('Trade History', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...state.trades.where((t) => t.status == 'CLOSED').take(20).map((t) => _ClosedTradeTile(trade: t, gainLossColor: (v) => _gainLossColor(context, v))),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _showNewTradeDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('New Trade'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Reset Portfolio'),
                            content: const Text('Delete all paper trades and reset to default?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reset')),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          ref.read(paperTradingViewModelProvider.notifier).resetPortfolio();
                        }
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(onPressed: _showNewTradeDialog, child: const Icon(Icons.add)),
        ),
      ],
    );
  }
}

class _SettingsForm extends ConsumerStatefulWidget {
  const _SettingsForm({super.key});

  @override
  ConsumerState<_SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<_SettingsForm> {
  final _capitalController = TextEditingController();
  final _tpController = TextEditingController();
  final _slController = TextEditingController();
  final _maxTradesController = TextEditingController();
  final _sizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final settings = await ref.read(paperTradingViewModelProvider.notifier).getSettings();
    if (settings != null) {
      setState(() {
        _capitalController.text = settings.startingCapital.toString();
        _tpController.text = settings.takeProfitPercent.toString();
        _slController.text = settings.stopLossPercent.toString();
        _maxTradesController.text = settings.maxOpenTrades.toString();
        _sizeController.text = settings.positionSizePercent.toString();
      });
    }
  }

  @override
  void dispose() {
    _capitalController.dispose();
    _tpController.dispose();
    _slController.dispose();
    _maxTradesController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          TextField(controller: _capitalController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Starting Capital', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _tpController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Take Profit %', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _slController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stop Loss %', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _maxTradesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Max Open Trades', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _sizeController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Position Size %', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
              ref.read(paperTradingViewModelProvider.notifier).updateSettings(
                    PaperSettingsData(
                      id: 0,
                      startingCapital: double.tryParse(_capitalController.text) ?? 100000,
                      takeProfitPercent: double.tryParse(_tpController.text) ?? 15,
                      stopLossPercent: double.tryParse(_slController.text) ?? 10,
                      maxOpenTrades: int.tryParse(_maxTradesController.text) ?? 5,
                      positionSizePercent: double.tryParse(_sizeController.text) ?? 20,
                    ),
                  );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings saved')));
              },
              child: const Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClosedTradeTile extends StatelessWidget {
  const _ClosedTradeTile({required this.trade, required this.gainLossColor});

  final PaperTradeData trade;
  final Color Function(double) gainLossColor;

  @override
  Widget build(BuildContext context) {
    final pnl = trade.realizedPnl ?? 0;
    final color = gainLossColor(pnl);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Row(
          children: [
            Text(trade.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text(trade.type, style: TextStyle(fontSize: 11, color: trade.type == 'BUY' ? Colors.green : Colors.red)),
          ],
        ),
        subtitle: Text('\$${trade.price.toStringAsFixed(2)} → \$${(trade.exitPrice ?? trade.price).toStringAsFixed(2)} • ${trade.exitReason ?? "closed"}', style: const TextStyle(fontSize: 12)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${pnl >= 0 ? "+" : ""}\$${pnl.toStringAsFixed(2)}', style: TextStyle(color: color, fontWeight: FontWeight.w600)),
            Text('${pnl >= 0 ? "+" : ""}${((pnl / (trade.shares * trade.price)) * 100).toStringAsFixed(2)}%', style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
