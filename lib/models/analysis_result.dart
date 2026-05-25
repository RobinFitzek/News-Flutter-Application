import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    int? id,
    required String symbol,
    required double predictedPrice,
    required double confidence,
    required String recommendation,
    required String reasoning,
    @Default('') String newsSummary,
    @Default('daily') String timeframe,
    required double currentPrice,
    DateTime? createdAt,
  }) = _AnalysisResult;

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);
}
