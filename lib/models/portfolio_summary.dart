import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_summary.freezed.dart';
part 'portfolio_summary.g.dart';

@freezed
class PortfolioSummary with _$PortfolioSummary {
  const factory PortfolioSummary({
    required double totalMarketValue,
    required double totalCostBasis,
    required double totalUnrealizedPnl,
    required double totalUnrealizedPnlPercent,
    required double paperCashBalance,
    required double paperPortfolioValue,
    required double paperTotalPnl,
    @Default(0) int openPositionsCount,
    @Default(0) int openPaperTradesCount,
  }) = _PortfolioSummary;

  factory PortfolioSummary.fromJson(Map<String, dynamic> json) =>
      _$PortfolioSummaryFromJson(json);
}
