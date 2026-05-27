import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/stockholm_colors.dart';
import '../../../widgets/glass_card.dart';
import '../widgets/stock_extras_section.dart';

class ResearchTab extends StatelessWidget {
  const ResearchTab({
    super.key,
    required this.symbol,
    this.shortData,
    this.squeezeSetup,
    this.darkPoolSignals = const [],
    this.moatData,
    this.sentimentData,
    this.supplyChain,
    this.isLoading = false,
  });

  final String symbol;
  final Map<String, dynamic>? shortData;
  final Map<String, dynamic>? squeezeSetup;
  final List<Map<String, dynamic>> darkPoolSignals;
  final Map<String, dynamic>? moatData;
  final Map<String, dynamic>? sentimentData;
  final Map<String, dynamic>? supplyChain;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle(context, 'Economic Moat'),
        GlassCard(
          margin: EdgeInsets.zero,
          child: moatData == null
              ? const Text('Moat score unavailable.',
                  style: TextStyle(color: StockholmColors.textSecondary))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _moatHeader(moatData!),
                    const SizedBox(height: 8),
                    ..._factorRows(moatData!['factors'] as Map<String, dynamic>?),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        _sectionTitle(context, 'NLP Sentiment'),
        GlassCard(
          margin: EdgeInsets.zero,
          child: sentimentData == null
              ? const Text('Sentiment data unavailable.',
                  style: TextStyle(color: StockholmColors.textSecondary))
              : _sentimentBody(sentimentData!),
        ),
        const SizedBox(height: 16),
        _sectionTitle(context, 'Supply Chain'),
        GlassCard(
          margin: EdgeInsets.zero,
          child: _supplyChainBody(supplyChain),
        ),
        const SizedBox(height: 16),
        _sectionTitle(context, 'Short Interest'),
        GlassCard(
          margin: EdgeInsets.zero,
          child: shortData == null
              ? const Text('Short interest data unavailable.',
                  style: TextStyle(color: StockholmColors.textSecondary))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row('Short % Float',
                        '${(shortData!['short_pct_float'] as num?)?.toStringAsFixed(1) ?? '—'}%'),
                    _row('Days to Cover',
                        '${shortData!['days_to_cover'] ?? '—'}'),
                    _row('Short Shares',
                        '${shortData!['short_shares'] ?? '—'}'),
                    if (squeezeSetup != null) ...[
                      const SizedBox(height: 8),
                      _squeezeBadge(squeezeSetup!),
                      ...(squeezeSetup!['signals'] as List? ?? [])
                          .map((s) => Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text('• $s',
                                    style: const TextStyle(fontSize: 12)),
                              )),
                    ],
                  ],
                ),
        ),
        const SizedBox(height: 16),
        _sectionTitle(context, 'Dark Pool Proxy'),
        if (darkPoolSignals.isEmpty)
          const GlassCard(
            margin: EdgeInsets.zero,
            child: Text('No recent volume anomalies detected.',
                style: TextStyle(color: StockholmColors.textSecondary)),
          )
        else
          ...darkPoolSignals.take(5).map((s) => GlassCard(
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s['signal_type']?.toString() ?? 'signal',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(s['description']?.toString() ?? '',
                        style: const TextStyle(fontSize: 12)),
                    _row('Volume ratio', '${s['volume_ratio']}x'),
                    _row('Est. value',
                        '\$${((s['estimated_value'] as num?) ?? 0).toStringAsFixed(0)}'),
                  ],
                ),
              )),
        const SizedBox(height: 16),
        _sectionTitle(context, 'More Research'),
        GlassCard(
          margin: EdgeInsets.zero,
          onTap: () => context.push('/research/options?symbol=$symbol'),
          child: const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.show_chart, color: StockholmColors.signalNeutral),
            title: Text('Options Flow'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        const SizedBox(height: 16),
        StockExtrasSection(symbol: symbol),
      ],
    );
  }

  Widget _moatHeader(Map<String, dynamic> moat) {
    final score = (moat['moat_score'] as num?)?.toDouble() ?? 0;
    final grade = moat['grade']?.toString() ?? '—';
    final color = score >= 70
        ? StockholmColors.signalPositive
        : score >= 45
            ? StockholmColors.signalWarning
            : StockholmColors.textSecondary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$grade moat',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        Text('${score.toStringAsFixed(0)}/100',
            style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  List<Widget> _factorRows(Map<String, dynamic>? factors) {
    if (factors == null) return [];
    return factors.entries.map((e) {
      final data = e.value as Map<String, dynamic>? ?? {};
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                e.key.replaceAll('_', ' '),
                style: const TextStyle(fontSize: 12, color: StockholmColors.textSecondary),
              ),
            ),
            Text('${data['score'] ?? '—'}/25',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }).toList();
  }

  Widget _sentimentBody(Map<String, dynamic> data) {
    final compound = (data['compound'] as num?)?.toDouble() ?? 0;
    final color = compound > 0.1
        ? StockholmColors.signalPositive
        : compound < -0.1
            ? StockholmColors.signalNegative
            : StockholmColors.signalNeutral;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Compound score', compound.toStringAsFixed(3), valueColor: color),
        _row('Headlines matched', '${data['headline_count'] ?? 0}'),
        _row('Positive share',
            '${(((data['positive'] as num?) ?? 0) * 100).toStringAsFixed(0)}%'),
        _row('Negative share',
            '${(((data['negative'] as num?) ?? 0) * 100).toStringAsFixed(0)}%'),
      ],
    );
  }

  Widget _supplyChainBody(Map<String, dynamic>? data) {
    if (data == null) {
      return const Text('Supply chain data unavailable.',
          style: TextStyle(color: StockholmColors.textSecondary));
    }
    final suppliers = (data['suppliers'] as List?) ?? [];
    final customers = (data['customers'] as List?) ?? [];
    if (suppliers.isEmpty && customers.isEmpty) {
      return const Text(
        'No supply chain map yet. Configure Perplexity in Settings to fetch.',
        style: TextStyle(color: StockholmColors.textSecondary, fontSize: 13),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (suppliers.isNotEmpty) ...[
          const Text('Suppliers', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ...suppliers.take(4).map((s) => Text('• ${s['company_name']}',
              style: const TextStyle(fontSize: 12))),
          const SizedBox(height: 8),
        ],
        if (customers.isNotEmpty) ...[
          const Text('Customers', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ...customers.take(3).map((s) => Text('• ${s['company_name']}',
              style: const TextStyle(fontSize: 12))),
        ],
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
      );

  Widget _row(String k, String v, {Color? valueColor}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(color: StockholmColors.textSecondary)),
            Text(v,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                )),
          ],
        ),
      );

  Widget _squeezeBadge(Map<String, dynamic> setup) {
    final candidate = setup['is_squeeze_candidate'] == true;
    final color = candidate
        ? StockholmColors.signalNegative
        : StockholmColors.signalWarning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        candidate
            ? 'Squeeze candidate (${setup['squeeze_score']}/100)'
            : 'Squeeze score ${setup['squeeze_score']}/100',
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
