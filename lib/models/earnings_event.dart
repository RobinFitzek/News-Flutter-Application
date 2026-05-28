import 'package:freezed_annotation/freezed_annotation.dart';

part 'earnings_event.freezed.dart';
part 'earnings_event.g.dart';

@freezed
class EarningsEvent with _$EarningsEvent {
  const factory EarningsEvent({
    int? id,
    required String symbol,
    required DateTime reportDate,
    double? estimatedEps,
    double? actualEps,
    double? surprise,
    double? surprisePercent,
    @Default('') String period,
  }) = _EarningsEvent;

  factory EarningsEvent.fromJson(Map<String, dynamic> json) =>
      _$EarningsEventFromJson(json);
}
