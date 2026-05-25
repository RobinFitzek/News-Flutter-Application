// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockPredictionImpl _$$StockPredictionImplFromJson(
  Map<String, dynamic> json,
) => _$StockPredictionImpl(
  symbol: json['symbol'] as String,
  predictedPrice: (json['predictedPrice'] as num).toDouble(),
  confidence: (json['confidence'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  timeframe: $enumDecode(_$TimeFrameEnumMap, json['timeframe']),
);

Map<String, dynamic> _$$StockPredictionImplToJson(
  _$StockPredictionImpl instance,
) => <String, dynamic>{
  'symbol': instance.symbol,
  'predictedPrice': instance.predictedPrice,
  'confidence': instance.confidence,
  'timestamp': instance.timestamp.toIso8601String(),
  'timeframe': _$TimeFrameEnumMap[instance.timeframe]!,
};

const _$TimeFrameEnumMap = {
  TimeFrame.daily: 'daily',
  TimeFrame.weekly: 'weekly',
  TimeFrame.monthly: 'monthly',
};
