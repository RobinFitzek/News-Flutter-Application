// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institutional_holder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InstitutionalHolderImpl _$$InstitutionalHolderImplFromJson(
  Map<String, dynamic> json,
) => _$InstitutionalHolderImpl(
  id: (json['id'] as num?)?.toInt(),
  symbol: json['symbol'] as String,
  holderName: json['holderName'] as String,
  shares: (json['shares'] as num).toDouble(),
  value: (json['value'] as num).toDouble(),
  percentOut: (json['percentOut'] as num).toDouble(),
  reportDate: DateTime.parse(json['reportDate'] as String),
  change: (json['change'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$InstitutionalHolderImplToJson(
  _$InstitutionalHolderImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbol': instance.symbol,
  'holderName': instance.holderName,
  'shares': instance.shares,
  'value': instance.value,
  'percentOut': instance.percentOut,
  'reportDate': instance.reportDate.toIso8601String(),
  'change': instance.change,
};
