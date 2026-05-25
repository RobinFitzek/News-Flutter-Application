import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/settings_repository.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _geminiController = TextEditingController();
  final _perplexityController = TextEditingController();
  String? _themeMode;

  @override
  void initState() {
    super.initState();
    _loadSettings();
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

  @override
  Widget build(BuildContext context) {
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
