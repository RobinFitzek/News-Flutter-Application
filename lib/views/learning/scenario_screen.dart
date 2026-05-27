import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/stockholm_colors.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../engine/scenario_analyzer.dart';
import '../../widgets/glass_card.dart';

class ScenarioScreen extends ConsumerStatefulWidget {
  const ScenarioScreen({super.key});

  @override
  ConsumerState<ScenarioScreen> createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends ConsumerState<ScenarioScreen> {
  final _analyzer = ScenarioAnalyzer();
  Map<String, dynamic>? _result;
  String? _selectedKey;
  bool _loading = false;

  Future<void> _runScenario(String key) async {
    setState(() {
      _loading = true;
      _selectedKey = key;
      _result = null;
    });
    try {
      final positions = await ref.read(portfolioRepositoryProvider).getAllPositions();
      final result = await _analyzer.runScenario(key, positions);
      if (mounted) setState(() => _result = result);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final presets = _analyzer.getPresetScenarios();

    return Scaffold(
      appBar: AppBar(title: const Text('Scenario Analysis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Portfolio Stress Tests',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: StockholmColors.signalNeutral,
                  )),
          const SizedBox(height: 8),
          ...presets.map((s) => GlassCard(
                margin: const EdgeInsets.only(bottom: 8),
                onTap: _loading ? null : () => _runScenario(s['key'] as String),
                child: ListTile(
                  leading: Icon(Icons.analytics_outlined,
                      color: _selectedKey == s['key']
                          ? StockholmColors.signalWarning
                          : StockholmColors.textSecondary),
                  title: Text(s['name']?.toString() ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(s['description']?.toString() ?? ''),
                  trailing: _loading && _selectedKey == s['key']
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.chevron_right),
                ),
              )),
          if (_result != null && _result!['error'] == null) ...[
            const SizedBox(height: 16),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_result!['scenario']?.toString() ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    _row('Portfolio Value',
                        '\$${_result!['portfolio_value']}'),
                    _row('Total Impact',
                        '\$${_result!['total_impact_usd']} (${_result!['total_impact_pct']}%)',
                        color: (_result!['total_impact_usd'] as num) >= 0
                            ? StockholmColors.signalPositive
                            : StockholmColors.signalNegative),
                    const Divider(height: 24),
                    ...((_result!['impacts'] as List).map((i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('${i['symbol']} (${i['sector']})',
                                      style: const TextStyle(fontSize: 13))),
                              Text('${i['pct_change']}%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: (i['impact_usd'] as num) >= 0
                                          ? StockholmColors.signalPositive
                                          : StockholmColors.signalNegative)),
                            ],
                          ),
                        ))),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 13, color: color)),
          ],
        ),
      );
}
