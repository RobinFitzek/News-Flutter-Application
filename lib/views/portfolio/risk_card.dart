import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../engine/risk_calculator.dart';
import 'dart:convert';

class PortfolioRiskCard extends ConsumerStatefulWidget {
  const PortfolioRiskCard({super.key, required this.positions});

  final List<PositionData> positions;

  @override
  ConsumerState<PortfolioRiskCard> createState() => _PortfolioRiskCardState();
}

class _PortfolioRiskCardState extends ConsumerState<PortfolioRiskCard> {
  Map<String, double>? _riskMetrics;
  double? _spyReturn;
  bool _isLoading = false;
  bool _expanded = false;

  void _calculateRisk() {
    setState(() => _isLoading = true);
    final values = <double>[];
    for (final p in widget.positions) {
      values.add(p.shares * p.currentPrice);
    }
    if (values.isNotEmpty) {
      setState(() {
        _riskMetrics = RiskCalculator.calculate(equityCurve: values);
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchSpyBenchmark() async {
    setState(() => _isLoading = true);
    try {
      final client = YahooFinanceClient();
      final quote = await client.getStockQuote('SPY');
      final changePct = quote['changePercent'] as double;
      setState(() {
        _spyReturn = changePct;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  String _exportCsv() {
    final buffer = StringBuffer('Symbol,Company,Shares,AvgCost,CurrentPrice,MarketValue,UnrealizedPnl\n');
    for (final p in widget.positions) {
      final mv = p.shares * p.currentPrice;
      final pnl = mv - p.shares * p.avgCostBasis;
      buffer.writeln('${p.symbol},${p.companyName},${p.shares},${p.avgCostBasis},${p.currentPrice},${mv},${pnl}');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () {
              setState(() => _expanded = !_expanded);
              if (_expanded && _riskMetrics == null) _calculateRisk();
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text('Risk & Performance', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
        ),
        if (_expanded) ...[
          if (_isLoading)
            const Card(child: Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator())))
          else ...[
            if (_riskMetrics != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Risk Metrics', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _metricRow(context, 'Sharpe Ratio', _riskMetrics!['sharpe']!.toStringAsFixed(2)),
                      _metricRow(context, 'Sortino Ratio', _riskMetrics!['sortino']!.toStringAsFixed(2)),
                      _metricRow(context, 'Volatility', '${_riskMetrics!['volatility']!.toStringAsFixed(2)}%'),
                      _metricRow(context, 'Max Drawdown', '-${_riskMetrics!['maxDrawdown']!.toStringAsFixed(2)}%'),
                      _metricRow(context, 'VaR (95%)', '-${_riskMetrics!['var95']!.toStringAsFixed(2)}%'),
                      const SizedBox(height: 12),
                      if (_spyReturn == null)
                        TextButton.icon(onPressed: _fetchSpyBenchmark, icon: const Icon(Icons.refresh), label: const Text('Compare to S&P 500'))
                      else
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text('S&P 500 (SPY)', style: TextStyle(fontWeight: FontWeight.w600)),
                          Text('${_spyReturn! >= 0 ? "+" : ""}${_spyReturn!.toStringAsFixed(2)}%',
                              style: TextStyle(color: _spyReturn! >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                        ]),
                    ],
                  ),
                ),
              )
            else
              TextButton(onPressed: _calculateRisk, child: const Text('Calculate Risk Metrics')),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.download),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        final csv = _exportCsv();
                        // For now, show a snackbar with the CSV preview
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('CSV export ready (copy to clipboard)'),
                            action: SnackBarAction(label: 'Copy', onPressed: () {
                              // Clipboard functionality would go here in full impl
                            }),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                      icon: const Icon(Icons.table_chart),
                      label: const Text('Export CSV'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _metricRow(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 13)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    ]),
  );
}
