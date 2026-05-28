import 'package:freezed_annotation/freezed_annotation.dart';

part 'institutional_holder.freezed.dart';
part 'institutional_holder.g.dart';

@freezed
class InstitutionalHolder with _$InstitutionalHolder {
  const factory InstitutionalHolder({
    int? id,
    required String symbol,
    required String holderName,
    required double shares,
    required double value,
    required double percentOut,
    required DateTime reportDate,
    double? change,
  }) = _InstitutionalHolder;

  factory InstitutionalHolder.fromJson(Map<String, dynamic> json) =>
      _$InstitutionalHolderFromJson(json);
}
