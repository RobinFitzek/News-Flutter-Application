import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import '../../data/database/app_database.dart';
import '../../viewmodels/portfolio_viewmodel.dart';
import '../../config/theme.dart';
import 'risk_card.dart';

class HoldingsTab extends ConsumerStatefulWidget {
  const HoldingsTab({super.key});

  @override
  ConsumerState<HoldingsTab> createState() => _HoldingsTabState();
}

class _HoldingsTabState extends ConsumerState<HoldingsTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(portfolioViewModelProvider.notifier).loadPositions();
    });
  }

  Color _gainLossColor(BuildContext context, double val) {
    final colors = Theme.of(context).extension<StockColors>() ??
        const StockColors(gainColor: Colors.green, lossColor: Colors.red);
    return val >= 0 ? colors.gainColor : colors.lossColor;
  }

  Future<void> _showAddDialog() async {
    final symbolController = TextEditingController();
    final sharesController = TextEditingController();
    final costController = TextEditingController();
    final nameController = TextEditingController();
    final notesController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Position'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: symbolController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Symbol',
                  hintText: 'e.g. AAPL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: sharesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Shares',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: costController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Avg Cost Basis',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == true && symbolController.text.isNotEmpty) {
      final shares = double.tryParse(sharesController.text) ?? 0;
      final cost = double.tryParse(costController.text) ?? 0;
      if (shares > 0 && cost > 0) {
          await ref.read(portfolioViewModelProvider.notifier).addPosition(
                PositionData(
                  id: 0,
                  symbol: symbolController.text.toUpperCase(),
                  companyName: nameController.text,
                  shares: shares,
                  avgCostBasis: cost,
                  currentPrice: cost,
                  acquiredAt: DateTime.now(),
                  currency: 'USD',
                  note: notesController.text.isNotEmpty ? notesController.text : null,
                ),
              );
      }
    }
  }

  Future<void> _showEditDialog(PositionData position) async {
    final symbolController = TextEditingController(text: position.symbol);
    final nameController = TextEditingController(text: position.companyName);
    final sharesController = TextEditingController(text: position.shares.toString());
    final costController = TextEditingController(text: position.avgCostBasis.toString());
    final notesController = TextEditingController(text: position.note);

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Position'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: symbolController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Company Name', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: sharesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Shares', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: costController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Avg Cost Basis', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: notesController, decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder())),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );

    if (result == true) {
      final shares = double.tryParse(sharesController.text) ?? position.shares;
      final cost = double.tryParse(costController.text) ?? position.avgCostBasis;
        await ref.read(portfolioViewModelProvider.notifier).updatePosition(
              position.copyWith(
                symbol: symbolController.text,
                companyName: nameController.text,
                shares: shares,
                avgCostBasis: cost,
                note: Value(notesController.text.isNotEmpty ? notesController.text : null),
              ),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(portfolioViewModelProvider);
    final summary = state.summary;

    if (state.isLoading && state.positions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => ref.read(portfolioViewModelProvider.notifier).refreshPrices(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (summary != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Portfolio Summary', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Market Value'),
                            Text('\$${summary.totalMarketValue.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Cost'),
                            Text('\$${summary.totalCostBasis.toStringAsFixed(2)}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total P&L'),
                            Text(
                              '\$${summary.totalUnrealizedPnl.toStringAsFixed(2)} (${summary.totalUnrealizedPnlPercent.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                color: _gainLossColor(context, summary.totalUnrealizedPnl),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('${summary.openPositionsCount} positions', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PortfolioRiskCard(positions: state.positions),
                const SizedBox(height: 16),
              ],
              if (state.positions.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.account_balance_wallet, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(height: 16),
                        Text('No positions yet', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text('Add your first position'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(onPressed: _showAddDialog, icon: const Icon(Icons.add), label: const Text('Add Position')),
                      ],
                    ),
                  ),
                )
              else
                ...state.positions.map((p) => _PositionTile(
                      position: p,
                      gainLossColor: (v) => _gainLossColor(context, v),
                      onTap: () => _showEditDialog(p),
                      onDelete: () => _confirmDelete(p),
                    )),
            ],
          ),
        ),
        if (state.positions.isNotEmpty)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _showAddDialog,
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }

  Future<void> _confirmDelete(PositionData p) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Position'),
        content: Text('Remove ${p.symbol} from portfolio?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(portfolioViewModelProvider.notifier).deletePosition(p.id);
    }
  }
}

class _PositionTile extends StatelessWidget {
  const _PositionTile({required this.position, required this.gainLossColor, required this.onTap, required this.onDelete});

  final PositionData position;
  final Color Function(double) gainLossColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final pnl = position.shares * position.currentPrice - position.shares * position.avgCostBasis;
    final pnlPct = position.avgCostBasis != 0 ? (pnl / (position.shares * position.avgCostBasis)) * 100 : 0.0;

    return Dismissible(
      key: ValueKey(position.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          onTap: onTap,
          title: Row(
            children: [
              Text(position.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (position.companyName.isNotEmpty) ...[
                const SizedBox(width: 8),
                Expanded(child: Text(position.companyName, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
              ],
            ],
          ),
          subtitle: Text('${position.shares} shares @ \$${position.avgCostBasis.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${(position.shares * position.currentPrice).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('\$${pnl.toStringAsFixed(2)} (${pnlPct.toStringAsFixed(2)}%)', style: TextStyle(color: gainLossColor(pnl), fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
