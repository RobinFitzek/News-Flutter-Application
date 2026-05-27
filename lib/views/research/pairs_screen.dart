import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../../engine/pairs_trader.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_loading.dart';

class PairsScreen extends StatefulWidget {
  const PairsScreen({super.key});

  @override
  State<PairsScreen> createState() => _PairsScreenState();
}

class _PairsScreenState extends State<PairsScreen> {
  final _engine = PairsTrader();
  List<Map<String, dynamic>> _pairs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      _pairs = await _engine.scanDefaultPairs();
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pairs Trading')),
      body: _loading
          ? const ShimmerLoading(count: 4)
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_error != null)
                    GlassCard(
                      child: Text(_error!,
                          style: const TextStyle(color: StockholmColors.signalNegative)),
                    ),
                  Text(
                    'Statistical pairs — spread z-score with correlation filter',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: StockholmColors.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  ..._pairs.map(_pairCard),
                ],
              ),
            ),
    );
  }

  Widget _pairCard(Map<String, dynamic> p) {
    if (p.containsKey('error')) {
      return GlassCard(
        margin: const EdgeInsets.only(bottom: 8),
        child: Text('${p['ticker_a']}/${p['ticker_b']}: ${p['error']}'),
      );
    }

    final z = (p['current_zscore'] as num?)?.toDouble() ?? 0;
    final signal = p['signal']?.toString() ?? 'hold';
    final active = signal == 'long_spread' || signal == 'short_spread';
    final color = active ? StockholmColors.signalWarning : StockholmColors.textMuted;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${p['ticker_a']} / ${p['ticker_b']}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(p['sector']?.toString() ?? '',
                  style: const TextStyle(
                      fontSize: 11, color: StockholmColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          _row('Z-Score', z.toStringAsFixed(2), color: color),
          _row('Correlation', '${p['correlation']}'),
          _row('Hedge ratio', '${p['hedge_ratio']}'),
          _row('Cointegrated proxy', p['cointegrated'] == true ? 'Yes' : 'No'),
          const SizedBox(height: 6),
          Text(_signalLabel(signal),
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }

  String _signalLabel(String signal) {
    switch (signal) {
      case 'long_spread':
        return 'Signal: LONG spread (buy A / sell B)';
      case 'short_spread':
        return 'Signal: SHORT spread (sell A / buy B)';
      case 'exit':
        return 'Signal: EXIT — spread normalized';
      default:
        return 'Signal: HOLD';
    }
  }

  Widget _row(String k, String v, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(fontSize: 13)),
            Text(v,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color)),
          ],
        ),
      );
}
