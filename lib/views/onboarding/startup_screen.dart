import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/stockholm_colors.dart';
import '../../data/repositories/onboarding_repository.dart';

/// Brief splash while onboarding/auth flags load — avoids redirect flicker.
class StartupScreen extends ConsumerStatefulWidget {
  const StartupScreen({super.key});

  @override
  ConsumerState<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends ConsumerState<StartupScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_bootstrap);
  }

  Future<void> _bootstrap() async {
    final onboarding = ref.read(onboardingRepositoryProvider);
    if (!onboarding.isLoaded) {
      await onboarding.load();
    }
    if (!mounted) return;

    if (!onboarding.isCompleted) {
      context.go('/onboarding');
      return;
    }

    // Auth redirect handled by router after leaving startup.
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StockholmColors.bgPrimary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.radar, size: 56, color: StockholmColors.signalNeutral),
            const SizedBox(height: 20),
            Text(
              'Stockholm',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: StockholmColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}
