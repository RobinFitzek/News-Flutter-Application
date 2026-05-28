import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _tryBiometric());
  }

  Future<void> _tryBiometric() async {
    final canAuth = await _localAuth.canCheckBiometrics;
    final isBiometricAvailable = await _localAuth.isDeviceSupported();
    if (canAuth && isBiometricAvailable) {
      try {
        final authenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access AI Stock Prediction',
          options: const AuthenticationOptions(stickyAuth: true),
        );
        if (authenticated && mounted) {
          ref.read(authViewModelProvider.notifier).login();
        }
      } catch (_) {}
    }
  }

  void _skip() {
    ref.read(authViewModelProvider.notifier).login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.trending_up, size: 80, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              Text('AI Stock Prediction', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Intelligent stock market predictions\npowered by AI', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(height: 48),
              SizedBox(width: double.infinity, child: ElevatedButton.icon(
                onPressed: _tryBiometric,
                icon: const Icon(Icons.fingerprint),
                label: const Text('Unlock with Biometrics'),
              )),
              const SizedBox(height: 12),
              TextButton(onPressed: _skip, child: const Text('Skip')),
            ],
          ),
        ),
      ),
    );
  }
}
