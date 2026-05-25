import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_prediction.freezed.dart';
part 'stock_prediction.g.dart';

@freezed
class StockPrediction with _$StockPrediction {
  const factory StockPrediction({
    required String symbol,
    required double predictedPrice,
    required double confidence,
    required DateTime timestamp,
    required TimeFrame timeframe,
  }) = _StockPrediction;

  factory StockPrediction.fromJson(Map<String, dynamic> json) =>
      _$StockPredictionFromJson(json);
}

enum TimeFrame { daily, weekly, monthly }
