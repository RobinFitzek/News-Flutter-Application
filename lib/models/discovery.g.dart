// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscoveryImpl _$$DiscoveryImplFromJson(Map<String, dynamic> json) =>
    _$DiscoveryImpl(
      id: (json['id'] as num?)?.toInt(),
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      reason: json['reason'] as String,
      strategy: json['strategy'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      discoveredAt: DateTime.parse(json['discoveredAt'] as String),
      isPromoted: json['isPromoted'] as bool? ?? false,
      isDismissed: json['isDismissed'] as bool? ?? false,
      potentialUpside: (json['potentialUpside'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DiscoveryImplToJson(_$DiscoveryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'reason': instance.reason,
      'strategy': instance.strategy,
      'currentPrice': instance.currentPrice,
      'confidence': instance.confidence,
      'discoveredAt': instance.discoveredAt.toIso8601String(),
      'isPromoted': instance.isPromoted,
      'isDismissed': instance.isDismissed,
      'potentialUpside': instance.potentialUpside,
    };
