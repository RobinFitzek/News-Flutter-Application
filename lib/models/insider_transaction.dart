import 'package:freezed_annotation/freezed_annotation.dart';

part 'insider_transaction.freezed.dart';
part 'insider_transaction.g.dart';

@freezed
class InsiderTransaction with _$InsiderTransaction {
  const factory InsiderTransaction({
    int? id,
    required String symbol,
    required String insiderName,
    required String title,
    required String type,
    required double shares,
    required double price,
    required double totalValue,
    required DateTime filingDate,
    required DateTime transactionDate,
  }) = _InsiderTransaction;

  factory InsiderTransaction.fromJson(Map<String, dynamic> json) =>
      _$InsiderTransactionFromJson(json);
}
