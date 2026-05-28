import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/scheduler_service.dart';
import '../views/loading/splash_screen.dart';

/// Starts local maintenance scheduler when app mounts.
class SchedulerBootstrap extends ConsumerStatefulWidget {
  const SchedulerBootstrap({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<SchedulerBootstrap> createState() => _SchedulerBootstrapState();
}

class _SchedulerBootstrapState extends ConsumerState<SchedulerBootstrap>
    with WidgetsBindingObserver {
  SchedulerService? _scheduler;
  bool _showSplash = !Platform.environment.containsKey('FLUTTER_TEST');
  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduler = ref.read(schedulerServiceProvider);
      if (!Platform.environment.containsKey('FLUTTER_TEST')) {
        _scheduler?.start();
      }
    });
    if (_showSplash) {
      _splashTimer = Timer(const Duration(milliseconds: 900), () {
        if (mounted) setState(() => _showSplash = false);
      });
    }
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _scheduler?.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _scheduler?.runMaintenanceCycle();
    }
  }

  @override
  Widget build(BuildContext context) => _showSplash
      ? const Directionality(
          textDirection: TextDirection.ltr,
          child: Material(child: SplashScreen()),
        )
      : widget.child;
}
