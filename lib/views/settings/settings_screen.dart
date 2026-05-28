import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_settings_store.dart';
import '../../data/database/app_database.dart';
import '../../data/datasources/local/database_datasource.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../viewmodels/provider_viewmodel.dart';
import '../../models/stage_assignment.dart';
import '../../data/datasources/remote/provider_factory.dart';
import '../../engine/pipeline_gate.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _geminiCtrl = TextEditingController();
  final _perplexityCtrl = TextEditingController();
  final _pplxBudgetCtrl = TextEditingController();
  final _geminiBudgetCtrl = TextEditingController();
  String? _themeMode;
  bool _biometricEnabled = false;
  int _scanIntervalHours = 4;
  int _activeStart = 7;
  int _activeEnd = 22;
  bool _activeHoursEnabled = true;
  bool _skipHolidays = true;
  bool _killSwitchActive = false;
  bool _notificationsEnabled = true;

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
    final db = ref.read(databaseProvider);
    final store = AppSettingsStore(db);

    final gemini = await s.getGeminiKey();
    final perplexity = await s.getPerplexityKey();
    final tm = await s.getThemeMode();
    final bio = await a.isBiometricEnabled();
    final scanH = await store.getInt('scan_interval_hours', 4);
    final activeStart = await store.getInt('active_hours_start', 7);
    final activeEnd = await store.getInt('active_hours_end', 22);
    final activeEnabled = await store.getBool('active_hours_enabled', defaultValue: true);
    final skipHol = await store.getBool('skip_us_holidays', defaultValue: true);
    final kill = await store.getBool('system_paused_accuracy');
    final notif = await store.getBool('notifications_enabled', defaultValue: true);
    final pplxB = await store.get('perplexity_monthly_budget') ?? '5';
    final gemB = await store.get('gemini_monthly_budget') ?? '5';

    if (mounted) setState(() {
      _geminiCtrl.text = gemini ?? '';
      _perplexityCtrl.text = perplexity ?? '';
      _themeMode = tm ?? 'system';
      _biometricEnabled = bio;
      _scanIntervalHours = scanH;
      _activeStart = activeStart;
      _activeEnd = activeEnd;
      _activeHoursEnabled = activeEnabled;
      _skipHolidays = skipHol;
      _killSwitchActive = kill;
      _notificationsEnabled = notif;
      _pplxBudgetCtrl.text = pplxB;
      _geminiBudgetCtrl.text = gemB;
    });
  }

  Future<void> _saveAppSetting(String key, String value) async {
    await AppSettingsStore(ref.read(databaseProvider)).set(key, value);
  }

  Future<void> _clearKillSwitch() async {
    await PipelineGate(ref.read(databaseProvider)).clearAccuracyKillSwitch();
    setState(() => _killSwitchActive = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Accuracy kill switch cleared')),
      );
    }
  }

  @override
  void dispose() { _geminiCtrl.dispose(); _perplexityCtrl.dispose(); _pplxBudgetCtrl.dispose(); _geminiBudgetCtrl.dispose(); super.dispose(); }

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
        _SectionCard(title: 'Pipeline & Scheduler', icon: Icons.schedule, children: [
          ListTile(contentPadding: EdgeInsets.zero, title: Text('Scan interval: $_scanIntervalHours h'),
            subtitle: Slider(min: 1, max: 12, divisions: 11, value: _scanIntervalHours.toDouble(), label: '$_scanIntervalHours h', onChanged: (v) { setState(() => _scanIntervalHours = v.round()); _saveAppSetting('scan_interval_hours', v.round().toString()); })),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Active Hours Gate'), value: _activeHoursEnabled, onChanged: (v) { setState(() => _activeHoursEnabled = v); AppSettingsStore(ref.read(databaseProvider)).setBool('active_hours_enabled', v); }),
          if (_activeHoursEnabled) ListTile(contentPadding: EdgeInsets.zero, title: Text('Active: $_activeStart:00 – $_activeEnd:00'), subtitle: Row(children: [
            Expanded(child: Slider(min: 0, max: 23, divisions: 23, value: _activeStart.toDouble(), onChanged: (v) { setState(() => _activeStart = v.round()); _saveAppSetting('active_hours_start', v.round().toString()); })),
            Expanded(child: Slider(min: 1, max: 24, divisions: 23, value: _activeEnd.toDouble(), onChanged: (v) { setState(() => _activeEnd = v.round()); _saveAppSetting('active_hours_end', v.round().toString()); })),
          ])),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Skip US Market Holidays'), value: _skipHolidays, onChanged: (v) { setState(() => _skipHolidays = v); AppSettingsStore(ref.read(databaseProvider)).setBool('skip_us_holidays', v); }),
          if (_killSwitchActive) ListTile(contentPadding: EdgeInsets.zero, title: const Text('Accuracy Kill Switch ACTIVE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), trailing: ElevatedButton(onPressed: _clearKillSwitch, child: const Text('Clear'))),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'API Budgets (EUR/month)', icon: Icons.euro, children: [
          TextField(controller: _pplxBudgetCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Perplexity Budget', border: OutlineInputBorder()), onSubmitted: (v) => _saveAppSetting('perplexity_monthly_budget', v)),
          const SizedBox(height: 8),
          TextField(controller: _geminiBudgetCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Gemini Budget', border: OutlineInputBorder()), onSubmitted: (v) => _saveAppSetting('gemini_monthly_budget', v)),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'Notifications', icon: Icons.notifications, children: [
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Local Alerts'), subtitle: const Text('Price, geo, signal, portfolio alerts'), value: _notificationsEnabled, onChanged: (v) { setState(() => _notificationsEnabled = v); AppSettingsStore(ref.read(databaseProvider)).setBool('notifications_enabled', v); }),
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
          ListTile(leading: const Icon(Icons.star), title: const Text('Top Picks'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/top-picks')),
          ListTile(leading: const Icon(Icons.verified), title: const Text('Trust Page'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/trust')),
          ListTile(leading: const Icon(Icons.delete_forever), title: const Text('Graveyard'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/graveyard')),
          ListTile(leading: const Icon(Icons.account_balance), title: const Text('Politician Trades'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/research/politician')),
          ListTile(leading: const Icon(Icons.grid_view), title: const Text('Sector Screen'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/research/sector-screen')),
          ListTile(leading: const Icon(Icons.calendar_today), title: const Text('Economic Calendar'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/research/calendar')),
          ListTile(leading: const Icon(Icons.public), title: const Text('Geopolitical Scan'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/research/geo')),
          ListTile(leading: const Icon(Icons.description), title: const Text('Weekly Report'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/report')),
          ListTile(leading: const Icon(Icons.compare), title: const Text('Stock Comparison'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/compare')),
          ListTile(leading: const Icon(Icons.notifications), title: const Text('Price Alerts'), trailing: const Icon(Icons.chevron_right), onTap: () => context.push('/alerts')),
        ]),
        const SizedBox(height: 12),
        _SectionCard(title: 'About', icon: Icons.info, children: [
          ListTile(title: const Text('Stockholm Mobile'), subtitle: const Text('Version 1.1.0 — Full parity port'), trailing: Text('${DateTime.now().year}', style: const TextStyle(color: Colors.grey))),
          ListTile(
            leading: const Icon(Icons.replay),
            title: const Text('Show intro again'),
            onTap: () async {
              await ref.read(onboardingRepositoryProvider).reset();
              if (context.mounted) context.go('/onboarding');
            },
          ),
        ]),
      ]),
    );
  }

  Widget _StageRow(String label, AnalysisStage stage, List<AiProviderData> providers) {
    final enabled = providers.where((p) => p.isEnabled).toList();
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
      SizedBox(width: 130, child: Text(label, style: const TextStyle(fontSize: 13))),
      Expanded(child: DropdownButton<int>(
        isExpanded: true,
        value: null,
        hint: const Text('Select provider'),
        items: enabled.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
        onChanged: (id) { if (id != null) ref.read(providerViewModelProvider.notifier).setStage(stage, id); },
      )),
    ]));
  }

  Future<void> _editProvider(AiProviderData? existing) async {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final keyCtrl = TextEditingController(text: existing?.apiKey ?? '');
    final urlCtrl = TextEditingController(text: existing?.baseUrl ?? '');
    final modelCtrl = TextEditingController(text: existing?.model ?? '');
    var type = existing?.type ?? 'gemini';
    if (!mounted) return;
    await showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text(existing == null ? 'Add Provider' : 'Edit Provider'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
        DropdownButtonFormField<String>(initialValue: type, items: _typeLabels.keys.map((t) => DropdownMenuItem(value: t, child: Text(_typeLabels[t]!))).toList(), onChanged: (v) => type = v ?? type),
        TextField(controller: urlCtrl, decoration: const InputDecoration(labelText: 'Base URL')),
        TextField(controller: keyCtrl, decoration: const InputDecoration(labelText: 'API Key')),
        TextField(controller: modelCtrl, decoration: const InputDecoration(labelText: 'Model')),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')), ElevatedButton(onPressed: () {
        final data = (existing ?? AiProviderData(id: 0, name: '', type: type, baseUrl: '', apiKey: '', model: '', isEnabled: true, isConnected: false, totalCalls: 0, totalCost: 0, createdAt: DateTime.now())).copyWith(name: nameCtrl.text, type: type, baseUrl: urlCtrl.text, apiKey: keyCtrl.text, model: modelCtrl.text);
        ref.read(providerViewModelProvider.notifier).saveProvider(data);
        Navigator.pop(ctx);
      }, child: const Text('Save'))],
    ));
  }

  Widget _ActionChip(IconData icon, String label, bool loading, VoidCallback onTap) => ActionChip(avatar: loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : Icon(icon, size: 16), label: Text(label), onPressed: loading ? null : onTap);
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.icon, required this.children});
  final String title;
  final IconData icon;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))]), const SizedBox(height: 12), ...children])));
}
