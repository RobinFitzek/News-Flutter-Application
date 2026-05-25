// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WatchlistItemImpl _$$WatchlistItemImplFromJson(Map<String, dynamic> json) =>
    _$WatchlistItemImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      symbol: json['symbol'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      tier: json['tier'] as String? ?? 'core',
      note: json['note'] as String? ?? null,
      groupName: json['groupName'] as String? ?? null,
      lastPrice: (json['lastPrice'] as num?)?.toDouble() ?? null,
      lastPriceChange: (json['lastPriceChange'] as num?)?.toDouble() ?? null,
    );

Map<String, dynamic> _$$WatchlistItemImplToJson(_$WatchlistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'addedAt': instance.addedAt.toIso8601String(),
      'tier': instance.tier,
      'note': instance.note,
      'groupName': instance.groupName,
      'lastPrice': instance.lastPrice,
      'lastPriceChange': instance.lastPriceChange,
    };
