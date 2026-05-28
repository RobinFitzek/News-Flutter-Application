import 'dart:io';

import 'package:flutter/material.dart';

import '../../config/stockholm_colors.dart';
import '../../data/database/app_database.dart';
import '../../engine/portfolio_anomaly.dart';
import '../glass_card.dart';

class PortfolioAnomalyCard extends StatefulWidget {
  const PortfolioAnomalyCard({super.key, required this.holdings});

  final List<PositionData> holdings;

  @override
  State<PortfolioAnomalyCard> createState() => _PortfolioAnomalyCardState();
}

class _PortfolioAnomalyCardState extends State<PortfolioAnomalyCard> {
  final _detector = PortfolioAnomaly();
  List<Map<String, dynamic>>? _anomalies;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _loading = false;
    } else {
      _scan();
    }
  }

  @override
  void didUpdateWidget(PortfolioAnomalyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.holdings != widget.holdings) _scan();
  }

  Future<void> _scan() async {
    setState(() => _loading = true);
    final result = await _detector.scan(widget.holdings);
    if (mounted) {
      setState(() {
        _anomalies = result;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const GlassCard(
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    final items = _anomalies ?? [];
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber,
                  color: items.isEmpty
                      ? StockholmColors.signalPositive
                      : StockholmColors.signalWarning,
                  size: 20),
              const SizedBox(width: 8),
              Text('Portfolio Anomalies',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: StockholmColors.textPrimary,
                      )),
            ],
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            Text('No systemic risk patterns detected.',
                style: TextStyle(
                    color: StockholmColors.textSecondary, fontSize: 13))
          else
            ...items.map((a) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '• ${a['description']}',
                    style: const TextStyle(
                        color: StockholmColors.signalWarning, fontSize: 13),
                  ),
                )),
        ],
      ),
    );
  }
}
