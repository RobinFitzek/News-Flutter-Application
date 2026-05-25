import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_entry.freezed.dart';
part 'journal_entry.g.dart';

@freezed
class JournalEntry with _$JournalEntry {
  const factory JournalEntry({
    int? id,
    required String symbol,
    required String type,
    required double entryPrice,
    double? exitPrice,
    double? shares,
    double? pnl,
    required DateTime entryDate,
    DateTime? exitDate,
    required String notes,
    @Default('') String mood,
    @Default('') String tags,
    @Default(false) bool isClosed,
    DateTime? createdAt,
  }) = _JournalEntry;

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);
}
