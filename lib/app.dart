import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme.dart';
import 'config/app_router.dart';
import 'widgets/scheduler_bootstrap.dart';

class StockPredictionApp extends ConsumerWidget {
  const StockPredictionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return SchedulerBootstrap(
      child: MaterialApp.router(
        title: 'AI Stock Prediction',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
