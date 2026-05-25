import 'dart:math';
import '../../data/datasources/remote/yahoo_finance_client.dart';

class BacktestEngine {
  final YahooFinanceClient yahooClient;

  BacktestEngine({YahooFinanceClient? yahooClient})
      : yahooClient = yahooClient ?? YahooFinanceClient();

  Future<Map<String, dynamic>> run({
    required List<String> symbols,
    required String strategy,
    required double initialCapital,
    required int startDaysAgo,
    double takeProfitPct = 0.15,
    double stopLossPct = 0.10,
  }) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: startDaysAgo));

    final allData = <String, List<Map<String, dynamic>>>{};
    for (final symbol in symbols) {
      try {
        final raw = await yahooClient.getHistoricalData(
          symbol,
          interval: '1d',
          range: '${startDaysAgo}d',
        );
        allData[symbol] = List<Map<String, dynamic>>.from(raw['dataPoints']);
      } catch (_) {}
    }

    if (allData.isEmpty) {
      throw Exception('Failed to fetch data for any symbol');
    }

    return _simulate(
      allData: allData,
      strategy: strategy,
      initialCapital: initialCapital,
      startDate: startDate,
      endDate: endDate,
      takeProfitPct: takeProfitPct,
      stopLossPct: stopLossPct,
    );
  }

  Map<String, dynamic> _simulate({
    required Map<String, List<Map<String, dynamic>>> allData,
    required String strategy,
    required double initialCapital,
    required DateTime startDate,
    required DateTime endDate,
    required double takeProfitPct,
    required double stopLossPct,
  }) {
    double cash = initialCapital;
    final positions = <String, Map<String, dynamic>>{};
    final trades = <Map<String, dynamic>>[];
    final equityCurve = <double>[initialCapital];
    double peakEquity = initialCapital;
    double maxDrawdown = 0;

    final symbols = allData.keys.toList();
    if (symbols.isEmpty) {
      return _buildResult(strategy, startDate, endDate, initialCapital, cash, maxDrawdown, trades);
    }

    final perSymbolAllocation = initialCapital / symbols.length;

    final maxDays = allData.values.map((d) => d.length).reduce(min);
    if (maxDays < 2) {
      return _buildResult(strategy, startDate, endDate, initialCapital, initialCapital, 0, []);
    }

    for (int day = 1; day < maxDays; day++) {
      for (final symbol in symbols) {
        final data = allData[symbol]!;
        if (day >= data.length) continue;

        final prevClose = (data[day - 1]['close'] as num).toDouble();
        final currentClose = (data[day]['close'] as num).toDouble();
        final change = (currentClose - prevClose) / prevClose;

        final positionKey = symbol;
        if (positions.containsKey(positionKey)) {
          final pos = positions[positionKey]!;
          final entryPrice = pos['entryPrice'] as double;
          final shares = pos['shares'] as double;
          final currentValue = shares * currentClose;
          final pnlPct = (currentClose - entryPrice) / entryPrice;

          bool shouldClose = false;
          String closeReason = '';

          if (pnlPct >= takeProfitPct) {
            shouldClose = true;
            closeReason = 'take_profit';
          } else if (pnlPct <= -stopLossPct) {
            shouldClose = true;
            closeReason = 'stop_loss';
          }

          if (shouldClose) {
            cash += currentValue;
            final tradePnl = (currentClose - entryPrice) * shares;
            trades.add({
              'symbol': symbol,
              'type': 'SELL',
              'entryPrice': entryPrice,
              'exitPrice': currentClose,
              'shares': shares,
              'pnl': tradePnl,
              'entryDate': data[0]['timestamp'].toString(),
              'exitDate': data[day]['timestamp'].toString(),
              'reason': closeReason,
            });
            positions.remove(positionKey);
          }
        } else if (strategy == 'buy_and_hold' || isBuySignal(prevClose, currentClose, strategy)) {
          final shares = perSymbolAllocation / currentClose;
          final cost = shares * currentClose;
          if (cost <= cash && shares > 0) {
            cash -= cost;
            positions[positionKey] = {
              'entryPrice': currentClose,
              'shares': shares,
            };
            trades.add({
              'symbol': symbol,
              'type': 'BUY',
              'entryPrice': currentClose,
              'exitPrice': null,
              'shares': shares,
              'pnl': null,
              'entryDate': data[day]['timestamp'].toString(),
              'exitDate': null,
              'reason': '',
            });
          }
        }
      }

      double totalEquity = cash;
      for (final pos in positions.values) {
        final symbol = allData.keys.firstWhere(
          (s) => positions[s] == pos,
          orElse: () => '',
        );
        if (symbol.isNotEmpty && day < allData[symbol]!.length) {
          final close = (allData[symbol]![day]['close'] as num).toDouble();
          totalEquity += (pos['shares'] as double) * close;
        }
      }
      equityCurve.add(totalEquity);
      if (totalEquity > peakEquity) peakEquity = totalEquity;
      final drawdown = (peakEquity - totalEquity) / peakEquity;
      if (drawdown > maxDrawdown) maxDrawdown = drawdown;
    }

    for (final pos in positions.entries) {
      final sym = pos.key;
      final lastClose = (allData[sym]!.last['close'] as num).toDouble();
      cash += (pos.value['shares'] as double) * lastClose;
    }

    return _buildResult(strategy, startDate, endDate, initialCapital, cash, maxDrawdown, trades);
  }

  bool isBuySignal(double prevClose, double currentClose, String strategy) {
    switch (strategy) {
      case 'momentum':
        return currentClose > prevClose;
      case 'mean_reversion':
        return currentClose < prevClose;
      case 'buy_and_hold':
      default:
        return true;
    }
  }

  Map<String, dynamic> _buildResult(
    String strategy,
    DateTime startDate,
    DateTime endDate,
    double initialCapital,
    double finalCapital,
    double maxDrawdown,
    List<Map<String, dynamic>> trades,
  ) {
    final closedTrades = trades.where((t) => t['pnl'] != null).toList();
    final wins = closedTrades.where((t) => (t['pnl'] as double) > 0).length;
    final losses = closedTrades.where((t) => (t['pnl'] as double) <= 0).length;
    final totalReturn = finalCapital - initialCapital;
    final totalReturnPercent = (totalReturn / initialCapital) * 100;
    final winRate = closedTrades.isNotEmpty ? wins / closedTrades.length : 0.0;
    final avgWin = closedTrades.where((t) => (t['pnl'] as double) > 0).fold<double>(0, (s, t) => s + (t['pnl'] as double));
    final avgLoss = closedTrades.where((t) => (t['pnl'] as double) <= 0).fold<double>(0, (s, t) => s + (t['pnl'] as double).abs());
    final profitFactor = avgLoss != 0 ? avgWin / avgLoss : (avgWin > 0 ? double.infinity : 0);

    return {
      'strategy': strategy,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'initialCapital': initialCapital,
      'finalCapital': finalCapital,
      'totalReturn': totalReturn,
      'totalReturnPercent': double.parse(totalReturnPercent.toStringAsFixed(2)),
      'maxDrawdown': maxDrawdown,
      'maxDrawdownPercent': double.parse((maxDrawdown * 100).toStringAsFixed(2)),
      'totalTrades': trades.length,
      'winningTrades': wins,
      'losingTrades': losses,
      'winRate': double.parse((winRate * 100).toStringAsFixed(2)),
      'avgWin': avgWin,
      'avgLoss': avgLoss,
      'profitFactor': double.parse(profitFactor.toStringAsFixed(2)),
      'symbols': trades.map((t) => t['symbol'] as String).toSet().join(','),
    };
  }
}
