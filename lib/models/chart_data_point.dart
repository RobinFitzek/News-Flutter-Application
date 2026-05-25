import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data_point.freezed.dart';
part 'chart_data_point.g.dart';

@freezed
class ChartDataPoint with _$ChartDataPoint {
  const factory ChartDataPoint({
    required DateTime timestamp,
    required double open,
    required double high,
    required double low,
    required double close,
    required int volume,
  }) = _ChartDataPoint;

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointFromJson(json);
}
