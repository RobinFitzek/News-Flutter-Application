import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_ratio.freezed.dart';
part 'financial_ratio.g.dart';

@freezed
class FinancialRatio with _$FinancialRatio {
  const factory FinancialRatio({
    int? id,
    required String symbol,
    double? peRatio,
    double? pbRatio,
    double? eps,
    double? dividendYield,
    double? beta,
    @Default('') String week52High,
    @Default('') String week52Low,
    double? marketCap,
    double? revenueGrowth,
    double? profitMargin,
    double? debtToEquity,
    double? roe,
    DateTime? updatedAt,
  }) = _FinancialRatio;

  factory FinancialRatio.fromJson(Map<String, dynamic> json) =>
      _$FinancialRatioFromJson(json);
}
