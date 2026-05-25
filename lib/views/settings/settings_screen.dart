import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../viewmodels/provider_viewmodel.dart';
import '../../models/stage_assignment.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _geminiController = TextEditingController();
  final _perplexityController = TextEditingController();
  String? _themeMode;

  static const Map<String, Color> _typeColors = {
    'gemini': Colors.blue,
    'openai': Colors.green,
    'claude': Colors.orange,
    'perplexity': Colors.purple,
    'ollama': Colors.brown,
    'custom': Colors.grey,
  };

  static const Map<String, String> _typeLabels = {
    'gemini': 'Gemini',
    'openai': 'OpenAI',
    'claude': 'Claude',
    'perplexity': 'Perplexity',
    'ollama': 'Ollama',
    'custom': 'Custom',
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
    Future.microtask(() {
      ref.read(providerViewModelProvider.notifier).loadProviders();
    });
  }

  Future<void> _loadSettings() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final geminiKey = await settingsRepo.getGeminiKey();
    final perplexityKey = await settingsRepo.getPerplexityKey();
    final themeMode = await settingsRepo.getThemeMode();

    setState(() {
      _geminiController.text = geminiKey ?? '';
      _perplexityController.text = perplexityKey ?? '';
      _themeMode = themeMode ?? 'system';
    });
  }

  @override
  void dispose() {
    _geminiController.dispose();
    _perplexityController.dispose();
    super.dispose();
  }

  Future<void> _showProviderDialog({AiProviderData? provider}) async {
    final isEditing = provider != null;
    final nameController =
        TextEditingController(text: provider?.name ?? '');
    final baseUrlController =
        TextEditingController(text: provider?.baseUrl ?? '');
    final apiKeyController =
        TextEditingController(text: provider?.apiKey ?? '');
    final modelController =
        TextEditingController(text: provider?.model ?? '');
    String type = provider?.type ?? 'gemini';

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            title: Text(isEditing ? 'Edit Provider' : 'Add Provider'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: type,
                    decoration: const InputDecoration(
                      labelText: 'Provider Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'gemini', child: Text('Gemini')),
                      DropdownMenuItem(value: 'openai', child: Text('OpenAI')),
                      DropdownMenuItem(value: 'claude', child: Text('Claude')),
                      DropdownMenuItem(value: 'perplexity', child: Text('Perplexity')),
                      DropdownMenuItem(value: 'custom', child: Text('Custom')),
                      DropdownMenuItem(value: 'ollama', child: Text('Ollama')),
                    ],
                    onChanged: isEditing
                        ? null
                        : (value) {
                            if (value != null) setDialogState(() => type = value);
                          },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: baseUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Base URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: apiKeyController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'API Key',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: modelController,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );

    if (result == true) {
      final vm = ref.read(providerViewModelProvider.notifier);
      if (provider != null) {
        await vm.saveProvider(
          provider.copyWith(
            name: nameController.text,
            type: type,
            baseUrl: baseUrlController.text,
            apiKey: apiKeyController.text,
            model: modelController.text,
          ),
        );
      } else {
        final newProvider = AiProviderData(
          id: 0,
          name: nameController.text,
          type: type,
          baseUrl: baseUrlController.text,
          apiKey: apiKeyController.text,
          model: modelController.text,
          isEnabled: true,
          isConnected: false,
          totalCalls: 0,
          totalCost: 0.0,
          createdAt: DateTime.now(),
        );
        await vm.saveProvider(newProvider);
      }
    }
  }

  Future<void> _confirmDelete(AiProviderData provider) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Provider'),
        content: Text('Delete "${provider.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && provider.id > 0) {
      ref.read(providerViewModelProvider.notifier).deleteProvider(provider.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerState = ref.watch(providerViewModelProvider);
    final providers = providerState.providers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('API Keys'),
          const SizedBox(height: 8),
          TextField(
            controller: _geminiController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Gemini API Key',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.vpn_key),
            ),
            onChanged: (value) {
              ref.read(settingsRepositoryProvider).setGeminiKey(value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _perplexityController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Perplexity API Key',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.vpn_key),
            ),
            onChanged: (value) {
              ref.read(settingsRepositoryProvider).setPerplexityKey(value);
            },
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Appearance'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            key: ValueKey(_themeMode),
            initialValue: _themeMode ?? 'system',
            decoration: const InputDecoration(
              labelText: 'Theme',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.palette),
            ),
            items: const [
              DropdownMenuItem(value: 'system', child: Text('System')),
              DropdownMenuItem(value: 'light', child: Text('Light')),
              DropdownMenuItem(value: 'dark', child: Text('Dark')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _themeMode = value);
                ref.read(settingsRepositoryProvider).setThemeMode(value);
              }
            },
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('AI Providers'),
          if (providerState.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                providerState.errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 8),
          if (providers.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('No providers configured'),
            )
          else
            ...providers.map((p) => _ProviderCard(
                  provider: p,
                  isTesting: providerState.testingProviderId == p.id,
                  typeColor: _typeColors[p.type] ?? Colors.grey,
                  typeLabel: _typeLabels[p.type] ?? p.type,
                  onTest: () {
                    if (p.id > 0) {
                      ref
                          .read(providerViewModelProvider.notifier)
                          .testProvider(p.id);
                    }
                  },
                  onEdit: () => _showProviderDialog(provider: p),
                  onDelete: () => _confirmDelete(p),
                  onToggleEnabled: (enabled) {
                    ref
                        .read(providerViewModelProvider.notifier)
                        .saveProvider(p.copyWith(isEnabled: enabled));
                  },
                )),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _showProviderDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Add Provider'),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Stage Assignments'),
          const SizedBox(height: 8),
          _StageAssignmentsCard(providers: providers),
          const SizedBox(height: 24),
          _buildSectionHeader('About'),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Stock Prediction',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Intelligent stock market predictions powered by AI',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  const _ProviderCard({
    required this.provider,
    required this.isTesting,
    required this.typeColor,
    required this.typeLabel,
    required this.onTest,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleEnabled,
  });

  final AiProviderData provider;
  final bool isTesting;
  final Color typeColor;
  final String typeLabel;
  final VoidCallback onTest;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool) onToggleEnabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    provider.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    typeLabel,
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              provider.model,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: provider.isConnected ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  provider.isConnected ? 'Connected' : 'Not tested',
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                if (isTesting)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  TextButton(
                    onPressed: onTest,
                    child: const Text('Test'),
                  ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, size: 18,
                      color: Theme.of(context).colorScheme.error),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const Divider(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enabled', style: TextStyle(fontSize: 13)),
                Switch(
                  value: provider.isEnabled,
                  onChanged: onToggleEnabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StageAssignmentsCard extends ConsumerStatefulWidget {
  const _StageAssignmentsCard({required this.providers});

  final List<AiProviderData> providers;

  @override
  ConsumerState<_StageAssignmentsCard> createState() =>
      _StageAssignmentsCardState();
}

class _StageAssignmentsCardState extends ConsumerState<_StageAssignmentsCard> {
  String? _newsResearchId;
  String? _finalAnalysisId;

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    final repo = ref.read(providerRepositoryProvider);
    final news = await repo.getByStage(AnalysisStage.newsResearch);
    final analysis = await repo.getByStage(AnalysisStage.finalAnalysis);
    setState(() {
      _newsResearchId = news?.id.toString();
      _finalAnalysisId = analysis?.id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.providers
        .where((p) => p.isEnabled == true)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'News Research',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: _newsResearchId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('None')),
                ...enabled.map((p) => DropdownMenuItem(
                      value: p.id.toString(),
                      child: Text('${p.name} (${p.model})'),
                    )),
              ],
              onChanged: (value) => setState(() => _newsResearchId = value),
            ),
            const SizedBox(height: 16),
            Text(
              'Final Analysis',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: _finalAnalysisId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('None')),
                ...enabled.map((p) => DropdownMenuItem(
                      value: p.id.toString(),
                      child: Text('${p.name} (${p.model})'),
                    )),
              ],
              onChanged: (value) => setState(() => _finalAnalysisId = value),
            ),
            const SizedBox(height: 12),
            Text(
              'News Research gathers current information. Final Analysis generates predictions.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final vm = ref.read(providerViewModelProvider.notifier);
                  if (_newsResearchId != null) {
                    await vm.setStage(
                      AnalysisStage.newsResearch,
                      int.parse(_newsResearchId!),
                    );
                  }
                  if (_finalAnalysisId != null) {
                    await vm.setStage(
                      AnalysisStage.finalAnalysis,
                      int.parse(_finalAnalysisId!),
                    );
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Stage assignments saved')),
                    );
                  }
                },
                child: const Text('Save Assignments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
