import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/stockholm_colors.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../widgets/glass_card.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  final _geminiCtrl = TextEditingController();
  final _perplexityCtrl = TextEditingController();
  bool _enableBiometric = false;

  static const _pages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    _geminiCtrl.dispose();
    _perplexityCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final settings = ref.read(settingsRepositoryProvider);
    if (_geminiCtrl.text.trim().isNotEmpty) {
      await settings.setGeminiKey(_geminiCtrl.text.trim());
    }
    if (_perplexityCtrl.text.trim().isNotEmpty) {
      await settings.setPerplexityKey(_perplexityCtrl.text.trim());
    }
    if (_enableBiometric) {
      await ref.read(authRepositoryProvider).setBiometricEnabled(true);
    }

    await ref.read(onboardingRepositoryProvider).complete();

    if (!mounted) return;
    final auth = ref.read(authRepositoryProvider);
    if (auth.isLoggedInSync()) {
      context.go('/');
    } else {
      context.go('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StockholmColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Stockholm',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: StockholmColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  if (_page < _pages - 1)
                    TextButton(
                      onPressed: _finish,
                      child: const Text('Skip'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _WelcomePage(),
                  _PipelinePage(),
                  _ApiKeysPage(
                    geminiCtrl: _geminiCtrl,
                    perplexityCtrl: _perplexityCtrl,
                  ),
                  _SecurityPage(
                    enabled: _enableBiometric,
                    onChanged: (v) => setState(() => _enableBiometric = v),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _page == i ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _page == i
                              ? StockholmColors.signalNeutral
                              : StockholmColors.textMuted.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _next,
                      child: Text(_page == _pages - 1 ? 'Get Started' : 'Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.radar, size: 72, color: StockholmColors.signalNeutral),
          const SizedBox(height: 28),
          Text(
            'Your AI Investment Command Center',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: StockholmColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Stockholm brings quant screening, AI research, portfolio tracking, and geopolitical intel to your phone — fully offline-capable with local data.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: StockholmColors.textSecondary,
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How analysis works',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: StockholmColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          _StageCard(
            step: '1',
            title: 'Quant Screen',
            subtitle: 'Free local math — P/E, RSI, momentum, quality scores',
            color: StockholmColors.signalPositive,
          ),
          const SizedBox(height: 12),
          _StageCard(
            step: '2',
            title: 'Market Intelligence',
            subtitle: 'Perplexity scans live news and analyst consensus',
            color: StockholmColors.signalNeutral,
          ),
          const SizedBox(height: 12),
          _StageCard(
            step: '3',
            title: 'AI Synthesis',
            subtitle: 'Gemini builds Bull/Bear cases with risk & geo scores',
            color: StockholmColors.signalWarning,
          ),
        ],
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  const _StageCard({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String step;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withValues(alpha: 0.2),
              child: Text(step, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: StockholmColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: StockholmColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiKeysPage extends StatelessWidget {
  const _ApiKeysPage({
    required this.geminiCtrl,
    required this.perplexityCtrl,
  });

  final TextEditingController geminiCtrl;
  final TextEditingController perplexityCtrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect your AI providers',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: StockholmColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Optional now — you can add keys later in Settings. Stage 1 (quant) works without any API.',
            style: TextStyle(color: StockholmColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: perplexityCtrl,
            decoration: const InputDecoration(
              labelText: 'Perplexity API Key',
              hintText: 'pplx-…',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: geminiCtrl,
            decoration: const InputDecoration(
              labelText: 'Gemini API Key',
              hintText: 'AIza…',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

class _SecurityPage extends StatelessWidget {
  const _SecurityPage({required this.enabled, required this.onChanged});

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fingerprint, size: 72, color: StockholmColors.signalNeutral),
          const SizedBox(height: 28),
          Text(
            'Protect your portfolio',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: StockholmColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Enable biometric lock so only you can open the app. You can change this anytime in Settings.',
            textAlign: TextAlign.center,
            style: TextStyle(color: StockholmColors.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 32),
          GlassCard(
            child: SwitchListTile(
              title: const Text('Biometric lock', style: TextStyle(color: StockholmColors.textPrimary)),
              subtitle: const Text('Fingerprint or face unlock', style: TextStyle(color: StockholmColors.textSecondary)),
              value: enabled,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
