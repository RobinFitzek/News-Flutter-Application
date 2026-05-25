// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insider_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InsiderTransactionImpl _$$InsiderTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$InsiderTransactionImpl(
  id: (json['id'] as num?)?.toInt(),
  symbol: json['symbol'] as String,
  insiderName: json['insiderName'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
  shares: (json['shares'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
  totalValue: (json['totalValue'] as num).toDouble(),
  filingDate: DateTime.parse(json['filingDate'] as String),
  transactionDate: DateTime.parse(json['transactionDate'] as String),
);

Map<String, dynamic> _$$InsiderTransactionImplToJson(
  _$InsiderTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'insiderName': instance.insiderName,
  'title': instance.title,
  'type': instance.type,
  'shares': instance.shares,
  'price': instance.price,
  'totalValue': instance.totalValue,
  'filingDate': instance.filingDate.toIso8601String(),
  'transactionDate': instance.transactionDate.toIso8601String(),
};
