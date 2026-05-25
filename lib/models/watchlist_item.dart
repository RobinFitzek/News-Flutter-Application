import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_item.freezed.dart';
part 'watchlist_item.g.dart';

@freezed
class WatchlistItem with _$WatchlistItem {
  const factory WatchlistItem({
    @Default(null) int? id,
    required String symbol,
    required DateTime addedAt,
    @Default('core') String tier,
    @Default(null) String? note,
    @Default(null) String? groupName,
    @Default(null) double? lastPrice,
    @Default(null) double? lastPriceChange,
  }) = _WatchlistItem;

  factory WatchlistItem.fromJson(Map<String, dynamic> json) =>
      _$WatchlistItemFromJson(json);
}
