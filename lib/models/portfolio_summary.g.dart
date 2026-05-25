// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioSummaryImpl _$$PortfolioSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$PortfolioSummaryImpl(
  totalMarketValue: (json['totalMarketValue'] as num).toDouble(),
  totalCostBasis: (json['totalCostBasis'] as num).toDouble(),
  totalUnrealizedPnl: (json['totalUnrealizedPnl'] as num).toDouble(),
  totalUnrealizedPnlPercent: (json['totalUnrealizedPnlPercent'] as num)
      .toDouble(),
  paperCashBalance: (json['paperCashBalance'] as num).toDouble(),
  paperPortfolioValue: (json['paperPortfolioValue'] as num).toDouble(),
  paperTotalPnl: (json['paperTotalPnl'] as num).toDouble(),
  openPositionsCount: (json['openPositionsCount'] as num?)?.toInt() ?? 0,
  openPaperTradesCount: (json['openPaperTradesCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PortfolioSummaryImplToJson(
  _$PortfolioSummaryImpl instance,
) => <String, dynamic>{
  'totalMarketValue': instance.totalMarketValue,
  'totalCostBasis': instance.totalCostBasis,
  'totalUnrealizedPnl': instance.totalUnrealizedPnl,
  'totalUnrealizedPnlPercent': instance.totalUnrealizedPnlPercent,
  'paperCashBalance': instance.paperCashBalance,
  'paperPortfolioValue': instance.paperPortfolioValue,
  'paperTotalPnl': instance.paperTotalPnl,
  'openPositionsCount': instance.openPositionsCount,
  'openPaperTradesCount': instance.openPaperTradesCount,
};
