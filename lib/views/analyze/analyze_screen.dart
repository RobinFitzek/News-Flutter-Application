import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/analysis_viewmodel.dart';
import '../../config/theme.dart';

class AnalyzeScreen extends ConsumerStatefulWidget {
  const AnalyzeScreen({super.key, this.initialSymbol});

  final String? initialSymbol;

  @override
  ConsumerState<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends ConsumerState<AnalyzeScreen> {
  final _symbolController = TextEditingController();
  String _timeframe = 'daily';

  @override
  void initState() {
    super.initState();
    if (widget.initialSymbol != null) {
      _symbolController.text = widget.initialSymbol!;
    }
    Future.microtask(() {
      ref.read(analysisViewModelProvider.notifier).loadHistory();
      if (widget.initialSymbol != null) {
        _runAnalysis();
      }
    });
  }

  @override
  void dispose() {
    _symbolController.dispose();
    super.dispose();
  }

  void _runAnalysis() {
    final symbol = _symbolController.text.trim();
    if (symbol.isNotEmpty) {
      ref.read(analysisViewModelProvider.notifier).analyzeStock(
            symbol,
            timeframe: _timeframe,
          );
    }
  }

  Color _gainLossColor(BuildContext context, double change) {
    final colors = Theme.of(context).extension<StockColors>() ??
        const StockColors(gainColor: Colors.green, lossColor: Colors.red);
    return change >= 0 ? colors.gainColor : colors.lossColor;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(analysisViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Analyze'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnalysisInputCard(
              symbolController: _symbolController,
              timeframe: _timeframe,
              isAnalyzing: state.isAnalyzing,
              onTimeframeChanged: (v) => setState(() => _timeframe = v ?? 'daily'),
              onAnalyze: _runAnalysis,
            ),
            const SizedBox(height: 16),
            if (state.isAnalyzing)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('AI is analyzing...'),
                    ],
                  ),
                ),
              ),
            if (state.errorMessage != null && !state.isAnalyzing)
              Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: Theme.of(context).colorScheme.error),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.errorMessage!)),
                    ],
                  ),
                ),
              ),
            if (state.currentAnalysis != null && !state.isAnalyzing) ...[
              _AnalysisResultsCard(
                analysis: state.currentAnalysis!,
                gainLossColor: (c) => _gainLossColor(context, c),
              ),
            ],
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Research Tools'),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
              _ResearchToolChip(icon: Icons.person_search, label: 'Insider', onTap: () => context.push('/research/insider')),
              _ResearchToolChip(icon: Icons.water_drop, label: 'Dark Pool', onTap: () => context.push('/research/darkpool')),
              _ResearchToolChip(icon: Icons.public, label: 'Macro', onTap: () => context.push('/research/macro')),
              _ResearchToolChip(icon: Icons.compare_arrows, label: 'Pairs', onTap: () => context.push('/research/pairs')),
              _ResearchToolChip(icon: Icons.call_split, label: 'Options', onTap: () => context.push('/research/options')),
              _ResearchToolChip(icon: Icons.people, label: 'Institutions', onTap: () => context.push('/research/institutions')),
            ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Analysis History'),
            const SizedBox(height: 8),
            if (state.history.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('No previous analyses')),
                ),
              )
            else
              ...state.history.take(10).map((a) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _recommendationColor(a.recommendation),
                        child: Text(a.symbol,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      title: Text(a.symbol),
                      subtitle: Text(
                        '\$${a.predictedPrice.toStringAsFixed(2)} • ${a.recommendation}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(a.confidence * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => context.push('/analysis/${a.id}'),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Color _recommendationColor(String rec) {
    switch (rec) {
      case 'BUY':
        return Colors.green;
      case 'SELL':
        return Colors.red;
      default:
        return Colors.amber;
    }
  }
}

class _AnalysisInputCard extends StatelessWidget {
  const _AnalysisInputCard({
    required this.symbolController,
    required this.timeframe,
    required this.isAnalyzing,
    required this.onTimeframeChanged,
    required this.onAnalyze,
  });

  final TextEditingController symbolController;
  final String timeframe;
  final bool isAnalyzing;
  final Function(String?) onTimeframeChanged;
  final VoidCallback onAnalyze;

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
                Icon(Icons.psychology, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('New Analysis',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: symbolController,
              textCapitalization: TextCapitalization.characters,
              readOnly: isAnalyzing,
              decoration: const InputDecoration(
                labelText: 'Ticker Symbol',
                hintText: 'e.g. AAPL, TSLA',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: timeframe,
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
              onChanged: isAnalyzing ? null : onTimeframeChanged,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: symbolController.text.isNotEmpty && !isAnalyzing
                    ? onAnalyze
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

class _AnalysisResultsCard extends StatelessWidget {
  const _AnalysisResultsCard({
    required this.analysis,
    required this.gainLossColor,
  });

  final dynamic analysis;
  final Color Function(double change) gainLossColor;

  @override
  Widget build(BuildContext context) {
    final price = analysis.currentPrice as double;
    final predicted = analysis.predictedPrice as double;
    final change = predicted - price;
    final changePct = price != 0 ? (change / price) * 100 : 0.0;
    final isPositive = change >= 0;
    final color = gainLossColor(change);
    final confidence = (analysis.confidence as double).clamp(0.0, 1.0);
    final confidenceColor = confidence >= 0.7
        ? Colors.green
        : confidence >= 0.4
            ? Colors.amber
            : Colors.red;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Analysis Results',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${predicted.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: color, size: 18),
                      Text('${isPositive ? "+" : ""}${change.toStringAsFixed(2)} (${isPositive ? "+" : ""}${changePct.toStringAsFixed(2)}%)',
                          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Confidence: ${(confidence * 100).toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: confidence, color: confidenceColor, minHeight: 8),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: switch (analysis.recommendation) {
                      'BUY' => Colors.green,
                      'SELL' => Colors.red,
                      _ => Colors.amber,
                    }.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(analysis.recommendation,
                      style: TextStyle(
                        color: switch (analysis.recommendation) {
                          'BUY' => Colors.green.shade700,
                          'SELL' => Colors.red.shade700,
                          _ => Colors.amber.shade800,
                        },
                        fontWeight: FontWeight.bold,
                      )),
                ),
                if (analysis.timeframe != null) ...[
                  const SizedBox(width: 8),
                  Text(analysis.timeframe, style: const TextStyle(fontSize: 12)),
                ],
              ],
            ),
            const SizedBox(height: 16),
            _ExpandableTextCard(
              title: 'AI Reasoning',
              text: analysis.reasoning,
            ),
            if (analysis.newsSummary != null && analysis.newsSummary.isNotEmpty) ...[
              const SizedBox(height: 12),
              _ExpandableTextCard(
                title: 'News Summary',
                text: analysis.newsSummary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExpandableTextCard extends StatefulWidget {
  const _ExpandableTextCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  State<_ExpandableTextCard> createState() => _ExpandableTextCardState();
}

class _ExpandableTextCardState extends State<_ExpandableTextCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final displayText = _expanded ? widget.text : widget.text.length > 200
        ? '${widget.text.substring(0, 200)}...'
        : widget.text;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(displayText, style: const TextStyle(fontSize: 13)),
            if (widget.text.length > 200)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  child: Text(_expanded ? 'Show less' : 'Read more'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResearchToolChip extends StatelessWidget {
  const _ResearchToolChip({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
