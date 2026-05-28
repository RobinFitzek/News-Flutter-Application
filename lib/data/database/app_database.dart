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
  DateTimeColumn get lastScannedAt =>
      dateTime().named('last_scanned_at').nullable()();
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
  RealColumn get predictedPrice => real().withDefault(const Constant(0.0))();
  RealColumn get confidence => real().withDefault(const Constant(0.5))();
  TextColumn get recommendation => text().withDefault(const Constant(''))();
  TextColumn get reasoning => text().withDefault(const Constant(''))();
  TextColumn get newsSummary => text().withDefault(const Constant(''))();
  TextColumn get timeframe => text().withDefault(const Constant('daily'))();
  RealColumn get currentPrice => real().withDefault(const Constant(0.0))();
  // Extended fields matching server analysis_history
  TextColumn get signal => text().withDefault(const Constant('Neutral'))();
  IntColumn get riskScore => integer().withDefault(const Constant(5))();
  IntColumn get geoRiskScore => integer().nullable()();
  IntColumn get quantScore => integer().nullable()();
  TextColumn get bullCase => text().withDefault(const Constant(''))();
  TextColumn get bearCase => text().withDefault(const Constant(''))();
  TextColumn get sources => text().withDefault(const Constant(''))();
  TextColumn get fundamental => text().withDefault(const Constant(''))();
  TextColumn get technical => text().withDefault(const Constant(''))();
  TextColumn get geopoliticalContext => text().nullable()();
  TextColumn get stage1Reason => text().withDefault(const Constant(''))();
  TextColumn get quantMetricsJson => text().withDefault(const Constant(''))();
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

