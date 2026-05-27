import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../engine/lstm_predictor.dart';
import '../../config/stockholm_colors.dart';
import '../glass_card.dart';

class LstmSignalsCard extends ConsumerStatefulWidget {
  const LstmSignalsCard({super.key});

  @override
  ConsumerState<LstmSignalsCard> createState() => _LstmSignalsCardState();
}

class _LstmSignalsCardState extends ConsumerState<LstmSignalsCard> {
  List<Map<String, dynamic>> _signals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final watchlist = await ref.read(watchlistRepositoryProvider).getAll();
    final tickers = watchlist.map((w) => w.symbol).take(8).toList();
    if (tickers.isEmpty) {
      if (mounted) setState(() { _loading = false; _signals = []; });
      return;
    }
    final predictor = LstmPredictor();
    _signals = await predictor.getBuySignals(tickers);
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.memory, color: StockholmColors.signalNeutral, size: 20),
                const SizedBox(width: 8),
                Text('LSTM Price Forecast',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const Spacer(),
                IconButton(icon: const Icon(Icons.refresh, size: 18), onPressed: _load),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Heuristic ensemble (technical + politician + macro features)',
              style: TextStyle(fontSize: 11, color: StockholmColors.textSecondary),
            ),
            const SizedBox(height: 8),
            if (_loading)
              const LinearProgressIndicator()
            else if (_signals.isEmpty)
              Text('No buy signals above threshold',
                  style: TextStyle(fontSize: 12, color: StockholmColors.textMuted))
            else
              ..._signals.take(3).map((s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Text(s['ticker'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Text(
                          '${((s['confidence'] as double) * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
