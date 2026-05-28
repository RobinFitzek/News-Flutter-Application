import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_position.freezed.dart';
part 'portfolio_position.g.dart';

@freezed
class PortfolioPosition with _$PortfolioPosition {
  const factory PortfolioPosition({
    int? id,
    required String symbol,
    required String companyName,
    required double shares,
    required double avgCostBasis,
    @Default(0.0) double currentPrice,
    required DateTime acquiredAt,
    @Default('USD') String currency,
    String? note,
  }) = _PortfolioPosition;

  factory PortfolioPosition.fromJson(Map<String, dynamic> json) =>
      _$PortfolioPositionFromJson(json);
}

extension PortfolioPositionX on PortfolioPosition {
  double get totalCost => shares * avgCostBasis;
  double get marketValue => shares * currentPrice;
  double get unrealizedPnl => marketValue - totalCost;
  double get unrealizedPnlPercent =>
      totalCost != 0 ? (unrealizedPnl / totalCost) * 100 : 0.0;
}