@TableIndex(name: 'idx_fin_ratio_symbol', columns: {#symbol}, unique: true)
@DataClassName('FinancialRatioData')
class FinancialRatios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  RealColumn get peRatio => real().nullable()();
  RealColumn get pbRatio => real().nullable()();
  RealColumn get eps => real().nullable()();
  RealColumn get dividendYield => real().nullable()();
  RealColumn get beta => real().nullable()();
  TextColumn get week52High => text().withDefault(const Constant(''))();
  TextColumn get week52Low => text().withDefault(const Constant(''))();
  RealColumn get marketCap => real().nullable()();
  RealColumn get revenueGrowth => real().nullable()();
  RealColumn get profitMargin => real().nullable()();
  RealColumn get debtToEquity => real().nullable()();
  RealColumn get roe => real().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

@TableIndex(name: 'idx_ca_symbol', columns: {#symbol})
@DataClassName('CorporateActionData')
class CorporateActions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get type => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
}

@TableIndex(name: 'idx_earnings_symbol', columns: {#symbol})
@DataClassName('EarningsEventData')
class EarningsEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  DateTimeColumn get reportDate => dateTime()();
  RealColumn get estimatedEps => real().nullable()();
  RealColumn get actualEps => real().nullable()();
  RealColumn get surprise => real().nullable()();
  RealColumn get surprisePercent => real().nullable()();
  TextColumn get period => text().withDefault(const Constant(''))();
}

@TableIndex(name: 'idx_insider_symbol', columns: {#symbol})
@DataClassName('InsiderTransactionData')
class InsiderTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get insiderName => text()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  RealColumn get shares => real()();
  RealColumn get price => real()();
  RealColumn get totalValue => real()();
  DateTimeColumn get filingDate => dateTime()();
  DateTimeColumn get transactionDate => dateTime()();
}

@TableIndex(name: 'idx_inst_symbol', columns: {#symbol})
@DataClassName('InstitutionalHolderData')
class InstitutionalHolders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get holderName => text()();
  RealColumn get shares => real()();
  RealColumn get value => real()();
  RealColumn get percentOut => real()();
  DateTimeColumn get reportDate => dateTime()();
  RealColumn get change => real().nullable()();
}

@TableIndex(name: 'idx_disc_symbol', columns: {#symbol})
@DataClassName('DiscoveryData')
class Discoveries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get companyName => text().withDefault(const Constant(''))();
  TextColumn get reason => text()();
  TextColumn get strategy => text().withDefault(const Constant('ai'))();
  RealColumn get currentPrice => real()();
  RealColumn get confidence => real()();
  DateTimeColumn get discoveredAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isPromoted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDismissed => boolean().withDefault(const Constant(false))();
  RealColumn get potentialUpside => real().nullable()();
  DateTimeColumn get promotedAt =>
      dateTime().named('promoted_at').nullable()();
}

@TableIndex(name: 'idx_discovery_outcome_id', columns: {#discoveryId}, unique: true)
@DataClassName('DiscoveryOutcomeData')
class DiscoveryOutcomes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get discoveryId => integer().named('discovery_id')();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  DateTimeColumn get promotedAt => dateTime().named('promoted_at')();
  RealColumn get promotedPrice => real().named('promoted_price')();
  RealColumn get price30d => real().named('price_30d').nullable()();
  RealColumn get price60d => real().named('price_60d').nullable()();
  RealColumn get price90d => real().named('price_90d').nullable()();
  RealColumn get return30d => real().named('return_30d').nullable()();
  RealColumn get return60d => real().named('return_60d').nullable()();
  RealColumn get return90d => real().named('return_90d').nullable()();
  TextColumn get strategy => text().withDefault(const Constant('ai'))();
  DateTimeColumn get updatedAt =>
      dateTime().named('updated_at').withDefault(currentDateAndTime)();
}

@DataClassName('WeightVersionData')
class WeightVersions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get oldWeights => text().named('old_weights')();
  TextColumn get newWeights => text().named('new_weights')();
  TextColumn get reason => text().nullable()();
  TextColumn get trigger => text()();
  RealColumn get accuracyBefore => real().named('accuracy_before').nullable()();
  RealColumn get accuracyAfter => real().named('accuracy_after').nullable()();
}

@DataClassName('McptResultData')
class McptResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get testType => text().named('test_type')();
  DateTimeColumn get runDate => dateTime().named('run_date')();
  RealColumn get pValue => real().named('p_value').nullable()();
  RealColumn get actualMetric => real().named('actual_metric').nullable()();
  RealColumn get permutedMean => real().named('permuted_mean').nullable()();
  RealColumn get permutedStd => real().named('permuted_std').nullable()();
  IntColumn get nPermutations => integer().named('n_permutations').nullable()();
  IntColumn get nSignals => integer().named('n_signals').nullable()();
  BoolColumn get significant => boolean().nullable()();
  TextColumn get details => text().withDefault(const Constant(''))();
}

@TableIndex(name: 'idx_price_alert_symbol', columns: {#symbol})
@DataClassName('PriceAlertData')
class PriceAlerts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  RealColumn get targetPrice => real().named('target_price')();
  TextColumn get direction =>
      text().withDefault(const Constant('above'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get triggered => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get triggeredAt =>
      dateTime().named('triggered_at').nullable()();
}

@TableIndex(
  name: 'idx_financial_cache_unique',
  columns: {#symbol, #dataType},
  unique: true,
)
@DataClassName('FinancialCacheData')
class FinancialCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get dataType => text().named('data_type')();
  TextColumn get dataJson => text().named('data_json')();
  DateTimeColumn get fetchedAt =>
      dateTime().named('fetched_at').withDefault(currentDateAndTime)();
}

@DataClassName('BacktestResultData')
class BacktestResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get strategy => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  RealColumn get initialCapital => real()();
  RealColumn get finalCapital => real()();
  RealColumn get totalReturn => real()();
  RealColumn get totalReturnPercent => real()();
  RealColumn get maxDrawdown => real()();
  RealColumn get maxDrawdownPercent => real()();
  IntColumn get totalTrades => integer()();
  IntColumn get winningTrades => integer()();
  IntColumn get losingTrades => integer()();
  RealColumn get winRate => real()();
  RealColumn get avgWin => real()();
  RealColumn get avgLoss => real()();
  RealColumn get profitFactor => real()();
  TextColumn get symbols => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_journal_symbol', columns: {#symbol})
@DataClassName('JournalEntryData')
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get type => text()();
  RealColumn get entryPrice => real()();
  RealColumn get exitPrice => real().nullable()();
  RealColumn get shares => real().nullable()();
  RealColumn get pnl => real().nullable()();
  DateTimeColumn get entryDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get exitDate => dateTime().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get mood => text().withDefault(const Constant(''))();
  TextColumn get tags => text().withDefault(const Constant(''))();
  BoolColumn get isClosed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('WatchlistGroupData')
class WatchlistGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('AppSettingData')
class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

@TableIndex(name: 'idx_api_cost_month', columns: {#month, #api})
@DataClassName('ApiCostLogData')
class ApiCostLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get api => text()();
  TextColumn get model => text()();
  IntColumn get inputTokens => integer().withDefault(const Constant(0))();
  IntColumn get outputTokens => integer().withDefault(const Constant(0))();
  RealColumn get costUsd => real()();
  TextColumn get month => text()();
  TextColumn get day => text()();
  TextColumn get ticker => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('GeopoliticalEventData')
class GeopoliticalEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get severity => integer().withDefault(const Constant(5))();
  TextColumn get summary => text()();
  TextColumn get rawSummary => text().withDefault(const Constant(''))();
  DateTimeColumn get scannedAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_auto_trade_ticker', columns: {#ticker})
@TableIndex(name: 'idx_auto_trade_status', columns: {#status})
@DataClassName('AutoPaperTradeData')
class AutoPaperTrades extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get analysisId => integer().nullable()();
  TextColumn get ticker => text().withLength(min: 1, max: 10)();
  TextColumn get direction => text()();
  DateTimeColumn get entryDate => dateTime().nullable()();
  RealColumn get entryPrice => real().nullable()();
  DateTimeColumn get exitDate => dateTime().nullable()();
  RealColumn get exitPrice => real().nullable()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  TextColumn get closeReason => text().nullable()();
  RealColumn get pnlPct => real().nullable()();
  TextColumn get blockedReason => text().nullable()();
}

@TableIndex(name: 'idx_auto_pending_token', columns: {#token}, unique: true)
@DataClassName('AutoTradePendingData')
class AutoTradePending extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get token => text().unique()();
  IntColumn get analysisId => integer()();
  TextColumn get ticker => text().withLength(min: 1, max: 10)();
  TextColumn get direction => text()();
  TextColumn get signal => text()();
  IntColumn get score => integer().nullable()();
  RealColumn get proposedEntryPrice => real()();
  RealColumn get proposedShares => real()();
  RealColumn get proposedSizeUsd => real()();
  RealColumn get riskTpPrice => real()();
  RealColumn get riskSlPrice => real()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get decidedAt => dateTime().nullable()();
}

@TableIndex(name: 'idx_signal_grade_symbol', columns: {#symbol})
@TableIndex(name: 'idx_signal_grade_analysis', columns: {#analysisId})
@DataClassName('SignalGradeData')
class SignalGrades extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get analysisId => integer()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  TextColumn get signal => text()();
  IntColumn get confidence => integer().withDefault(const Constant(50))();
  IntColumn get quantScore => integer().nullable()();
  DateTimeColumn get signalDate => dateTime()();
  RealColumn get priceAtSignal => real().nullable()();
  RealColumn get price30d => real().nullable()();
  RealColumn get price60d => real().nullable()();
  RealColumn get price90d => real().nullable()();
  RealColumn get return30d => real().nullable()();
  RealColumn get return60d => real().nullable()();
  RealColumn get return90d => real().nullable()();
  TextColumn get grade => text().withDefault(const Constant('pending'))();
  DateTimeColumn get gradedAt => dateTime().nullable()();
}

@TableIndex(name: 'idx_ticker_sentiment_symbol', columns: {#ticker, #scoredAt})
@DataClassName('TickerSentimentData')
class TickerSentimentSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ticker => text().withLength(min: 1, max: 10)();
  RealColumn get compoundScore => real().withDefault(const Constant(0.0))();
  RealColumn get positive => real().withDefault(const Constant(0.0))();
  RealColumn get neutral => real().withDefault(const Constant(1.0))();
  RealColumn get negative => real().withDefault(const Constant(0.0))();
  IntColumn get headlineCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get scoredAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(
  name: 'idx_supply_chain_unique',
  columns: {#ticker, #companyName, #relationshipType},
  unique: true,
)
@TableIndex(name: 'idx_supply_chain_ticker', columns: {#ticker})
@DataClassName('SupplyChainEntryData')
class SupplyChainEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ticker => text().withLength(min: 1, max: 10)();
  TextColumn get relatedTicker => text().nullable()();
  TextColumn get companyName => text()();
  TextColumn get relationshipType => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('TickerGraveyardData')
class TickerGraveyard extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ticker => text().unique()();
  TextColumn get lastSeen => text().nullable()();
  TextColumn get reason => text()();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('CashPositionData')
class CashPositions extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get transactionDate =>
      dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PortfolioAlertAckData')
class PortfolioAlertAcks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get alertKey => text().unique()();
  DateTimeColumn get acknowledgedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_prediction_symbol', columns: {#symbol})
@DataClassName('PredictionOutcomeData')
class PredictionOutcomes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text().withLength(min: 1, max: 10)();
  DateTimeColumn get predictionDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get signal => text()();
  TextColumn get predictedDirection => text().withDefault(const Constant('neutral'))();
  IntColumn get confidence => integer().withDefault(const Constant(50))();
  RealColumn get actualPriceAtPrediction => real()();
  RealColumn get actualPriceAfter => real().nullable()();
  TextColumn get actualDirection => text().nullable()();
  RealColumn get accuracyScore => real().nullable()();
  IntColumn get daysElapsed => integer().nullable()();
  DateTimeColumn get verifiedAt => dateTime().nullable()();
  TextColumn get signalType => text().withDefault(const Constant('default'))();
  IntColumn get verificationWindowDays => integer().withDefault(const Constant(60))();
  RealColumn get benchmarkReturn => real().nullable()();
  BoolColumn get beatBenchmark => boolean().nullable()();
  IntColumn get analysisId => integer().nullable()();
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
  FinancialRatios,
  CorporateActions,
  EarningsEvents,
  InsiderTransactions,
  InstitutionalHolders,
  Discoveries,
  BacktestResults,
  JournalEntries,
  WatchlistGroups,
  AppSettings,
  ApiCostLog,
  GeopoliticalEvents,
  PredictionOutcomes,
  SignalGrades,
  AutoPaperTrades,
  AutoTradePending,
  TickerSentimentSnapshots,
  SupplyChainEntries,
  DiscoveryOutcomes,
  WeightVersions,
  McptResults,
  PriceAlerts,
  FinancialCache,
  TickerGraveyard,
  CashPositions,
  PortfolioAlertAcks,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 17;

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
          if (from < 5) {
            await m.createTable(financialRatios);
            await m.createTable(corporateActions);
            await m.createTable(earningsEvents);
            await m.createTable(insiderTransactions);
            await m.createTable(institutionalHolders);
          }
          if (from < 6) {
            await m.createTable(discoveries);
          }
          if (from < 7) {
            await m.createTable(backtestResults);
            await m.createTable(journalEntries);
          }
          if (from < 8) {
            await m.createTable(watchlistGroups);
          }
          if (from < 9) {
            await m.addColumn(analysisResults, analysisResults.signal);
            await m.addColumn(analysisResults, analysisResults.riskScore);
            await m.addColumn(analysisResults, analysisResults.geoRiskScore);
            await m.addColumn(analysisResults, analysisResults.quantScore);
            await m.addColumn(analysisResults, analysisResults.bullCase);
            await m.addColumn(analysisResults, analysisResults.bearCase);
            await m.addColumn(analysisResults, analysisResults.sources);
            await m.addColumn(analysisResults, analysisResults.fundamental);
            await m.addColumn(analysisResults, analysisResults.technical);
            await m.addColumn(analysisResults, analysisResults.geopoliticalContext);
            await m.addColumn(analysisResults, analysisResults.stage1Reason);
            await m.addColumn(analysisResults, analysisResults.quantMetricsJson);
            await m.createTable(appSettings);
            await m.createTable(apiCostLog);
            await m.createTable(geopoliticalEvents);
          }
          if (from < 10) {
            await m.createTable(predictionOutcomes);
          }
          if (from < 11) {
            await m.createTable(signalGrades);
          }
          if (from < 12) {
            await m.createTable(autoPaperTrades);
            await m.createTable(autoTradePending);
          }
          if (from < 13) {
            await m.createTable(tickerSentimentSnapshots);
            await m.createTable(supplyChainEntries);
          }
          if (from < 14) {
            await m.addColumn(watchlistItems, watchlistItems.lastScannedAt);
          }
          if (from < 15) {
            await m.addColumn(discoveries, discoveries.promotedAt);
            await m.createTable(discoveryOutcomes);
            await m.createTable(weightVersions);
            await m.createTable(mcptResults);
          }
          if (from < 16) {
            await m.createTable(priceAlerts);
            await m.createTable(financialCache);
          }
          if (from < 17) {
            await m.createTable(tickerGraveyard);
            await m.createTable(cashPositions);
            await m.createTable(portfolioAlertAcks);
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
