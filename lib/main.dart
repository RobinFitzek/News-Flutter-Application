import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'data/datasources/local/database_datasource.dart';
import 'data/repositories/onboarding_repository.dart';
import 'services/background_task_handler.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerBackgroundTasks();
  await NotificationService.instance.init();

  final container = ProviderContainer();
  await container.read(onboardingRepositoryProvider).load();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const StockPredictionApp(),
    ),
  );
}
