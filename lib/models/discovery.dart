import 'package:freezed_annotation/freezed_annotation.dart';

part 'discovery.freezed.dart';
part 'discovery.g.dart';

@freezed
class Discovery with _$Discovery {
  const factory Discovery({
    int? id,
    required String symbol,
    required String companyName,
    required String reason,
    required String strategy,
    required double currentPrice,
    required double confidence,
    required DateTime discoveredAt,
    @Default(false) bool isPromoted,
    @Default(false) bool isDismissed,
    double? potentialUpside,
  }) = _Discovery;

  factory Discovery.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryFromJson(json);
}
