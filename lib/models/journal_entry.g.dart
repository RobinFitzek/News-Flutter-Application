// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JournalEntryImpl _$$JournalEntryImplFromJson(Map<String, dynamic> json) =>
    _$JournalEntryImpl(
      id: (json['id'] as num?)?.toInt(),
      symbol: json['symbol'] as String,
      type: json['type'] as String,
      entryPrice: (json['entryPrice'] as num).toDouble(),
      exitPrice: (json['exitPrice'] as num?)?.toDouble(),
      shares: (json['shares'] as num?)?.toDouble(),
      pnl: (json['pnl'] as num?)?.toDouble(),
      entryDate: DateTime.parse(json['entryDate'] as String),
      exitDate: json['exitDate'] == null
          ? null
          : DateTime.parse(json['exitDate'] as String),
      notes: json['notes'] as String,
      mood: json['mood'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
      isClosed: json['isClosed'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$JournalEntryImplToJson(_$JournalEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'type': instance.type,
      'entryPrice': instance.entryPrice,
      'exitPrice': instance.exitPrice,
      'shares': instance.shares,
      'pnl': instance.pnl,
      'entryDate': instance.entryDate.toIso8601String(),
      'exitDate': instance.exitDate?.toIso8601String(),
      'notes': instance.notes,
      'mood': instance.mood,
      'tags': instance.tags,
      'isClosed': instance.isClosed,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
