import 'package:flutter/material.dart';

import '../../engine/options_flow.dart';
import '../../config/stockholm_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_loading.dart';

class OptionsFlowScreen extends StatefulWidget {
  const OptionsFlowScreen({super.key, this.initialSymbol});

  final String? initialSymbol;

  @override
  State<OptionsFlowScreen> createState() => _OptionsFlowScreenState();
}

class _OptionsFlowScreenState extends State<OptionsFlowScreen> {
  final _engine = OptionsFlow();
  final _symbolCtrl = TextEditingController();
  Map<String, dynamic>? _summary;
  Map<String, dynamic>? _unusual;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initialSymbol != null) {
      _symbolCtrl.text = widget.initialSymbol!;
      _load(widget.initialSymbol!);
    } else {
      _load('SPY');
      _symbolCtrl.text = 'SPY';
    }
  }

  Future<void> _load(String symbol) async {
    setState(() { _loading = true; _error = null; });
    try {
      final summary = await _engine.getOptionsSummary(symbol);
      final unusual = await _engine.detectUnusualActivity(symbol);
      if (summary == null) {
        _error = 'No options data for $symbol';
      }
      _summary = summary;
      _unusual = unusual;
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = _summary;
    final sentiment = s?['sentiment']?.toString() ?? 'neutral';
    Color sentColor;
    switch (sentiment) {
      case 'bullish':
        sentColor = StockholmColors.signalPositive;
        break;
      case 'bearish':
        sentColor = StockholmColors.signalNegative;
        break;
      default:
        sentColor = StockholmColors.signalWarning;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Options Flow')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _symbolCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Symbol', prefixIcon: Icon(Icons.search)),
              onSubmitted: (v) => _load(v.trim().toUpperCase()),
            ),
          ),
          Expanded(
            child: _loading
                ? const ShimmerLoading(count: 4)
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      if (_error != null)
                        GlassCard(child: Text(_error!, style: const TextStyle(color: StockholmColors.signalNegative))),
                      if (s != null) ...[
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(s['ticker']?.toString() ?? '',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: sentColor.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(sentiment.toUpperCase(),
                                        style: TextStyle(color: sentColor, fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _row('P/C Ratio (Vol)', s['pc_ratio_volume']?.toString() ?? '—'),
                              _row('P/C Ratio (OI)', s['pc_ratio_oi']?.toString() ?? '—'),
                              _row('Call Volume', '${s['call_volume']}'),
                              _row('Put Volume', '${s['put_volume']}'),
                              _row('IV Rank', s['iv_rank'] != null ? '${s['iv_rank']}%' : '—'),
                              _row('Nearest Expiry', s['expiry']?.toString() ?? '—'),
                            ],
                          ),
                        ),
                        if (_unusual?['has_unusual_activity'] == true) ...[
                          const SizedBox(height: 12),
                          Text('Unusual Activity', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                          ...List<Map<String, dynamic>>.from([
                            ...List<Map<String, dynamic>>.from(_unusual!['unusual_calls'] ?? []),
                            ...List<Map<String, dynamic>>.from(_unusual!['unusual_puts'] ?? []),
                          ]).map((u) => GlassCard(
                                margin: const EdgeInsets.only(top: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${u['type']} \$${u['strike']}'),
                                    Text('Vol ${u['volume']} · ${(u['vol_oi_ratio'] as num).toStringAsFixed(1)}x OI'),
                                  ],
                                ),
                              )),
                        ],
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(fontSize: 13, color: StockholmColors.textSecondary)),
            Text(v, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
