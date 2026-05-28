// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paper_trade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaperTrade _$PaperTradeFromJson(Map<String, dynamic> json) {
  return _PaperTrade.fromJson(json);
}

/// @nodoc
mixin _$PaperTrade {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get shares => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  DateTime get executedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get exitReason => throw _privateConstructorUsedError;
  double? get exitPrice => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  double? get realizedPnl => throw _privateConstructorUsedError;

  /// Serializes this PaperTrade to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaperTrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaperTradeCopyWith<PaperTrade> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaperTradeCopyWith<$Res> {
  factory $PaperTradeCopyWith(
    PaperTrade value,
    $Res Function(PaperTrade) then,
  ) = _$PaperTradeCopyWithImpl<$Res, PaperTrade>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    String type,
    double shares,
    double price,
    DateTime executedAt,
    String status,
    String? exitReason,
    double? exitPrice,
    DateTime? closedAt,
    double? realizedPnl,
  });
}

/// @nodoc
class _$PaperTradeCopyWithImpl<$Res, $Val extends PaperTrade>
    implements $PaperTradeCopyWith<$Res> {
  _$PaperTradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaperTrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? type = null,
    Object? shares = null,
    Object? price = null,
    Object? executedAt = null,
    Object? status = null,
    Object? exitReason = freezed,
    Object? exitPrice = freezed,
    Object? closedAt = freezed,
    Object? realizedPnl = freezed,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            shares: null == shares
                ? _value.shares
                : shares // ignore: cast_nullable_to_non_nullable
                      as double,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            executedAt: null == executedAt
                ? _value.executedAt
                : executedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            exitReason: freezed == exitReason
                ? _value.exitReason
                : exitReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            exitPrice: freezed == exitPrice
                ? _value.exitPrice
                : exitPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            closedAt: freezed == closedAt
                ? _value.closedAt
                : closedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            realizedPnl: freezed == realizedPnl
                ? _value.realizedPnl
                : realizedPnl // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaperTradeImplCopyWith<$Res>
    implements $PaperTradeCopyWith<$Res> {
  factory _$$PaperTradeImplCopyWith(
    _$PaperTradeImpl value,
    $Res Function(_$PaperTradeImpl) then,
  ) = __$$PaperTradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    String type,
    double shares,
    double price,
    DateTime executedAt,
    String status,
    String? exitReason,
    double? exitPrice,
    DateTime? closedAt,
    double? realizedPnl,
  });
}

/// @nodoc
class __$$PaperTradeImplCopyWithImpl<$Res>
    extends _$PaperTradeCopyWithImpl<$Res, _$PaperTradeImpl>
    implements _$$PaperTradeImplCopyWith<$Res> {
  __$$PaperTradeImplCopyWithImpl(
    _$PaperTradeImpl _value,
    $Res Function(_$PaperTradeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaperTrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? type = null,
    Object? shares = null,
    Object? price = null,
    Object? executedAt = null,
    Object? status = null,
    Object? exitReason = freezed,
    Object? exitPrice = freezed,
    Object? closedAt = freezed,
    Object? realizedPnl = freezed,
  }) {
    return _then(
      _$PaperTradeImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        shares: null == shares
            ? _value.shares
            : shares // ignore: cast_nullable_to_non_nullable
                  as double,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        executedAt: null == executedAt
            ? _value.executedAt
            : executedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        exitReason: freezed == exitReason
            ? _value.exitReason
            : exitReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        exitPrice: freezed == exitPrice
            ? _value.exitPrice
            : exitPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        closedAt: freezed == closedAt
            ? _value.closedAt
            : closedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        realizedPnl: freezed == realizedPnl
            ? _value.realizedPnl
            : realizedPnl // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaperTradeImpl implements _PaperTrade {
  const _$PaperTradeImpl({
    this.id,
    required this.symbol,
    required this.type,
    required this.shares,
    required this.price,
    required this.executedAt,
    this.status = 'OPEN',
    this.exitReason,
    this.exitPrice,
    this.closedAt,
    this.realizedPnl,
  });

  factory _$PaperTradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaperTradeImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final String type;
  @override
  final double shares;
  @override
  final double price;
  @override
  final DateTime executedAt;
  @override
  @JsonKey()
  final String status;
  @override
  final String? exitReason;
  @override
  final double? exitPrice;
  @override
  final DateTime? closedAt;
  @override
  final double? realizedPnl;

  @override
  String toString() {
    return 'PaperTrade(id: $id, symbol: $symbol, type: $type, shares: $shares, price: $price, executedAt: $executedAt, status: $status, exitReason: $exitReason, exitPrice: $exitPrice, closedAt: $closedAt, realizedPnl: $realizedPnl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaperTradeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.executedAt, executedAt) ||
                other.executedAt == executedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.exitReason, exitReason) ||
                other.exitReason == exitReason) &&
            (identical(other.exitPrice, exitPrice) ||
                other.exitPrice == exitPrice) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.realizedPnl, realizedPnl) ||
                other.realizedPnl == realizedPnl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    type,
    shares,
    price,
    executedAt,
    status,
    exitReason,
    exitPrice,
    closedAt,
    realizedPnl,
  );

  /// Create a copy of PaperTrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaperTradeImplCopyWith<_$PaperTradeImpl> get copyWith =>
      __$$PaperTradeImplCopyWithImpl<_$PaperTradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaperTradeImplToJson(this);
  }
}

abstract class _PaperTrade implements PaperTrade {
  const factory _PaperTrade({
    final int? id,
    required final String symbol,
    required final String type,
    required final double shares,
    required final double price,
    required final DateTime executedAt,
    final String status,
    final String? exitReason,
    final double? exitPrice,
    final DateTime? closedAt,
    final double? realizedPnl,
  }) = _$PaperTradeImpl;

  factory _PaperTrade.fromJson(Map<String, dynamic> json) =
      _$PaperTradeImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  String get type;
  @override
  double get shares;
  @override
  double get price;
  @override
  DateTime get executedAt;
  @override
  String get status;
  @override
  String? get exitReason;
  @override
  double? get exitPrice;
  @override
  DateTime? get closedAt;
  @override
  double? get realizedPnl;

  /// Create a copy of PaperTrade
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaperTradeImplCopyWith<_$PaperTradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
