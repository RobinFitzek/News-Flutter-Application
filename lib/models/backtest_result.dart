import 'package:freezed_annotation/freezed_annotation.dart';

part 'backtest_result.freezed.dart';
part 'backtest_result.g.dart';

@freezed
class BacktestResult with _$BacktestResult {
  const factory BacktestResult({
    int? id,
    required String strategy,
    required DateTime startDate,
    required DateTime endDate,
    required double initialCapital,
    required double finalCapital,
    required double totalReturn,
    required double totalReturnPercent,
    required double maxDrawdown,
    required double maxDrawdownPercent,
    required int totalTrades,
    required int winningTrades,
    required int losingTrades,
    required double winRate,
    required double avgWin,
    required double avgLoss,
    required double profitFactor,
    required List<String> symbols,
    DateTime? createdAt,
  }) = _BacktestResult;

  factory BacktestResult.fromJson(Map<String, dynamic> json) =>
      _$BacktestResultFromJson(json);
}
