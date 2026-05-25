import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/backtest_viewmodel.dart';
import '../../data/database/app_database.dart';
import '../../config/theme.dart';

class BacktestTab extends ConsumerStatefulWidget {
  const BacktestTab({super.key});

  @override
  ConsumerState<BacktestTab> createState() => _BacktestTabState();
}

class _BacktestTabState extends ConsumerState<BacktestTab> {
  final _symbolsController = TextEditingController(text: 'AAPL,MSFT,GOOGL');
  String _strategy = 'buy_and_hold';
  final _capitalController = TextEditingController(text: '100000');
  int _days = 90;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(backtestViewModelProvider.notifier).loadResults());
  }

  @override
  void dispose() {
    _symbolsController.dispose();
    _capitalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(backtestViewModelProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Run Backtest', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextField(controller: _symbolsController, decoration: const InputDecoration(labelText: 'Symbols (comma-separated)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _strategy,
                  decoration: const InputDecoration(labelText: 'Strategy', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'buy_and_hold', child: Text('Buy & Hold')),
                    DropdownMenuItem(value: 'momentum', child: Text('Momentum')),
                    DropdownMenuItem(value: 'mean_reversion', child: Text('Mean Reversion')),
                  ],
                  onChanged: (v) => setState(() => _strategy = v ?? 'buy_and_hold'),
                ),
                const SizedBox(height: 12),
                TextField(controller: _capitalController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Initial Capital (\$)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Period: '),
                    Expanded(
                      child: Slider(value: _days.toDouble(), min: 30, max: 365, divisions: 11, label: '$_days days', onChanged: (v) => setState(() => _days = v.round())),
                    ),
                    Text('$_days days'),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: state.isRunning ? null : () {
                      final symbols = _symbolsController.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
                      final capital = double.tryParse(_capitalController.text) ?? 100000;
                      if (symbols.isNotEmpty) {
                        ref.read(backtestViewModelProvider.notifier).runBacktest(symbols: symbols, strategy: _strategy, capital: capital, days: _days);
                      }
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: Text(state.isRunning ? 'Running...' : 'Run Backtest'),
                  ),
                ),
                if (state.isRunning) const LinearProgressIndicator(),
              ],
            ),
          ),
        ),
        if (state.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(padding: const EdgeInsets.all(12), child: Text(state.errorMessage!)),
            ),
          ),
        const SizedBox(height: 16),
        if (state.results.isNotEmpty) ...[
          Text('Backtest History', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          ...state.results.map((r) => _ResultCard(result: r, onDelete: () => ref.read(backtestViewModelProvider.notifier).deleteResult(r.id))),
        ],
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.onDelete});
  final BacktestResultData result;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isPositive = result.totalReturn >= 0;
    final color = isPositive ? Colors.green : Colors.red;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(result.strategy.replaceAll('_', ' ').toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat('MMM d').format(result.createdAt!), style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Return'), Text('${isPositive ? '+' : ''}${result.totalReturnPercent.toStringAsFixed(2)}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ]),
            _r(context, 'Win Rate', '${result.winRate.toStringAsFixed(1)}%'),
            _r(context, 'Profit Factor', result.profitFactor.toStringAsFixed(2)),
            _r(context, 'Max Drawdown', '-${result.maxDrawdownPercent.toStringAsFixed(1)}%'),
            _r(context, 'Trades', '${result.totalTrades} (${result.winningTrades}W/${result.losingTrades}L)'),
            const SizedBox(height: 8),
            Text(result.symbols, style: const TextStyle(fontSize: 12)),
            Align(alignment: Alignment.centerRight, child: IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: onDelete)),
          ],
        ),
      ),
    );
  }

  Widget _r(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 13)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    ]),
  );
}
