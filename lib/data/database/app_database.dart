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

@DriftDatabase(tables: [UserSettings, ApiKeys, WatchlistItems, StockCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(watchlistItems);
            await m.createTable(stockCache);
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
