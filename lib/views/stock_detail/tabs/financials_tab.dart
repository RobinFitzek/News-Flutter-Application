import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/datasources/local/database_datasource.dart';
import '../../../engine/financial_statements.dart';
import '../../../config/stockholm_colors.dart';
import '../../../widgets/glass_card.dart';

class FinancialsTab extends ConsumerStatefulWidget {
  const FinancialsTab({
    super.key,
    required this.symbol,
    this.ratios,
    this.isLoading = false,
  });

  final String symbol;
  final FinancialRatioData? ratios;
  final bool isLoading;

  @override
  ConsumerState<FinancialsTab> createState() => _FinancialsTabState();
}

class _FinancialsTabState extends ConsumerState<FinancialsTab> {
  Map<String, dynamic>? _dcf;
  Map<String, dynamic>? _quarterly;
  List<Map<String, dynamic>> _peers = [];
  bool _extLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExtended();
  }

  Future<void> _loadExtended() async {
    final db = ref.read(databaseProvider);
    final fs = FinancialStatements(db);
    final dcf = await fs.estimateDcf(widget.symbol);
    final q = await fs.getQuarterlyFinancials(widget.symbol);
    final peers = await fs.getPeers(widget.symbol);
    if (mounted) {
      setState(() {
        _dcf = dcf;
        _quarterly = q;
        _peers = peers;
        _extLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading || _extLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ratios = widget.ratios;
    if (ratios == null && _quarterly?['available'] != true) {
      return const Center(child: Text('Financial data unavailable'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_dcf?['available'] == true)
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DCF Estimate',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 8),
                  _buildRow(context, 'Fair Value', _dcf!['fair_value'],
                      prefix: '\$'),
                  _buildRow(context, 'Current Price', _dcf!['current_price'],
                      prefix: '\$'),
                  _buildRow(context, 'Upside', _dcf!['upside_pct'],
                      suffix: '%'),
                ],
              ),
            ),
          ),
        if (_quarterly?['available'] == true) ...[
          const SizedBox(height: 12),
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quarterly Trends',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 8),
                  if (_quarterly!['revenue_growth_pct'] != null)
                    _buildRow(context, 'Revenue Growth',
                        _quarterly!['revenue_growth_pct'],
                        suffix: '%'),
                  if (_quarterly!['profit_margin_pct'] != null)
                    _buildRow(context, 'Profit Margin',
                        _quarterly!['profit_margin_pct'],
                        suffix: '%'),
                  if (_quarterly!['eps'] != null)
                    _buildRow(context, 'EPS', _quarterly!['eps'], prefix: '\$'),
                ],
              ),
            ),
          ),
        ],
        if (ratios != null) ...[
          const SizedBox(height: 12),
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Valuation',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 12),
                  _buildRow(context, 'P/E Ratio', ratios.peRatio, suffix: 'x'),
                  _buildRow(context, 'P/B Ratio', ratios.pbRatio, suffix: 'x'),
                  _buildRow(context, 'EPS', ratios.eps, prefix: '\$'),
                  _buildRow(context, 'Dividend Yield', ratios.dividendYield,
                      suffix: '%', isPercent: true),
                ],
              ),
            ),
          ),
        ],
        if (_peers.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Peer Comparison',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: StockholmColors.signalNeutral,
                    fontWeight: FontWeight.bold,
                  )),
          ..._peers.map((p) => GlassCard(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  title: Text(p['symbol']?.toString() ?? ''),
                  subtitle: Text(
                      'P/E ${p['pe_ratio'] ?? '—'} · Growth ${p['revenue_growth'] ?? '—'}'),
                ),
              )),
        ],
      ],
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    dynamic value, {
    String prefix = '',
    String suffix = '',
    bool isPercent = false,
  }) {
    if (value == null) return const SizedBox.shrink();
    final display = isPercent && value is num
        ? (value * 100).toStringAsFixed(2)
        : value.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('$prefix$display$suffix',
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
