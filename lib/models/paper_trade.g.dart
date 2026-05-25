// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaperTradeImpl _$$PaperTradeImplFromJson(Map<String, dynamic> json) =>
    _$PaperTradeImpl(
      id: (json['id'] as num?)?.toInt(),
      symbol: json['symbol'] as String,
      type: json['type'] as String,
      shares: (json['shares'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      executedAt: DateTime.parse(json['executedAt'] as String),
      status: json['status'] as String? ?? 'OPEN',
      exitReason: json['exitReason'] as String?,
      exitPrice: (json['exitPrice'] as num?)?.toDouble(),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
      realizedPnl: (json['realizedPnl'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PaperTradeImplToJson(_$PaperTradeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'type': instance.type,
      'shares': instance.shares,
      'price': instance.price,
      'executedAt': instance.executedAt.toIso8601String(),
      'status': instance.status,
      'exitReason': instance.exitReason,
      'exitPrice': instance.exitPrice,
      'closedAt': instance.closedAt?.toIso8601String(),
      'realizedPnl': instance.realizedPnl,
    };
