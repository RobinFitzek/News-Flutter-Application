import 'package:freezed_annotation/freezed_annotation.dart';
import 'chart_data_point.dart';

part 'chart_data.freezed.dart';
part 'chart_data.g.dart';

@freezed
class ChartData with _$ChartData {
  const factory ChartData({
    required String symbol,
    required List<ChartDataPoint> dataPoints,
  }) = _ChartData;

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);
}
