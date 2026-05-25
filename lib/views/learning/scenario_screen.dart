import 'package:flutter/material.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scenario Analysis')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Stress Test Scenarios', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _scenarioCard(context, 'Market Crash', '-30% equity, VIX > 40', Colors.red),
          _scenarioCard(context, 'Recession', '-15% equity, rates cut', Colors.orange),
          _scenarioCard(context, 'Stagflation', '-10% equity, flat growth', Colors.amber),
          _scenarioCard(context, 'Tech Bubble', '-25% tech, -10% market', Colors.purple),
          _scenarioCard(context, 'Bull Rally', '+20% equity, low vol', Colors.green),
          const SizedBox(height: 8),
          const Text('This feature will compute portfolio impact under each scenario in a future update.', style: TextStyle(fontSize: 12)),
        ]))),
      ]),
    );
  }

  Widget _scenarioCard(BuildContext context, String title, String desc, Color color) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Icon(Icons.warning_amber, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(desc),
    ),
  );
}
