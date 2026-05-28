// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarningsEventImpl _$$EarningsEventImplFromJson(Map<String, dynamic> json) =>
    _$EarningsEventImpl(
      id: (json['id'] as num?)?.toInt(),
      symbol: json['symbol'] as String,
      reportDate: DateTime.parse(json['reportDate'] as String),
      estimatedEps: (json['estimatedEps'] as num?)?.toDouble(),
      actualEps: (json['actualEps'] as num?)?.toDouble(),
      surprise: (json['surprise'] as num?)?.toDouble(),
      surprisePercent: (json['surprisePercent'] as num?)?.toDouble(),
      period: json['period'] as String? ?? '',
    );

Map<String, dynamic> _$$EarningsEventImplToJson(_$EarningsEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'reportDate': instance.reportDate.toIso8601String(),
      'estimatedEps': instance.estimatedEps,
      'actualEps': instance.actualEps,
      'surprise': instance.surprise,
      'surprisePercent': instance.surprisePercent,
      'period': instance.period,
    };
