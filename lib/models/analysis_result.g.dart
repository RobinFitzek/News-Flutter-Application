// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalysisResultImpl _$$AnalysisResultImplFromJson(Map<String, dynamic> json) =>
    _$AnalysisResultImpl(
      id: (json['id'] as num?)?.toInt(),
      symbol: json['symbol'] as String,
      predictedPrice: (json['predictedPrice'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
      reasoning: json['reasoning'] as String,
      newsSummary: json['newsSummary'] as String? ?? '',
      timeframe: json['timeframe'] as String? ?? 'daily',
      currentPrice: (json['currentPrice'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AnalysisResultImplToJson(
  _$AnalysisResultImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'predictedPrice': instance.predictedPrice,
  'confidence': instance.confidence,
  'recommendation': instance.recommendation,
  'reasoning': instance.reasoning,
  'newsSummary': instance.newsSummary,
  'timeframe': instance.timeframe,
  'currentPrice': instance.currentPrice,
  'createdAt': instance.createdAt?.toIso8601String(),
};
