import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/journal_viewmodel.dart';
import '../../data/database/app_database.dart';
import '../../config/theme.dart';

class JournalTab extends ConsumerStatefulWidget {
  const JournalTab({super.key});

  @override
  ConsumerState<JournalTab> createState() => _JournalTabState();
}

class _JournalTabState extends ConsumerState<JournalTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(journalViewModelProvider.notifier).loadEntries());
  }

  Future<void> _showAddDialog() async {
    final symbolCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final sharesCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    String type = 'BUY';

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (ctx, setDlg) => AlertDialog(
        title: const Text('New Journal Entry'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: symbolCtrl, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: type,
              decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
              items: const [DropdownMenuItem(value: 'BUY', child: Text('BUY')), DropdownMenuItem(value: 'SELL', child: Text('SELL'))],
              onChanged: (v) => setDlg(() => type = v ?? 'BUY'),
            ),
            const SizedBox(height: 12),
            TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Entry Price', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: sharesCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Shares', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: notesCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder())),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      )),
    );

    if (result == true && symbolCtrl.text.isNotEmpty) {
      final price = double.tryParse(priceCtrl.text) ?? 0;
      final shares = double.tryParse(sharesCtrl.text);
      ref.read(journalViewModelProvider.notifier).addEntry(JournalEntryData(
        id: 0, symbol: symbolCtrl.text.toUpperCase(), type: type,
        entryPrice: price, shares: shares, entryDate: DateTime.now(),
        notes: notesCtrl.text, isClosed: false, mood: '', tags: '', createdAt: DateTime.now(),
      ));
    }
  }

  Future<void> _showCloseDialog(JournalEntryData entry) async {
    final priceCtrl = TextEditingController();
    final pnlCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Close Position'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Exit Price', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: pnlCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'P&L (\$)', border: OutlineInputBorder())),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(onPressed: () {
            final exitPrice = double.tryParse(priceCtrl.text) ?? 0;
            final pnl = double.tryParse(pnlCtrl.text) ?? 0;
            ref.read(journalViewModelProvider.notifier).closeEntry(entry.id, exitPrice: exitPrice, exitDate: DateTime.now(), pnl: pnl);
            Navigator.pop(ctx);
          }, child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(journalViewModelProvider);

    return Stack(
      children: [
        if (state.entries.isEmpty)
          Center(
            child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.book, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text('No journal entries', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Track your trades and lessons learned'),
              const SizedBox(height: 16),
              ElevatedButton.icon(onPressed: _showAddDialog, icon: const Icon(Icons.add), label: const Text('New Entry')),
            ])),
          )
        else
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.entries.length,
            itemBuilder: (context, index) {
              final e = state.entries[index];
              final pnlColor = (e.pnl ?? 0) >= 0 ? Colors.green : Colors.red;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        Text(e.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: e.type == 'BUY' ? Colors.green.withAlpha(30) : Colors.red.withAlpha(30), borderRadius: BorderRadius.circular(4)), child: Text(e.type, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: e.type == 'BUY' ? Colors.green : Colors.red))),
                      ]),
                      if (e.isClosed)
                        Text('\$${(e.pnl ?? 0).toStringAsFixed(2)}', style: TextStyle(color: pnlColor, fontWeight: FontWeight.bold))
                      else
                        TextButton(onPressed: () => _showCloseDialog(e), child: const Text('Close')),
                    ]),
                    const SizedBox(height: 4),
                    Text('\$${e.entryPrice.toStringAsFixed(2)} ${e.shares != null ? '• ${e.shares!.toStringAsFixed(0)} shares' : ''}', style: const TextStyle(fontSize: 13)),
                    if (e.notes.isNotEmpty) ...[const SizedBox(height: 4), Text(e.notes, style: const TextStyle(fontSize: 13), maxLines: 3, overflow: TextOverflow.ellipsis)],
                    const SizedBox(height: 4),
                    Row(children: [
                      Text(DateFormat('MMM d, yyyy').format(e.entryDate), style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      if (e.isClosed) Text(' → ${DateFormat('MMM d').format(e.exitDate!)}', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () => ref.read(journalViewModelProvider.notifier).deleteEntry(e.id), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                    ]),
                  ]),
                ),
              );
            },
          ),
        Positioned(bottom: 16, right: 16, child: FloatingActionButton(onPressed: _showAddDialog, child: const Icon(Icons.add))),
      ],
    );
  }
}
