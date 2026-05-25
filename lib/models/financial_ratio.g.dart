// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_ratio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinancialRatioImpl _$$FinancialRatioImplFromJson(Map<String, dynamic> json) =>
    _$FinancialRatioImpl(
      id: (json['id'] as num?)?.toInt(),
      symbol: json['symbol'] as String,
      peRatio: (json['peRatio'] as num?)?.toDouble(),
      pbRatio: (json['pbRatio'] as num?)?.toDouble(),
      eps: (json['eps'] as num?)?.toDouble(),
      dividendYield: (json['dividendYield'] as num?)?.toDouble(),
      beta: (json['beta'] as num?)?.toDouble(),
      week52High: json['week52High'] as String? ?? '',
      week52Low: json['week52Low'] as String? ?? '',
      marketCap: (json['marketCap'] as num?)?.toDouble(),
      revenueGrowth: (json['revenueGrowth'] as num?)?.toDouble(),
      profitMargin: (json['profitMargin'] as num?)?.toDouble(),
      debtToEquity: (json['debtToEquity'] as num?)?.toDouble(),
      roe: (json['roe'] as num?)?.toDouble(),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FinancialRatioImplToJson(
  _$FinancialRatioImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'peRatio': instance.peRatio,
  'pbRatio': instance.pbRatio,
  'eps': instance.eps,
  'dividendYield': instance.dividendYield,
  'beta': instance.beta,
  'week52High': instance.week52High,
  'week52Low': instance.week52Low,
  'marketCap': instance.marketCap,
  'revenueGrowth': instance.revenueGrowth,
  'profitMargin': instance.profitMargin,
  'debtToEquity': instance.debtToEquity,
  'roe': instance.roe,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
