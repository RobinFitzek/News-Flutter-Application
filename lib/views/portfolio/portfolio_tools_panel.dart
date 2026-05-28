import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/provider_repository.dart';
import '../../engine/portfolio_manager.dart';
import '../../engine/portfolio_qa.dart';
import '../../engine/cash_manager.dart';

class PortfolioToolsPanel extends ConsumerStatefulWidget {
  const PortfolioToolsPanel({super.key});

  @override
  ConsumerState<PortfolioToolsPanel> createState() => _PortfolioToolsPanelState();
}

class _PortfolioToolsPanelState extends ConsumerState<PortfolioToolsPanel> {
  final _qaController = TextEditingController();
  String? _qaAnswer;
  bool _qaLoading = false;
  List<Map<String, dynamic>> _alerts = [];
  List<Map<String, dynamic>> _rebalancing = [];
  Map<String, dynamic>? _cashRec;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _qaController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    final pm = PortfolioManager(db);
    final alerts = await pm.getAlertsWithAck();
    final plan = await pm.getRebalancingPlan();
    final cash = await CashManager(db).getCashAllocationRecommendation();
    if (mounted) {
      setState(() {
        _alerts = alerts;
        _rebalancing = plan;
        _cashRec = cash;
      });
    }
  }

  Future<void> _ask() async {
    if (_qaController.text.trim().isEmpty) return;
    setState(() { _qaLoading = true; _qaAnswer = null; });
    final db = ref.read(databaseProvider);
    final qa = PortfolioQa(db: db, providerRepo: ref.read(providerRepositoryProvider));
    final result = await qa.ask(_qaController.text.trim());
    if (mounted) {
      setState(() {
        _qaLoading = false;
        _qaAnswer = result['error']?.toString() ?? result['answer']?.toString();
      });
    }
  }

  Future<void> _ackAlert(Map<String, dynamic> alert) async {
    await PortfolioManager(ref.read(databaseProvider)).acknowledgeAlert(alert);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_cashRec != null)
          Card(
            child: ListTile(
              title: Text('Cash: ${_cashRec!['cash_percentage']}%'),
              subtitle: Text(_cashRec!['action'] as String),
              trailing: Chip(label: Text(_cashRec!['status'] as String)),
            ),
          ),
        if (_alerts.isNotEmpty) ...[
          Text('Portfolio Alerts', style: Theme.of(context).textTheme.titleSmall),
          ..._alerts.map((a) => Card(
                color: a['severity'] == 'CRITICAL'
                    ? Colors.red.shade50
                    : Colors.amber.shade50,
                child: ListTile(
                  title: Text(a['message'] as String, style: const TextStyle(fontSize: 13)),
                  trailing: IconButton(
                    icon: const Icon(Icons.check, size: 18),
                    onPressed: () => _ackAlert(a),
                  ),
                ),
              )),
        ],
        if (_rebalancing.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Rebalancing Plan', style: Theme.of(context).textTheme.titleSmall),
          ..._rebalancing.map((p) => ListTile(
                dense: true,
                leading: Icon(
                  p['action'] == 'sell' ? Icons.remove_circle : Icons.add_circle,
                  color: p['action'] == 'sell' ? Colors.red : Colors.green,
                ),
                title: Text(p['message'] as String, style: const TextStyle(fontSize: 13)),
              )),
        ],
        const SizedBox(height: 12),
        Text('Portfolio Q&A', style: Theme.of(context).textTheme.titleSmall),
        TextField(
          controller: _qaController,
          decoration: InputDecoration(
            hintText: 'Ask about your holdings…',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: _qaLoading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.send),
              onPressed: _qaLoading ? null : _ask,
            ),
          ),
          maxLines: 2,
        ),
        if (_qaAnswer != null) ...[
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(12), child: Text(_qaAnswer!))),
        ],
      ],
    );
  }
}
