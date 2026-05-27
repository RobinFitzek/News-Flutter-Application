import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/backtest_viewmodel.dart';
import '../../data/database/app_database.dart';
import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';

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
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Run Backtest', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(controller: _symbolsController, decoration: const InputDecoration(labelText: 'Symbols (comma-separated)')),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _strategy,
                decoration: const InputDecoration(labelText: 'Strategy'),
                items: const [
                  DropdownMenuItem(value: 'buy_and_hold', child: Text('Buy & Hold')),
                  DropdownMenuItem(value: 'momentum', child: Text('Momentum')),
                  DropdownMenuItem(value: 'mean_reversion', child: Text('Mean Reversion')),
                  DropdownMenuItem(value: 'quant_walkforward', child: Text('Quant Walk-Forward')),
                ],
                onChanged: (v) => setState(() => _strategy = v ?? 'buy_and_hold'),
              ),
                TextField(controller: _capitalController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Initial Capital (\$)')),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(_strategy == 'quant_walkforward' ? 'Lookback: ' : 'Period: '),
                    Expanded(
                      child: Slider(value: _days.toDouble(), min: 30, max: 365, divisions: 11, label: '$_days days', onChanged: (v) => setState(() => _days = v.round())),
                    ),
                    Text('$_days days'),
                  ],
                ),
                if (_strategy == 'quant_walkforward')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Walk-forward replay: technical + momentum blend, 30d forward validation.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: StockholmColors.textSecondary),
                    ),
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
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state.isRunning ? null : () async {
                        final symbols = _symbolsController.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
                        final capital = double.tryParse(_capitalController.text) ?? 100000;
                        if (symbols.isEmpty) return;
                        final baseline = await ref.read(backtestViewModelProvider.notifier).runRandomBaseline(symbols: symbols, capital: capital, days: _days);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Random baseline mean: ${baseline['mean_return_pct']}%')));
                        }
                      },
                      child: const Text('Random Baseline'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final r = await ref.read(backtestViewModelProvider.notifier).applyWeightsFromLatest(dryRun: false);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r['applied'] == true ? 'Weights applied' : 'No weight change')));
                        }
                      },
                      child: const Text('Apply Weights'),
                    ),
                  ),
                ]),
              ],
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
        const SizedBox(height: 16),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MCPT Validation', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (state.mcptResult != null) ...[
                _mcptRow(context, 'Status', '${state.mcptResult!['status']}'),
                if (state.mcptResult!['p_value'] != null)
                  _mcptRow(context, 'P-Value', '${state.mcptResult!['p_value']}'),
                if (state.mcptResult!['actual_pf'] != null)
                  _mcptRow(context, 'Profit Factor', '${state.mcptResult!['actual_pf']}'),
                if (state.mcptResult!['significant'] != null)
                  _mcptRow(context, 'Significant', state.mcptResult!['significant'] == true ? 'Yes' : 'No'),
              ] else
                const Text('No MCPT result yet', style: TextStyle(fontSize: 13)),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: state.isValidating
                      ? null
                      : () => ref.read(backtestViewModelProvider.notifier).runMcptValidation(),
                  icon: const Icon(Icons.science, size: 18),
                  label: Text(state.isValidating ? 'Validating...' : 'Run MCPT Test'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mcptRow(BuildContext context, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Text(value,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      );
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.onDelete});
  final BacktestResultData result;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isPositive = result.totalReturn >= 0;
    final color = isPositive ? StockholmColors.signalPositive : StockholmColors.signalNegative;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(result.strategy.replaceAll('_', ' ').toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat('MMM d').format(result.createdAt), style: const TextStyle(fontSize: 12)),
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
