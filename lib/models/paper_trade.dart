import 'package:freezed_annotation/freezed_annotation.dart';

part 'paper_trade.freezed.dart';
part 'paper_trade.g.dart';

@freezed
class PaperTrade with _$PaperTrade {
  const factory PaperTrade({
    int? id,
    required String symbol,
    required String type,
    required double shares,
    required double price,
    required DateTime executedAt,
    @Default('OPEN') String status,
    String? exitReason,
    double? exitPrice,
    DateTime? closedAt,
    double? realizedPnl,
  }) = _PaperTrade;

  factory PaperTrade.fromJson(Map<String, dynamic> json) =>
      _$PaperTradeFromJson(json);
}

extension PaperTradeX on PaperTrade {
  bool get isOpen => status == 'OPEN';
}
