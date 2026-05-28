import 'package:freezed_annotation/freezed_annotation.dart';

part 'corporate_action.freezed.dart';
part 'corporate_action.g.dart';

@freezed
class CorporateAction with _$CorporateAction {
  const factory CorporateAction({
    int? id,
    required String symbol,
    required String type,
    required DateTime date,
    String? description,
    double? amount,
    @Default('') String currency,
  }) = _CorporateAction;

  factory CorporateAction.fromJson(Map<String, dynamic> json) =>
      _$CorporateActionFromJson(json);
}
