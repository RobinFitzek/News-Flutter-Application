// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PortfolioPosition _$PortfolioPositionFromJson(Map<String, dynamic> json) {
  return _PortfolioPosition.fromJson(json);
}

/// @nodoc
mixin _$PortfolioPosition {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  double get shares => throw _privateConstructorUsedError;
  double get avgCostBasis => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  DateTime get acquiredAt => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this PortfolioPosition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioPositionCopyWith<PortfolioPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioPositionCopyWith<$Res> {
  factory $PortfolioPositionCopyWith(
    PortfolioPosition value,
    $Res Function(PortfolioPosition) then,
  ) = _$PortfolioPositionCopyWithImpl<$Res, PortfolioPosition>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    String companyName,
    double shares,
    double avgCostBasis,
    double currentPrice,
    DateTime acquiredAt,
    String currency,
    String? note,
  });
}

/// @nodoc
class _$PortfolioPositionCopyWithImpl<$Res, $Val extends PortfolioPosition>
    implements $PortfolioPositionCopyWith<$Res> {
  _$PortfolioPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? companyName = null,
    Object? shares = null,
    Object? avgCostBasis = null,
    Object? currentPrice = null,
    Object? acquiredAt = null,
    Object? currency = null,
    Object? note = freezed,
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
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            shares: null == shares
                ? _value.shares
                : shares // ignore: cast_nullable_to_non_nullable
                      as double,
            avgCostBasis: null == avgCostBasis
                ? _value.avgCostBasis
                : avgCostBasis // ignore: cast_nullable_to_non_nullable
                      as double,
            currentPrice: null == currentPrice
                ? _value.currentPrice
                : currentPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            acquiredAt: null == acquiredAt
                ? _value.acquiredAt
                : acquiredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PortfolioPositionImplCopyWith<$Res>
    implements $PortfolioPositionCopyWith<$Res> {
  factory _$$PortfolioPositionImplCopyWith(
    _$PortfolioPositionImpl value,
    $Res Function(_$PortfolioPositionImpl) then,
  ) = __$$PortfolioPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    String companyName,
    double shares,
    double avgCostBasis,
    double currentPrice,
    DateTime acquiredAt,
    String currency,
    String? note,
  });
}

/// @nodoc
class __$$PortfolioPositionImplCopyWithImpl<$Res>
    extends _$PortfolioPositionCopyWithImpl<$Res, _$PortfolioPositionImpl>
    implements _$$PortfolioPositionImplCopyWith<$Res> {
  __$$PortfolioPositionImplCopyWithImpl(
    _$PortfolioPositionImpl _value,
    $Res Function(_$PortfolioPositionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PortfolioPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? companyName = null,
    Object? shares = null,
    Object? avgCostBasis = null,
    Object? currentPrice = null,
    Object? acquiredAt = null,
    Object? currency = null,
    Object? note = freezed,
  }) {
    return _then(
      _$PortfolioPositionImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        shares: null == shares
            ? _value.shares
            : shares // ignore: cast_nullable_to_non_nullable
                  as double,
        avgCostBasis: null == avgCostBasis
            ? _value.avgCostBasis
            : avgCostBasis // ignore: cast_nullable_to_non_nullable
                  as double,
        currentPrice: null == currentPrice
            ? _value.currentPrice
            : currentPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        acquiredAt: null == acquiredAt
            ? _value.acquiredAt
            : acquiredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioPositionImpl implements _PortfolioPosition {
  const _$PortfolioPositionImpl({
    this.id,
    required this.symbol,
    required this.companyName,
    required this.shares,
    required this.avgCostBasis,
    this.currentPrice = 0.0,
    required this.acquiredAt,
    this.currency = 'USD',
    this.note,
  });

  factory _$PortfolioPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioPositionImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final double shares;
  @override
  final double avgCostBasis;
  @override
  @JsonKey()
  final double currentPrice;
  @override
  final DateTime acquiredAt;
  @override
  @JsonKey()
  final String currency;
  @override
  final String? note;

  @override
  String toString() {
    return 'PortfolioPosition(id: $id, symbol: $symbol, companyName: $companyName, shares: $shares, avgCostBasis: $avgCostBasis, currentPrice: $currentPrice, acquiredAt: $acquiredAt, currency: $currency, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioPositionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.avgCostBasis, avgCostBasis) ||
                other.avgCostBasis == avgCostBasis) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.acquiredAt, acquiredAt) ||
                other.acquiredAt == acquiredAt) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    companyName,
    shares,
    avgCostBasis,
    currentPrice,
    acquiredAt,
    currency,
    note,
  );

  /// Create a copy of PortfolioPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioPositionImplCopyWith<_$PortfolioPositionImpl> get copyWith =>
      __$$PortfolioPositionImplCopyWithImpl<_$PortfolioPositionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioPositionImplToJson(this);
  }
}

abstract class _PortfolioPosition implements PortfolioPosition {
  const factory _PortfolioPosition({
    final int? id,
    required final String symbol,
    required final String companyName,
    required final double shares,
    required final double avgCostBasis,
    final double currentPrice,
    required final DateTime acquiredAt,
    final String currency,
    final String? note,
  }) = _$PortfolioPositionImpl;

  factory _PortfolioPosition.fromJson(Map<String, dynamic> json) =
      _$PortfolioPositionImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  String get companyName;
  @override
  double get shares;
  @override
  double get avgCostBasis;
  @override
  double get currentPrice;
  @override
  DateTime get acquiredAt;
  @override
  String get currency;
  @override
  String? get note;

  /// Create a copy of PortfolioPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioPositionImplCopyWith<_$PortfolioPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
