import 'package:flutter/material.dart';
import '../../../engine/reddit_sentiment.dart';
import '../../../engine/catalyst_tracker.dart';
import '../../../engine/extended_hours.dart';
import '../../../engine/risk_trend.dart';
import '../../../engine/smart_money.dart';
import '../../../data/database/app_database.dart';
import '../../../widgets/glass_card.dart';

/// Self-loading stock extras: Reddit, catalysts, extended hours, risk trend, smart money.
class StockExtrasSection extends StatefulWidget {
  const StockExtrasSection({super.key, required this.symbol});
  final String symbol;

  @override
  State<StockExtrasSection> createState() => _StockExtrasSectionState();
}

class _StockExtrasSectionState extends State<StockExtrasSection> {
  Map<String, dynamic>? _reddit;
  List<Map<String, dynamic>>? _catalysts;
  Map<String, dynamic>? _extended;
  Map<String, dynamic>? _riskTrend;
  Map<String, dynamic>? _smartMoney;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sym = widget.symbol;
    final db = AppDatabase();
    final results = await Future.wait([
      RedditSentiment().getRedditSentiment(sym),
      CatalystTracker().getCatalysts(sym),
      ExtendedHours().getExtendedHours(sym),
      RiskTrend(db).getRiskTrendSummary(sym),
      SmartMoneyTracker(db).getSmartMoneyActivity(sym),
    ]);
    if (mounted) {
      setState(() {
        _reddit = results[0] as Map<String, dynamic>;
        _catalysts = results[1] as List<Map<String, dynamic>>;
        _extended = results[2] as Map<String, dynamic>;
        _riskTrend = results[3] as Map<String, dynamic>;
        _smartMoney = results[4] as Map<String, dynamic>;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LinearProgressIndicator();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context, 'Extended Hours'),
        GlassCard(margin: EdgeInsets.zero, child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Pre: \$${_extended?['pre_market_price'] ?? '—'} · Post: \$${_extended?['post_market_price'] ?? '—'} · ${_extended?['market_state'] ?? ''}',
            style: const TextStyle(fontSize: 13),
          ),
        )),
        const SizedBox(height: 12),
        _title(context, 'Reddit Sentiment'),
        GlassCard(margin: EdgeInsets.zero, child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Score: ${_reddit?['sentiment_score']} (${(_reddit?['posts'] as List?)?.length ?? 0} posts)'),
        )),
        const SizedBox(height: 12),
        _title(context, 'Smart Money'),
        GlassCard(margin: EdgeInsets.zero, child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            _smartMoney?['smart_money_badge'] == true
                ? 'Badge active — ${(_smartMoney?['new_positions'] as List?)?.length ?? 0} new, ${(_smartMoney?['increased'] as List?)?.length ?? 0} increased'
                : 'No smart money badge',
          ),
        )),
        const SizedBox(height: 12),
        _title(context, 'Risk Trend'),
        GlassCard(margin: EdgeInsets.zero, child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Trend: ${_riskTrend?['trend']} · Current risk: ${_riskTrend?['current_risk']}/10'),
        )),
        const SizedBox(height: 12),
        _title(context, 'Upcoming Catalysts'),
        if (_catalysts == null || _catalysts!.isEmpty)
          const Text('No upcoming catalysts', style: TextStyle(fontSize: 13))
        else
          ..._catalysts!.map((c) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text('${c['date']} — ${c['title']}'),
                subtitle: Text(c['detail']?.toString() ?? ''),
              )),
      ],
    );
  }

  Widget _title(BuildContext context, String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(t, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
      );
}
