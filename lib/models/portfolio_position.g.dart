// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioPositionImpl _$$PortfolioPositionImplFromJson(
  Map<String, dynamic> json,
) => _$PortfolioPositionImpl(
  id: (json['id'] as num?)?.toInt(),
  symbol: json['symbol'] as String,
  companyName: json['companyName'] as String,
  shares: (json['shares'] as num).toDouble(),
  avgCostBasis: (json['avgCostBasis'] as num).toDouble(),
  currentPrice: (json['currentPrice'] as num?)?.toDouble() ?? 0.0,
  acquiredAt: DateTime.parse(json['acquiredAt'] as String),
  currency: json['currency'] as String? ?? 'USD',
  note: json['note'] as String?,
);

Map<String, dynamic> _$$PortfolioPositionImplToJson(
  _$PortfolioPositionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'companyName': instance.companyName,
  'shares': instance.shares,
  'avgCostBasis': instance.avgCostBasis,
  'currentPrice': instance.currentPrice,
  'acquiredAt': instance.acquiredAt.toIso8601String(),
  'currency': instance.currency,
  'note': instance.note,
};
