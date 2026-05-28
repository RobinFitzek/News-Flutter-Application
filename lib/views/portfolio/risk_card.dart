import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/stockholm_colors.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/remote/yahoo_finance_client.dart';
import '../../engine/concentration_checker.dart';
import '../../engine/drawdown_tracker.dart';
import '../../engine/risk_calculator.dart';
import '../../engine/var_calculator.dart';
import '../../widgets/glass_card.dart';

class PortfolioRiskCard extends ConsumerStatefulWidget {
  const PortfolioRiskCard({super.key, required this.positions});

  final List<PositionData> positions;

  @override
  ConsumerState<PortfolioRiskCard> createState() => _PortfolioRiskCardState();
}

class _PortfolioRiskCardState extends ConsumerState<PortfolioRiskCard> {
  Map<String, double>? _riskMetrics;
  Map<String, dynamic>? _concentration;
  Map<String, dynamic>? _varResult;
  Map<String, dynamic>? _drawdown;
  double? _spyReturn;
  bool _isLoading = false;
  bool _expanded = false;

  Future<void> _loadRisk() async {
    if (widget.positions.isEmpty) return;
    setState(() => _isLoading = true);

    final holdings = widget.positions
        .map((p) => {
              'symbol': p.symbol,
              'value': p.shares * p.currentPrice,
            })
        .toList();
    final symbols = widget.positions.map((p) => p.symbol).toList();
    final weights =
        widget.positions.map((p) => p.shares * p.currentPrice).toList();
    final values = List<double>.from(weights);

    try {
      final concentration = await ConcentrationChecker().checkPortfolio(holdings);
      final varResult = await VarCalculator().calculateVar(
        tickers: symbols,
        weights: weights,
      );

      setState(() {
        _concentration = concentration;
        _varResult = varResult;
        _riskMetrics = RiskCalculator.calculate(equityCurve: values);
        _drawdown = DrawdownTracker.analyzeEquityCurve(values);
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        _riskMetrics = RiskCalculator.calculate(equityCurve: values);
        _drawdown = DrawdownTracker.analyzeEquityCurve(values);
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchSpyBenchmark() async {
    setState(() => _isLoading = true);
    try {
      final quote = await YahooFinanceClient().getStockQuote('SPY');
      setState(() {
        _spyReturn = quote['changePercent'] as double?;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  String _exportCsv() {
    final buffer = StringBuffer(
      'Symbol,Company,Shares,AvgCost,CurrentPrice,MarketValue,UnrealizedPnl\n',
    );
    for (final p in widget.positions) {
      final mv = p.shares * p.currentPrice;
      final pnl = mv - p.shares * p.avgCostBasis;
      buffer.writeln(
        '${p.symbol},${p.companyName},${p.shares},${p.avgCostBasis},${p.currentPrice},$mv,$pnl',
      );
    }
    return buffer.toString();
  }

  Future<void> _shareCsv() async {
    await Share.share(_exportCsv(), subject: 'portfolio_export.csv');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          onTap: () {
            setState(() => _expanded = !_expanded);
            if (_expanded && _riskMetrics == null) _loadRisk();
          },
          child: Row(
            children: [
              Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              const Text('Risk & Performance',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ],
          ),
        ),
        if (_expanded) ...[
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else if (_riskMetrics != null) ...[
            GlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Risk Metrics',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _metricRow('Sharpe Ratio', _riskMetrics!['sharpe']!.toStringAsFixed(2)),
                  _metricRow('Sortino Ratio', _riskMetrics!['sortino']!.toStringAsFixed(2)),
                  _metricRow('Volatility', '${_riskMetrics!['volatility']!.toStringAsFixed(2)}%'),
                  _metricRow('Max Drawdown', '-${_riskMetrics!['maxDrawdown']!.toStringAsFixed(2)}%'),
                  if (_drawdown?['current_drawdown_pct'] != null)
                    _metricRow(
                      'Current Drawdown',
                      '-${_drawdown!['current_drawdown_pct']}%',
                    ),
                  if (_varResult?['error'] == null && _varResult?['var_daily_pct'] != null)
                    _metricRow(
                      'VaR (95% daily)',
                      '-${_varResult!['var_daily_pct']}%',
                    ),
                  if (_concentration?['diversification_score'] != null)
                    _metricRow(
                      'Diversification',
                      '${_concentration!['diversification_score']}/100',
                    ),
                  const SizedBox(height: 12),
                  if (_spyReturn == null)
                    TextButton.icon(
                      onPressed: _fetchSpyBenchmark,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Compare to S&P 500'),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('S&P 500 (SPY)',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                          '${_spyReturn! >= 0 ? '+' : ''}${_spyReturn!.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: _spyReturn! >= 0
                                ? StockholmColors.signalPositive
                                : StockholmColors.signalNegative,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (_concentration != null &&
                (_concentration!['warnings'] as List?)?.isNotEmpty == true)
              GlassCard(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Concentration Warnings',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...(_concentration!['warnings'] as List)
                        .take(5)
                        .map((w) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('• $w',
                                  style: const TextStyle(fontSize: 12)),
                            )),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: OutlinedButton.icon(
                onPressed: widget.positions.isEmpty ? null : _shareCsv,
                icon: const Icon(Icons.share),
                label: const Text('Export Portfolio CSV'),
              ),
            ),
          ]
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(onPressed: _loadRisk, child: const Text('Calculate Risk Metrics')),
            ),
        ],
      ],
    );
  }

  Widget _metricRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                  fontSize: 13,
                  color: StockholmColors.textSecondary,
                )),
            Text(value,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      );
}
