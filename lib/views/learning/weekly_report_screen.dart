import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/repositories/analysis_repository.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../data/datasources/remote/provider_factory.dart';
import '../../models/stage_assignment.dart';
import '../../widgets/shimmer_loading.dart';

class ReportViewModel {
  final ProviderRepository providerRepo;
  final AnalysisRepository analysisRepo;
  final PortfolioRepository portfolioRepo;
  
  ReportViewModel({required this.providerRepo, required this.analysisRepo, required this.portfolioRepo});

  bool isLoading = false;
  String? report;
  String? error;

  Future<void> generate() async {
    isLoading = true;
    error = null;
    try {
      final provider = await providerRepo.getByStage(AnalysisStage.finalAnalysis);
      if (provider == null || provider.apiKey.isEmpty) {
        error = 'No analysis provider configured. Set one in Settings.';
        isLoading = false;
        return;
      }

      final analyses = await analysisRepo.getAll();
      final positions = await portfolioRepo.getAllPositions();
      final summary = await portfolioRepo.getSummary();

      final context = '''
Recent Analyses: ${analyses.length} total
Top recommendations: ${analyses.take(3).map((a) => '${a.symbol}: ${a.recommendation} (\$${a.predictedPrice.toStringAsFixed(2)}, ${(a.confidence*100).toStringAsFixed(1)}% confidence)').join('\n')}
Portfolio: ${positions.length} positions, Total Value \$${summary.totalMarketValue.toStringAsFixed(2)}, P&L \$${summary.totalUnrealizedPnl.toStringAsFixed(2)}
''';

      final client = ProviderFactory.createFromData(provider);
      report = await client.generateText(
        'Generate a weekly investment report based on the following data. Write in a professional tone, 4-5 paragraphs.\n\n$context\n\n'
        'Include: 1) Market overview, 2) Portfolio performance summary, 3) Top AI recommendations, 4) Key risks to watch, 5) Action items for next week.'
      );
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
  }
}

class WeeklyReportScreen extends ConsumerStatefulWidget {
  const WeeklyReportScreen({super.key});

  @override
  ConsumerState<WeeklyReportScreen> createState() => _WeeklyReportScreenState();
}

class _WeeklyReportScreenState extends ConsumerState<WeeklyReportScreen> {
  ReportViewModel? _vm;
  bool _generated = false;

  @override
  void initState() {
    super.initState();
    _vm = ReportViewModel(
      providerRepo: ref.read(providerRepositoryProvider),
      analysisRepo: ref.read(analysisRepositoryProvider),
      portfolioRepo: ref.read(portfolioRepositoryProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = _vm!;
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Report'), actions: [
        if (vm.report != null) IconButton(icon: const Icon(Icons.share), onPressed: () {
          // Share placeholder
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report ready to share')));
        }),
      ]),
      body: vm.isLoading
        ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Generating report...')]))
        : vm.report != null
          ? SingleChildScrollView(padding: const EdgeInsets.all(16), child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Weekly Investment Report', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(DateTime.now().toString().substring(0, 10), style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            Text(vm.report!, style: const TextStyle(fontSize: 14, height: 1.6)),
          ]))))
          : Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.description, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('Weekly Report', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (vm.error != null) Text(vm.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 16),
            ElevatedButton.icon(onPressed: () async { await vm.generate(); if (mounted) setState(() => _generated = true); }, icon: const Icon(Icons.auto_awesome), label: const Text('Generate Report')),
          ])),
      floatingActionButton: vm.report != null ? FloatingActionButton(onPressed: () async { await vm.generate(); if (mounted) setState(() {}); }, child: const Icon(Icons.refresh)) : null,
    );
  }
}
