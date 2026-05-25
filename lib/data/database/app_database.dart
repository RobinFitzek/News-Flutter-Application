import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get geminiApiKey => text().withLength(max: 255).nullable()();
  TextColumn get perplexityApiKey => text().withLength(max: 255).nullable()();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  IntColumn get analysisInterval =>
      integer().withDefault(const Constant(4))();
  RealColumn get maxPositionPercent =>
      real().withDefault(const Constant(10.0))();
  RealColumn get stopLossPercent =>
      real().withDefault(const Constant(15.0))();
}

class ApiKeys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get service => text()();
  TextColumn get keyValue => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@TableIndex(name: 'idx_watchlist_symbol', columns: {#symbol})
@DataClassName('WatchlistItemData')
class WatchlistItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get tier => text().withDefault(const Constant('core'))();
  TextColumn get note => text().nullable()();
  TextColumn get groupName =>
      text().named('group_name').nullable()();
  RealColumn get lastPrice => real().named('last_price').nullable()();
  RealColumn get lastPriceChange =>
      real().named('last_price_change').nullable()();
}

@TableIndex(name: 'idx_cache_symbol', columns: {#symbol}, unique: true)
@DataClassName('StockCacheData')
class StockCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get companyName => text().withDefault(const Constant(''))();
  RealColumn get currentPrice => real()();
  RealColumn get previousClose => real()();
  RealColumn get change => real()();
  RealColumn get changePercent => real()();
  RealColumn get dayHigh => real()();
  RealColumn get dayLow => real()();
  IntColumn get volume => integer()();
  RealColumn get marketCap => real().named('market_cap').nullable()();
  DateTimeColumn get timestamp => dateTime()();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('AiProviderData')
class AiProviders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get baseUrl => text()();
  TextColumn get apiKey => text()();
  TextColumn get model => text()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get isConnected => boolean().withDefault(const Constant(false))();
  IntColumn get totalCalls => integer().withDefault(const Constant(0))();
  RealColumn get totalCost => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastTestedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_stage_unique', columns: {#stage}, unique: true)
@DataClassName('StageAssignmentData')
class StageAssignments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get stage => text()();
  IntColumn get providerId => integer()();
}

@TableIndex(name: 'idx_analysis_symbol', columns: {#symbol})
@TableIndex(name: 'idx_analysis_created', columns: {#createdAt})
@DataClassName('AnalysisResultData')
class AnalysisResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  RealColumn get predictedPrice => real()();
  RealColumn get confidence => real()();
  TextColumn get recommendation => text()();
  TextColumn get reasoning => text()();
  TextColumn get newsSummary => text().withDefault(const Constant(''))();
  TextColumn get timeframe => text().withDefault(const Constant('daily'))();
  RealColumn get currentPrice => real()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_position_symbol', columns: {#symbol})
@DataClassName('PositionData')
class PortfolioPositions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get companyName => text().withDefault(const Constant(''))();
  RealColumn get shares => real()();
  RealColumn get avgCostBasis => real()();
  RealColumn get currentPrice => real().withDefault(const Constant(0.0))();
  DateTimeColumn get acquiredAt =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get note => text().nullable()();
}

@TableIndex(name: 'idx_paper_symbol', columns: {#symbol})
@DataClassName('PaperTradeData')
class PaperTrades extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get type => text()();
  RealColumn get shares => real()();
  RealColumn get price => real()();
  DateTimeColumn get executedAt =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get status => text().withDefault(const Constant('OPEN'))();
  TextColumn get exitReason => text().nullable()();
  RealColumn get exitPrice => real().nullable()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  RealColumn get realizedPnl => real().nullable()();
}

@DataClassName('PaperSettingsData')
class PaperSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get startingCapital =>
      real().withDefault(const Constant(100000.0))();
  RealColumn get takeProfitPercent =>
      real().withDefault(const Constant(15.0))();
  RealColumn get stopLossPercent =>
      real().withDefault(const Constant(10.0))();
  IntColumn get maxOpenTrades => integer().withDefault(const Constant(5))();
  RealColumn get positionSizePercent =>
      real().withDefault(const Constant(20.0))();
}

@DriftDatabase(tables: [
  UserSettings,
  ApiKeys,
  WatchlistItems,
  StockCache,
  AiProviders,
  StageAssignments,
  AnalysisResults,
  PortfolioPositions,
  PaperTrades,
  PaperSettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();

          await into(aiProviders).insert(
            AiProvidersCompanion(
              name: const Value('Google Gemini'),
              type: const Value('gemini'),
              baseUrl: const Value(
                'https://generativelanguage.googleapis.com/v1beta',
              ),
              apiKey: const Value(''),
              model: const Value('gemini-2.0-flash'),
            ),
          );

          await into(aiProviders).insert(
            AiProvidersCompanion(
              name: const Value('Perplexity'),
              type: const Value('perplexity'),
              baseUrl: const Value('https://api.perplexity.ai'),
              apiKey: const Value(''),
              model: const Value('sonar-pro'),
            ),
          );
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(watchlistItems);
            await m.createTable(stockCache);
          }
          if (from < 3) {
            await m.createTable(aiProviders);
            await m.createTable(stageAssignments);
            await m.createTable(analysisResults);

            await into(aiProviders).insert(
              AiProvidersCompanion(
                name: const Value('Google Gemini'),
                type: const Value('gemini'),
                baseUrl: const Value(
                  'https://generativelanguage.googleapis.com/v1beta',
                ),
                apiKey: const Value(''),
                model: const Value('gemini-2.0-flash'),
              ),
            );

            await into(aiProviders).insert(
              AiProvidersCompanion(
                name: const Value('Perplexity'),
                type: const Value('perplexity'),
                baseUrl: const Value('https://api.perplexity.ai'),
                apiKey: const Value(''),
                model: const Value('sonar-pro'),
              ),
            );
          }
          if (from < 4) {
            await m.createTable(portfolioPositions);
            await m.createTable(paperTrades);
            await m.createTable(paperSettings);
            await into(paperSettings).insert(PaperSettingsCompanion());
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final sqlite3 = NativeDatabase.createInBackground(file);
    return sqlite3;
  });
}
