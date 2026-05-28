import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database_datasource.dart';
import '../database/app_database.dart';

abstract class PortfolioRepository {
  Future<List<PositionData>> getAllPositions();
  Future<PositionData?> getPositionBySymbol(String symbol);
  Future<PositionData> addPosition(PositionData data);
  Future<void> updatePosition(PositionData data);
  Future<void> updatePrice(int id, double price);
  Future<void> deletePosition(int id);
  Future<PortfolioSummary> getSummary();
}

class PortfolioSummary {
  const PortfolioSummary({
    required this.totalMarketValue,
    required this.totalCostBasis,
    required this.totalUnrealizedPnl,
    required this.totalUnrealizedPnlPercent,
    required this.paperCashBalance,
    required this.paperPortfolioValue,
    required this.paperTotalPnl,
    this.openPositionsCount = 0,
    this.openPaperTradesCount = 0,
  });

  final double totalMarketValue;
  final double totalCostBasis;
  final double totalUnrealizedPnl;
  final double totalUnrealizedPnlPercent;
  final double paperCashBalance;
  final double paperPortfolioValue;
  final double paperTotalPnl;
  final int openPositionsCount;
  final int openPaperTradesCount;
}

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<PositionData>> getAllPositions() async {
    return db.select(db.portfolioPositions).get();
  }

  @override
  Future<PositionData?> getPositionBySymbol(String symbol) async {
    return (db.select(db.portfolioPositions)
          ..where((t) => t.symbol.equals(symbol.toUpperCase())))
        .getSingleOrNull();
  }

  @override
  Future<PositionData> addPosition(PositionData data) async {
    final id = await db.into(db.portfolioPositions).insert(
          PortfolioPositionsCompanion(
            symbol: Value(data.symbol.toUpperCase()),
            companyName: Value(data.companyName),
            shares: Value(data.shares),
            avgCostBasis: Value(data.avgCostBasis),
            currentPrice: Value(data.currentPrice),
            acquiredAt: Value(data.acquiredAt),
            currency: Value(data.currency),
            note: Value(data.note),
          ),
        );
    return (db.select(db.portfolioPositions)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  @override
  Future<void> updatePosition(PositionData data) async {
    await (db.update(db.portfolioPositions)
          ..where((t) => t.id.equals(data.id)))
        .write(PortfolioPositionsCompanion(
          symbol: Value(data.symbol),
          companyName: Value(data.companyName),
          shares: Value(data.shares),
          avgCostBasis: Value(data.avgCostBasis),
          currentPrice: Value(data.currentPrice),
          currency: Value(data.currency),
          note: Value(data.note),
        ));
  }

  @override
  Future<void> updatePrice(int id, double price) async {
    await (db.update(db.portfolioPositions)
          ..where((t) => t.id.equals(id)))
        .write(PortfolioPositionsCompanion(
          currentPrice: Value(price),
        ));
  }

  @override
  Future<void> deletePosition(int id) async {
    await (db.delete(db.portfolioPositions)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  @override
  Future<PortfolioSummary> getSummary() async {
    final positions = await getAllPositions();
    double totalMarketValue = 0;
    double totalCostBasis = 0;

    for (final p in positions) {
      totalMarketValue += p.shares * p.currentPrice;
      totalCostBasis += p.shares * p.avgCostBasis;
    }

    final totalUnrealizedPnl = totalMarketValue - totalCostBasis;
    final totalUnrealizedPnlPercent =
        totalCostBasis != 0 ? (totalUnrealizedPnl / totalCostBasis) * 100 : 0.0;

    final settings =
        await (db.select(db.paperSettings)).getSingleOrNull();
    final cash = settings?.startingCapital ?? 100000.0;

    final openTrades = await (db.select(db.paperTrades)
          ..where((t) => t.status.equals('OPEN')))
        .get();
    double paperPortfolioValue = cash;

    for (final t in openTrades) {
      if (t.type == 'BUY') {
        paperPortfolioValue += t.shares * t.price;
      }
    }

    final closedTrades = await (db.select(db.paperTrades)
          ..where((t) => t.status.equals('CLOSED')))
        .get();
    double totalPaperPnl = 0;
    for (final t in closedTrades) {
      totalPaperPnl += t.realizedPnl ?? 0;
    }

    return PortfolioSummary(
      totalMarketValue: totalMarketValue,
      totalCostBasis: totalCostBasis,
      totalUnrealizedPnl: totalUnrealizedPnl,
      totalUnrealizedPnlPercent: totalUnrealizedPnlPercent,
      paperCashBalance: cash,
      paperPortfolioValue: paperPortfolioValue,
      paperTotalPnl: totalPaperPnl,
      openPositionsCount: positions.length,
      openPaperTradesCount: openTrades.length,
    );
  }
}

final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return PortfolioRepositoryImpl(db);
});
