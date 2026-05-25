// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateActionImpl _$$CorporateActionImplFromJson(
  Map<String, dynamic> json,
) => _$CorporateActionImpl(
  id: (json['id'] as num?)?.toInt(),
  symbol: json['symbol'] as String,
  type: json['type'] as String,
  date: DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  currency: json['currency'] as String? ?? '',
);

Map<String, dynamic> _$$CorporateActionImplToJson(
  _$CorporateActionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'type': instance.type,
  'date': instance.date.toIso8601String(),
  'description': instance.description,
  'amount': instance.amount,
  'currency': instance.currency,
};
