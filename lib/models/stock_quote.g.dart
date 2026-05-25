// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockQuoteImpl _$$StockQuoteImplFromJson(Map<String, dynamic> json) =>
    _$StockQuoteImpl(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      previousClose: (json['previousClose'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      dayHigh: (json['dayHigh'] as num).toDouble(),
      dayLow: (json['dayLow'] as num).toDouble(),
      volume: (json['volume'] as num).toInt(),
      marketCap: (json['marketCap'] as num?)?.toDouble() ?? null,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$StockQuoteImplToJson(_$StockQuoteImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'currentPrice': instance.currentPrice,
      'previousClose': instance.previousClose,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'dayHigh': instance.dayHigh,
      'dayLow': instance.dayLow,
      'volume': instance.volume,
      'marketCap': instance.marketCap,
      'timestamp': instance.timestamp.toIso8601String(),
    };
