import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_quote.freezed.dart';
part 'stock_quote.g.dart';

@freezed
class StockQuote with _$StockQuote {
  const factory StockQuote({
    required String symbol,
    required String companyName,
    required double currentPrice,
    required double previousClose,
    required double change,
    required double changePercent,
    required double dayHigh,
    required double dayLow,
    required int volume,
    @Default(null) double? marketCap,
    required DateTime timestamp,
  }) = _StockQuote;

  factory StockQuote.fromJson(Map<String, dynamic> json) =>
      _$StockQuoteFromJson(json);
}
