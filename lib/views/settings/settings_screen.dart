import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../viewmodels/provider_viewmodel.dart';
import '../../models/stage_assignment.dart';
import '../../data/datasources/remote/provider_factory.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _geminiCtrl = TextEditingController();
  final _perplexityCtrl = TextEditingController();
  String? _themeMode;
  bool _biometricEnabled = false;

  static const _typeColors = {'gemini': Colors.blue, 'openai': Colors.green, 'claude': Colors.orange, 'perplexity': Colors.purple, 'ollama': Colors.brown, 'custom': Colors.grey};
  static const _typeLabels = {'gemini': 'Gemini', 'openai': 'OpenAI', 'claude': 'Claude', 'perplexity': 'Perplexity', 'ollama': 'Ollama', 'custom': 'Custom'};

  @override
  void initState() {
    super.initState();
    _load();
    Future.microtask(() => ref.read(providerViewModelProvider.notifier).loadProviders());
  }

  Future<void> _load() async {
    final s = ref.read(settingsRepositoryProvider);
    final a = ref.read(authRepositoryProvider);
    final gemini = await s.getGeminiKey();
    final perplexity = await s.getPerplexityKey();
    final tm = await s.getThemeMode();
    final bio = await a.isBiometricEnabled();
    if (mounted) setState(() {
      _geminiCtrl.text = gemini ?? '';
      _perplexityCtrl.text = perplexity ?? '';
      _themeMode = tm ?? 'system';
      _biometricEnabled = bio;
    });
  }

  @override
  void dispose() { _geminiCtrl.dispose(); _perplexityCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final providerState = ref.watch(providerViewModelProvider);
    final providers = providerState.providers;
    final isTesting = providerState.testingProviderId;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _SectionCard(title: 'Appearance', icon: Icons.palette, children: [
          if (_themeMode != null) DropdownButtonFormField<String>(
            initialValue: _themeMode,
            decoration: const InputDecoration(labelText: 'Theme', border: OutlineInputBorder()),
            items: const [DropdownMenuItem(value: 'system', child: Text('System')), DropdownMenuItem(value: 'light', child: Text('Light')), DropdownMenuItem(value: 'dark', child: Text('Dark'))],
            onChanged: (v) { if (v != null) { setState(() => _themeMode = v); ref.read(settingsRepositoryProvider).setThemeMode(v); } },
          ),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'Security', icon: Icons.lock, children: [
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Biometric Lock'), subtitle: const Text('Require fingerprint/face to open'), value: _biometricEnabled, onChanged: (v) async { await ref.read(authRepositoryProvider).setBiometricEnabled(v); setState(() => _biometricEnabled = v); }),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'AI Providers', icon: Icons.psychology, children: [
          ...providers.map((p) => Card(margin: const EdgeInsets.only(bottom: 8), child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: (_typeColors[p.type] ?? Colors.grey).withAlpha(30), borderRadius: BorderRadius.circular(4)), child: Text(_typeLabels[p.type] ?? p.type, style: TextStyle(color: _typeColors[p.type], fontWeight: FontWeight.bold, fontSize: 11))),
              const SizedBox(width: 8), Expanded(child: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold))),
              Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: p.isConnected ? Colors.green : Colors.grey)),
            ]),
            const SizedBox(height: 4), Text(p.model, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Row(children: [
              _ActionChip(Icons.wifi, 'Test', isTesting == p.id, () => ref.read(providerViewModelProvider.notifier).testProvider(p.id)),
              const SizedBox(width: 4),
              _ActionChip(Icons.edit, 'Edit', false, () => _editProvider(p)),
              const SizedBox(width: 4),
              _ActionChip(Icons.delete, 'Del', false, () => ref.read(providerViewModelProvider.notifier).deleteProvider(p.id)),
              const Spacer(),
              Switch(value: p.isEnabled, onChanged: (v) { ref.read(providerViewModelProvider.notifier).saveProvider(p.copyWith(isEnabled: v)); }),
            ]),
          ])))),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => _editProvider(null), icon: const Icon(Icons.add), label: const Text('Add Provider'))),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'Analysis Stages', icon: Icons.account_tree, children: [
          _StageRow('News Research', AnalysisStage.newsResearch, providers),
          _StageRow('Final Analysis', AnalysisStage.finalAnalysis, providers),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'Quick Links', icon: Icons.link, children: [
          ListTile(leading: const Icon(Icons.calendar_today), title: const Text('Economic Calendar'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/research/calendar')),
          ListTile(leading: const Icon(Icons.public), title: const Text('Geopolitical Scan'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/research/geo')),
          ListTile(leading: const Icon(Icons.description), title: const Text('Weekly Report'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/report')),
          ListTile(leading: const Icon(Icons.compare), title: const Text('Stock Comparison'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/compare')),
          ListTile(leading: const Icon(Icons.notifications), title: const Text('Price Alerts'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/alerts')),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'About', icon: Icons.info, children: [
          ListTile(title: const Text('AI Stock Prediction'), subtitle: const Text('Version 1.0.0'), trailing: Text('${DateTime.now().year}', style: const TextStyle(color: Colors.grey))),
        ]),
      ]),
    );
  }

  Widget _StageRow(String label, AnalysisStage stage, List<AiProviderData> providers) {
    final enabled = providers.where((p) => p.isEnabled).toList();
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
      SizedBox(width: 130, child: Text(label, style: const TextStyle(fontSize: 13))),
      Expanded(child: DropdownButtonFormField<int?>(
        value: null,
        decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
        hint: const Text('Select'),
        items: enabled.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name, style: const TextStyle(fontSize: 13)))).toList(),
        onChanged: (id) { if (id != null) ref.read(providerViewModelProvider.notifier).setStage(stage, id); },
      )),
    ]));
  }

  Widget _ActionChip(IconData icon, String label, bool isActive, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Padding(padding: const EdgeInsets.all(6), child: isActive ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary)),
  );

  void _editProvider(AiProviderData? existing) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final urlCtrl = TextEditingController(text: existing?.baseUrl ?? '');
    final keyCtrl = TextEditingController(text: existing?.apiKey ?? '');
    final modelCtrl = TextEditingController(text: existing?.model ?? '');
    String type = existing?.type ?? 'gemini';

    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, setDlg) => AlertDialog(
      title: Text(existing != null ? 'Edit Provider' : 'Add Provider'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (existing == null) DropdownButtonFormField<String>(value: type, decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()), items: const [
          DropdownMenuItem(value: 'gemini', child: Text('Gemini')), DropdownMenuItem(value: 'openai', child: Text('OpenAI')), DropdownMenuItem(value: 'claude', child: Text('Claude')), DropdownMenuItem(value: 'perplexity', child: Text('Perplexity')), DropdownMenuItem(value: 'ollama', child: Text('Ollama')), DropdownMenuItem(value: 'custom', child: Text('Custom')),
        ], onChanged: (v) { if (v != null) { setDlg(() => type = v); urlCtrl.text = _defaultUrl(v); modelCtrl.text = _defaultModel(v); }}),
        const SizedBox(height: 12), TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder())),
        const SizedBox(height: 12), TextField(controller: urlCtrl, decoration: const InputDecoration(labelText: 'Base URL', border: OutlineInputBorder())),
        const SizedBox(height: 12), TextField(controller: keyCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'API Key', border: OutlineInputBorder())),
        const SizedBox(height: 12), TextField(controller: modelCtrl, decoration: const InputDecoration(labelText: 'Model', border: OutlineInputBorder())),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')), ElevatedButton(onPressed: () { ref.read(providerViewModelProvider.notifier).saveProvider(AiProviderData(id: existing?.id ?? 0, name: nameCtrl.text, type: type, baseUrl: urlCtrl.text, apiKey: keyCtrl.text, model: modelCtrl.text, isEnabled: existing?.isEnabled ?? true, isConnected: existing?.isConnected ?? false, totalCalls: existing?.totalCalls ?? 0, totalCost: existing?.totalCost ?? 0, lastTestedAt: existing?.lastTestedAt, createdAt: existing?.createdAt ?? DateTime.now())); Navigator.pop(ctx); }, child: const Text('Save'))],
    )));
  }

  String _defaultUrl(String type) => switch (type) { 'gemini' => 'https://generativelanguage.googleapis.com/v1beta', 'openai' => 'https://api.openai.com/v1', 'claude' => 'https://api.anthropic.com/v1', 'perplexity' => 'https://api.perplexity.ai', 'ollama' => 'http://localhost:11434', _ => '' };
  String _defaultModel(String type) => switch (type) { 'gemini' => 'gemini-2.0-flash', 'openai' => 'gpt-4o', 'claude' => 'claude-3-5-sonnet-20241022', 'perplexity' => 'sonar-pro', 'ollama' => 'llama3', _ => '' };
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 8), Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))]),
    const SizedBox(height: 12),
    ...children,
  ])));
}
