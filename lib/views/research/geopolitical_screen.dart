import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/provider_factory.dart';
import '../../data/repositories/provider_repository.dart';
import '../../models/stage_assignment.dart';
import '../../widgets/shimmer_loading.dart';

class GeopoliticalViewModel {
  final ProviderRepository providerRepo;
  GeopoliticalViewModel({required this.providerRepo});

  bool isLoading = false;
  String? analysis;
  String? error;

  Future<void> scan() async {
    isLoading = true;
    error = null;
    try {
      final provider = await providerRepo.getByStage(AnalysisStage.newsResearch);
      if (provider == null || provider.apiKey.isEmpty) {
        error = 'No news research provider configured. Set one in Settings.';
        isLoading = false;
        return;
      }

      final client = ProviderFactory.createFromData(provider);
      analysis = await client.generateText(
        'Provide a brief geopolitical risk assessment for global stock markets today. '
        'Cover: 1) Major geopolitical events affecting markets, 2) Trade/tariff developments, '
        '3) Central bank policy outlook, 4) Regional hotspots. '
        'Keep it concise — 3-4 short paragraphs total.'
      );
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
  }
}

class GeopoliticalScreen extends ConsumerStatefulWidget {
  const GeopoliticalScreen({super.key});

  @override
  ConsumerState<GeopoliticalScreen> createState() => _GeopoliticalScreenState();
}

class _GeopoliticalScreenState extends ConsumerState<GeopoliticalScreen> {
  GeopoliticalViewModel? _vm;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _vm = GeopoliticalViewModel(providerRepo: ref.read(providerRepositoryProvider));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Geopolitical Risk')),
      body: _vm == null ? const ShimmerLoading(count: 2) : 
        _vm!.analysis != null
          ? SingleChildScrollView(padding: const EdgeInsets.all(16), child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Risk Assessment', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(_vm!.analysis!, style: const TextStyle(fontSize: 14, height: 1.5)),
          ]))))
          : _vm!.isLoading
            ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Scanning geopolitical risks...')]))
            : Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.public, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text('Geopolitical Risk Scanner', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (_vm!.error != null) Text(_vm!.error!, style: TextStyle(color: Theme.of(context).colorScheme.error), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton.icon(onPressed: () async { await _vm!.scan(); if (mounted) setState(() => _loaded = true); }, icon: const Icon(Icons.search), label: const Text('Scan Now')),
            ])),
      floatingActionButton: _vm?.analysis != null ? FloatingActionButton(onPressed: () async { await _vm!.scan(); if (mounted) setState(() {}); }, child: const Icon(Icons.refresh)) : null,
    );
  }
}
