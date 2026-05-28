// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backtest_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BacktestResultImpl _$$BacktestResultImplFromJson(Map<String, dynamic> json) =>
    _$BacktestResultImpl(
      id: (json['id'] as num?)?.toInt(),
      strategy: json['strategy'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      initialCapital: (json['initialCapital'] as num).toDouble(),
      finalCapital: (json['finalCapital'] as num).toDouble(),
      totalReturn: (json['totalReturn'] as num).toDouble(),
      totalReturnPercent: (json['totalReturnPercent'] as num).toDouble(),
      maxDrawdown: (json['maxDrawdown'] as num).toDouble(),
      maxDrawdownPercent: (json['maxDrawdownPercent'] as num).toDouble(),
      totalTrades: (json['totalTrades'] as num).toInt(),
      winningTrades: (json['winningTrades'] as num).toInt(),
      losingTrades: (json['losingTrades'] as num).toInt(),
      winRate: (json['winRate'] as num).toDouble(),
      avgWin: (json['avgWin'] as num).toDouble(),
      avgLoss: (json['avgLoss'] as num).toDouble(),
      profitFactor: (json['profitFactor'] as num).toDouble(),
      symbols: (json['symbols'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BacktestResultImplToJson(
  _$BacktestResultImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'strategy': instance.strategy,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'initialCapital': instance.initialCapital,
  'finalCapital': instance.finalCapital,
  'totalReturn': instance.totalReturn,
  'totalReturnPercent': instance.totalReturnPercent,
  'maxDrawdown': instance.maxDrawdown,
  'maxDrawdownPercent': instance.maxDrawdownPercent,
  'totalTrades': instance.totalTrades,
  'winningTrades': instance.winningTrades,
  'losingTrades': instance.losingTrades,
  'winRate': instance.winRate,
  'avgWin': instance.avgWin,
  'avgLoss': instance.avgLoss,
  'profitFactor': instance.profitFactor,
  'symbols': instance.symbols,
  'createdAt': instance.createdAt?.toIso8601String(),
};
