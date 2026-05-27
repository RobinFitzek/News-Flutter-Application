import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../config/stockholm_colors.dart';
import '../../engine/economic_calendar.dart';
import '../../data/repositories/watchlist_repository.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_loading.dart';

class EconomicCalendarScreen extends ConsumerStatefulWidget {
  const EconomicCalendarScreen({super.key});

  @override
  ConsumerState<EconomicCalendarScreen> createState() => _EconomicCalendarScreenState();
}

class _EconomicCalendarScreenState extends ConsumerState<EconomicCalendarScreen> {
  List<Map<String, dynamic>> _events = [];
  bool _loaded = false;
  String? _error;

  Future<void> _load() async {
    setState(() { _loaded = false; _error = null; });
    try {
      final watchlist = await ref.read(watchlistRepositoryProvider).getAll();
      final symbols = watchlist.map((w) => w.symbol).toList();
      _events = await EconomicCalendar().getUpcomingEvents(
        daysAhead: 30,
        watchlistSymbols: symbols,
      );
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Economic Calendar')),
      body: !_loaded
          ? const ShimmerLoading(count: 5)
          : RefreshIndicator(
              onRefresh: _load,
              child: _error != null
                  ? Center(child: Text(_error!))
                  : _events.isEmpty
                      ? const Center(child: Text('No upcoming events'))
                      : ListView.builder(
                          itemCount: _events.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, i) {
                            final e = _events[i];
                            final date = e['date'] as DateTime;
                            final impact = e['impact']?.toString() ?? 'medium';
                            final color = impact == 'high'
                                ? StockholmColors.signalNegative
                                : impact == 'medium'
                                    ? StockholmColors.signalWarning
                                    : StockholmColors.signalNeutral;
                            return GlassCard(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Icon(
                                  e['type'] == 'earnings'
                                      ? Icons.trending_up
                                      : Icons.public,
                                  color: color,
                                ),
                                title: Text(e['name']?.toString() ?? '',
                                    style: const TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text('${e['symbol']} · ${e['type']}'),
                                trailing: Text(DateFormat('MMM d').format(date),
                                    style: const TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            );
                          },
                        ),
            ),
    );
  }
}
