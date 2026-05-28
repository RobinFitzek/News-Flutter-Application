import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/database/app_database.dart';

class CorporateActionsScreen extends StatelessWidget {
  const CorporateActionsScreen({super.key, required this.actions});

  final List<CorporateActionData> actions;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) {
      return const Center(child: Text('No corporate actions found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final a = actions[index];
        final isDividend = a.type == 'dividend';
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isDividend ? Colors.green.shade100 : Colors.blue.shade100,
              child: Icon(isDividend ? Icons.monetization_on : Icons.call_split, color: isDividend ? Colors.green : Colors.blue),
            ),
            title: Text(a.type.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(DateFormat('MMM d, yyyy').format(a.date)),
            trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              if (a.amount != null) Text('\$${a.amount!.toStringAsFixed(a.type == 'dividend' ? 4 : 0)}', style: const TextStyle(fontWeight: FontWeight.w600)),
              if (a.description != null) Text(a.description!, style: const TextStyle(fontSize: 11)),
            ]),
          ),
        );
      },
    );
  }
}
