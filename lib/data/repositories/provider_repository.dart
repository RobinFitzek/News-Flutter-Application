import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';
import '../../models/stage_assignment.dart';

abstract class ProviderRepository {
  Future<List<AiProviderData>> getAll();
  Future<List<AiProviderData>> getEnabled();
  Future<AiProviderData?> getById(int id);
  Future<AiProviderData> save(AiProviderData provider);
  Future<void> delete(int id);
  Future<AiProviderData?> getByStage(AnalysisStage stage);
  Future<void> setStage(AnalysisStage stage, int providerId);
}

class ProviderRepositoryImpl implements ProviderRepository {
  ProviderRepositoryImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<AiProviderData>> getAll() async {
    final result = await db.select(db.aiProviders).get();
    return result;
  }

  @override
  Future<List<AiProviderData>> getEnabled() async {
    final result = await (db.select(db.aiProviders)
          ..where((t) => t.isEnabled.equals(true)))
        .get();
    return result;
  }

  @override
  Future<AiProviderData?> getById(int id) async {
    final result = await (db.select(db.aiProviders)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return result;
  }

  @override
  Future<AiProviderData> save(AiProviderData provider) async {
    final id = provider.id;
    if (id > 0) {
      final existing = await (db.select(db.aiProviders)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing != null) {
        await (db.update(db.aiProviders)
              ..where((t) => t.id.equals(id)))
            .write(AiProvidersCompanion(
              name: Value(provider.name),
              type: Value(provider.type),
              baseUrl: Value(provider.baseUrl),
              apiKey: Value(provider.apiKey),
              model: Value(provider.model),
              isEnabled: Value(provider.isEnabled),
            ));
        final updated = await (db.select(db.aiProviders)
              ..where((t) => t.id.equals(id)))
            .getSingle();
        return updated;
      }
    }

    final newId = await db.into(db.aiProviders).insert(
          AiProvidersCompanion(
            name: Value(provider.name),
            type: Value(provider.type),
            baseUrl: Value(provider.baseUrl),
            apiKey: Value(provider.apiKey),
            model: Value(provider.model),
            isEnabled: Value(provider.isEnabled),
          ),
        );
    final result = await (db.select(db.aiProviders)..where((t) => t.id.equals(newId)))
        .getSingle();
    return result;
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.aiProviders)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<AiProviderData?> getByStage(AnalysisStage stage) async {
    final stageName = stage == AnalysisStage.newsResearch
        ? 'newsResearch'
        : 'finalAnalysis';

    final assignment = await (db.select(db.stageAssignments)
          ..where((t) => t.stage.equals(stageName)))
        .getSingleOrNull();

    if (assignment == null) return null;

    return (db.select(db.aiProviders)
          ..where((t) => t.id.equals(assignment.providerId)))
        .getSingleOrNull();
  }

  @override
  Future<void> setStage(AnalysisStage stage, int providerId) async {
    final stageName = stage == AnalysisStage.newsResearch
        ? 'newsResearch'
        : 'finalAnalysis';

    final existing = await (db.select(db.stageAssignments)
          ..where((t) => t.stage.equals(stageName)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.update(db.stageAssignments)
            ..where((t) => t.id.equals(existing.id)))
          .write(StageAssignmentsCompanion(providerId: Value(providerId)));
    } else {
      await db.into(db.stageAssignments).insert(
            StageAssignmentsCompanion(
              stage: Value(stageName),
              providerId: Value(providerId),
            ),
          );
    }
  }
}

final providerRepositoryProvider = Provider<ProviderRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ProviderRepositoryImpl(db);
});
