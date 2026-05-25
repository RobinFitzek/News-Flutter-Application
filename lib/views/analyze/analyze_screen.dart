import 'package:flutter/material.dart';

class AnalyzeScreen extends StatelessWidget {
  const AnalyzeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Analyze'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnalysisInputCard(),
            _buildSectionHeader(context, 'Research Tools'),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _ResearchToolChip(
                    icon: Icons.person_search,
                    label: 'Insider',
                  ),
                  _ResearchToolChip(
                    icon: Icons.water_drop,
                    label: 'Dark Pool',
                  ),
                  _ResearchToolChip(
                    icon: Icons.public,
                    label: 'Macro',
                  ),
                  _ResearchToolChip(
                    icon: Icons.compare_arrows,
                    label: 'Pairs',
                  ),
                  _ResearchToolChip(
                    icon: Icons.call_split,
                    label: 'Options',
                  ),
                  _ResearchToolChip(
                    icon: Icons.people,
                    label: 'Institutions',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _AnalysisInputCard extends StatefulWidget {
  @override
  State<_AnalysisInputCard> createState() => _AnalysisInputCardState();
}

class _AnalysisInputCardState extends State<_AnalysisInputCard> {
  final _symbolController = TextEditingController();
  String _timeframe = 'daily';

  @override
  void dispose() {
    _symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.psychology,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'New Analysis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _symbolController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Ticker Symbol',
                hintText: 'e.g. AAPL, TSLA',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _timeframe,
              decoration: const InputDecoration(
                labelText: 'Timeframe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              items: const [
                DropdownMenuItem(value: 'daily', child: Text('Daily')),
                DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _timeframe = value);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _symbolController.text.isNotEmpty
                    ? () {
                        // Placeholder — analysis viewmodel call in Part 3
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Analysis — coming in Phase 3'),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.analytics),
                label: const Text('Analyze'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResearchToolChip extends StatelessWidget {
  const _ResearchToolChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: null,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
