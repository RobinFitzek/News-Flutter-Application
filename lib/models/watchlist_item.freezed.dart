// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WatchlistItem _$WatchlistItemFromJson(Map<String, dynamic> json) {
  return _WatchlistItem.fromJson(json);
}

/// @nodoc
mixin _$WatchlistItem {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  DateTime get addedAt => throw _privateConstructorUsedError;
  String get tier => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;
  double? get lastPrice => throw _privateConstructorUsedError;
  double? get lastPriceChange => throw _privateConstructorUsedError;

  /// Serializes this WatchlistItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WatchlistItemCopyWith<WatchlistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchlistItemCopyWith<$Res> {
  factory $WatchlistItemCopyWith(
    WatchlistItem value,
    $Res Function(WatchlistItem) then,
  ) = _$WatchlistItemCopyWithImpl<$Res, WatchlistItem>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    DateTime addedAt,
    String tier,
    String? note,
    String? groupName,
    double? lastPrice,
    double? lastPriceChange,
  });
}

/// @nodoc
class _$WatchlistItemCopyWithImpl<$Res, $Val extends WatchlistItem>
    implements $WatchlistItemCopyWith<$Res> {
  _$WatchlistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? addedAt = null,
    Object? tier = null,
    Object? note = freezed,
    Object? groupName = freezed,
    Object? lastPrice = freezed,
    Object? lastPriceChange = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            symbol: null == symbol
                ? _value.symbol
                : symbol // ignore: cast_nullable_to_non_nullable
                      as String,
            addedAt: null == addedAt
                ? _value.addedAt
                : addedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as String,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            groupName: freezed == groupName
                ? _value.groupName
                : groupName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPrice: freezed == lastPrice
                ? _value.lastPrice
                : lastPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            lastPriceChange: freezed == lastPriceChange
                ? _value.lastPriceChange
                : lastPriceChange // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WatchlistItemImplCopyWith<$Res>
    implements $WatchlistItemCopyWith<$Res> {
  factory _$$WatchlistItemImplCopyWith(
    _$WatchlistItemImpl value,
    $Res Function(_$WatchlistItemImpl) then,
  ) = __$$WatchlistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    DateTime addedAt,
    String tier,
    String? note,
    String? groupName,
    double? lastPrice,
    double? lastPriceChange,
  });
}

/// @nodoc
class __$$WatchlistItemImplCopyWithImpl<$Res>
    extends _$WatchlistItemCopyWithImpl<$Res, _$WatchlistItemImpl>
    implements _$$WatchlistItemImplCopyWith<$Res> {
  __$$WatchlistItemImplCopyWithImpl(
    _$WatchlistItemImpl _value,
    $Res Function(_$WatchlistItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? addedAt = null,
    Object? tier = null,
    Object? note = freezed,
    Object? groupName = freezed,
    Object? lastPrice = freezed,
    Object? lastPriceChange = freezed,
  }) {
    return _then(
      _$WatchlistItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        addedAt: null == addedAt
            ? _value.addedAt
            : addedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        groupName: freezed == groupName
            ? _value.groupName
            : groupName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPrice: freezed == lastPrice
            ? _value.lastPrice
            : lastPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        lastPriceChange: freezed == lastPriceChange
            ? _value.lastPriceChange
            : lastPriceChange // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchlistItemImpl implements _WatchlistItem {
  const _$WatchlistItemImpl({
    this.id = null,
    required this.symbol,
    required this.addedAt,
    this.tier = 'core',
    this.note = null,
    this.groupName = null,
    this.lastPrice = null,
    this.lastPriceChange = null,
  });

  factory _$WatchlistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchlistItemImplFromJson(json);

  @override
  @JsonKey()
  final int? id;
  @override
  final String symbol;
  @override
  final DateTime addedAt;
  @override
  @JsonKey()
  final String tier;
  @override
  @JsonKey()
  final String? note;
  @override
  @JsonKey()
  final String? groupName;
  @override
  @JsonKey()
  final double? lastPrice;
  @override
  @JsonKey()
  final double? lastPriceChange;

  @override
  String toString() {
    return 'WatchlistItem(id: $id, symbol: $symbol, addedAt: $addedAt, tier: $tier, note: $note, groupName: $groupName, lastPrice: $lastPrice, lastPriceChange: $lastPriceChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchlistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.lastPrice, lastPrice) ||
                other.lastPrice == lastPrice) &&
            (identical(other.lastPriceChange, lastPriceChange) ||
                other.lastPriceChange == lastPriceChange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    addedAt,
    tier,
    note,
    groupName,
    lastPrice,
    lastPriceChange,
  );

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchlistItemImplCopyWith<_$WatchlistItemImpl> get copyWith =>
      __$$WatchlistItemImplCopyWithImpl<_$WatchlistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchlistItemImplToJson(this);
  }
}

abstract class _WatchlistItem implements WatchlistItem {
  const factory _WatchlistItem({
    final int? id,
    required final String symbol,
    required final DateTime addedAt,
    final String tier,
    final String? note,
    final String? groupName,
    final double? lastPrice,
    final double? lastPriceChange,
  }) = _$WatchlistItemImpl;

  factory _WatchlistItem.fromJson(Map<String, dynamic> json) =
      _$WatchlistItemImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  DateTime get addedAt;
  @override
  String get tier;
  @override
  String? get note;
  @override
  String? get groupName;
  @override
  double? get lastPrice;
  @override
  double? get lastPriceChange;

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchlistItemImplCopyWith<_$WatchlistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
