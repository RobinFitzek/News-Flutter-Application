// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_ratio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FinancialRatio _$FinancialRatioFromJson(Map<String, dynamic> json) {
  return _FinancialRatio.fromJson(json);
}

/// @nodoc
mixin _$FinancialRatio {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  double? get peRatio => throw _privateConstructorUsedError;
  double? get pbRatio => throw _privateConstructorUsedError;
  double? get eps => throw _privateConstructorUsedError;
  double? get dividendYield => throw _privateConstructorUsedError;
  double? get beta => throw _privateConstructorUsedError;
  String get week52High => throw _privateConstructorUsedError;
  String get week52Low => throw _privateConstructorUsedError;
  double? get marketCap => throw _privateConstructorUsedError;
  double? get revenueGrowth => throw _privateConstructorUsedError;
  double? get profitMargin => throw _privateConstructorUsedError;
  double? get debtToEquity => throw _privateConstructorUsedError;
  double? get roe => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FinancialRatio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinancialRatio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialRatioCopyWith<FinancialRatio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialRatioCopyWith<$Res> {
  factory $FinancialRatioCopyWith(
    FinancialRatio value,
    $Res Function(FinancialRatio) then,
  ) = _$FinancialRatioCopyWithImpl<$Res, FinancialRatio>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    double? peRatio,
    double? pbRatio,
    double? eps,
    double? dividendYield,
    double? beta,
    String week52High,
    String week52Low,
    double? marketCap,
    double? revenueGrowth,
    double? profitMargin,
    double? debtToEquity,
    double? roe,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$FinancialRatioCopyWithImpl<$Res, $Val extends FinancialRatio>
    implements $FinancialRatioCopyWith<$Res> {
  _$FinancialRatioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialRatio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? peRatio = freezed,
    Object? pbRatio = freezed,
    Object? eps = freezed,
    Object? dividendYield = freezed,
    Object? beta = freezed,
    Object? week52High = null,
    Object? week52Low = null,
    Object? marketCap = freezed,
    Object? revenueGrowth = freezed,
    Object? profitMargin = freezed,
    Object? debtToEquity = freezed,
    Object? roe = freezed,
    Object? updatedAt = freezed,
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
            peRatio: freezed == peRatio
                ? _value.peRatio
                : peRatio // ignore: cast_nullable_to_non_nullable
                      as double?,
            pbRatio: freezed == pbRatio
                ? _value.pbRatio
                : pbRatio // ignore: cast_nullable_to_non_nullable
                      as double?,
            eps: freezed == eps
                ? _value.eps
                : eps // ignore: cast_nullable_to_non_nullable
                      as double?,
            dividendYield: freezed == dividendYield
                ? _value.dividendYield
                : dividendYield // ignore: cast_nullable_to_non_nullable
                      as double?,
            beta: freezed == beta
                ? _value.beta
                : beta // ignore: cast_nullable_to_non_nullable
                      as double?,
            week52High: null == week52High
                ? _value.week52High
                : week52High // ignore: cast_nullable_to_non_nullable
                      as String,
            week52Low: null == week52Low
                ? _value.week52Low
                : week52Low // ignore: cast_nullable_to_non_nullable
                      as String,
            marketCap: freezed == marketCap
                ? _value.marketCap
                : marketCap // ignore: cast_nullable_to_non_nullable
                      as double?,
            revenueGrowth: freezed == revenueGrowth
                ? _value.revenueGrowth
                : revenueGrowth // ignore: cast_nullable_to_non_nullable
                      as double?,
            profitMargin: freezed == profitMargin
                ? _value.profitMargin
                : profitMargin // ignore: cast_nullable_to_non_nullable
                      as double?,
            debtToEquity: freezed == debtToEquity
                ? _value.debtToEquity
                : debtToEquity // ignore: cast_nullable_to_non_nullable
                      as double?,
            roe: freezed == roe
                ? _value.roe
                : roe // ignore: cast_nullable_to_non_nullable
                      as double?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FinancialRatioImplCopyWith<$Res>
    implements $FinancialRatioCopyWith<$Res> {
  factory _$$FinancialRatioImplCopyWith(
    _$FinancialRatioImpl value,
    $Res Function(_$FinancialRatioImpl) then,
  ) = __$$FinancialRatioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    double? peRatio,
    double? pbRatio,
    double? eps,
    double? dividendYield,
    double? beta,
    String week52High,
    String week52Low,
    double? marketCap,
    double? revenueGrowth,
    double? profitMargin,
    double? debtToEquity,
    double? roe,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$FinancialRatioImplCopyWithImpl<$Res>
    extends _$FinancialRatioCopyWithImpl<$Res, _$FinancialRatioImpl>
    implements _$$FinancialRatioImplCopyWith<$Res> {
  __$$FinancialRatioImplCopyWithImpl(
    _$FinancialRatioImpl _value,
    $Res Function(_$FinancialRatioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FinancialRatio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? peRatio = freezed,
    Object? pbRatio = freezed,
    Object? eps = freezed,
    Object? dividendYield = freezed,
    Object? beta = freezed,
    Object? week52High = null,
    Object? week52Low = null,
    Object? marketCap = freezed,
    Object? revenueGrowth = freezed,
    Object? profitMargin = freezed,
    Object? debtToEquity = freezed,
    Object? roe = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$FinancialRatioImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        peRatio: freezed == peRatio
            ? _value.peRatio
            : peRatio // ignore: cast_nullable_to_non_nullable
                  as double?,
        pbRatio: freezed == pbRatio
            ? _value.pbRatio
            : pbRatio // ignore: cast_nullable_to_non_nullable
                  as double?,
        eps: freezed == eps
            ? _value.eps
            : eps // ignore: cast_nullable_to_non_nullable
                  as double?,
        dividendYield: freezed == dividendYield
            ? _value.dividendYield
            : dividendYield // ignore: cast_nullable_to_non_nullable
                  as double?,
        beta: freezed == beta
            ? _value.beta
            : beta // ignore: cast_nullable_to_non_nullable
                  as double?,
        week52High: null == week52High
            ? _value.week52High
            : week52High // ignore: cast_nullable_to_non_nullable
                  as String,
        week52Low: null == week52Low
            ? _value.week52Low
            : week52Low // ignore: cast_nullable_to_non_nullable
                  as String,
        marketCap: freezed == marketCap
            ? _value.marketCap
            : marketCap // ignore: cast_nullable_to_non_nullable
                  as double?,
        revenueGrowth: freezed == revenueGrowth
            ? _value.revenueGrowth
            : revenueGrowth // ignore: cast_nullable_to_non_nullable
                  as double?,
        profitMargin: freezed == profitMargin
            ? _value.profitMargin
            : profitMargin // ignore: cast_nullable_to_non_nullable
                  as double?,
        debtToEquity: freezed == debtToEquity
            ? _value.debtToEquity
            : debtToEquity // ignore: cast_nullable_to_non_nullable
                  as double?,
        roe: freezed == roe
            ? _value.roe
            : roe // ignore: cast_nullable_to_non_nullable
                  as double?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialRatioImpl implements _FinancialRatio {
  const _$FinancialRatioImpl({
    this.id,
    required this.symbol,
    this.peRatio,
    this.pbRatio,
    this.eps,
    this.dividendYield,
    this.beta,
    this.week52High = '',
    this.week52Low = '',
    this.marketCap,
    this.revenueGrowth,
    this.profitMargin,
    this.debtToEquity,
    this.roe,
    this.updatedAt,
  });

  factory _$FinancialRatioImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialRatioImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final double? peRatio;
  @override
  final double? pbRatio;
  @override
  final double? eps;
  @override
  final double? dividendYield;
  @override
  final double? beta;
  @override
  @JsonKey()
  final String week52High;
  @override
  @JsonKey()
  final String week52Low;
  @override
  final double? marketCap;
  @override
  final double? revenueGrowth;
  @override
  final double? profitMargin;
  @override
  final double? debtToEquity;
  @override
  final double? roe;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FinancialRatio(id: $id, symbol: $symbol, peRatio: $peRatio, pbRatio: $pbRatio, eps: $eps, dividendYield: $dividendYield, beta: $beta, week52High: $week52High, week52Low: $week52Low, marketCap: $marketCap, revenueGrowth: $revenueGrowth, profitMargin: $profitMargin, debtToEquity: $debtToEquity, roe: $roe, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialRatioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.peRatio, peRatio) || other.peRatio == peRatio) &&
            (identical(other.pbRatio, pbRatio) || other.pbRatio == pbRatio) &&
            (identical(other.eps, eps) || other.eps == eps) &&
            (identical(other.dividendYield, dividendYield) ||
                other.dividendYield == dividendYield) &&
            (identical(other.beta, beta) || other.beta == beta) &&
            (identical(other.week52High, week52High) ||
                other.week52High == week52High) &&
            (identical(other.week52Low, week52Low) ||
                other.week52Low == week52Low) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.revenueGrowth, revenueGrowth) ||
                other.revenueGrowth == revenueGrowth) &&
            (identical(other.profitMargin, profitMargin) ||
                other.profitMargin == profitMargin) &&
            (identical(other.debtToEquity, debtToEquity) ||
                other.debtToEquity == debtToEquity) &&
            (identical(other.roe, roe) || other.roe == roe) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    peRatio,
    pbRatio,
    eps,
    dividendYield,
    beta,
    week52High,
    week52Low,
    marketCap,
    revenueGrowth,
    profitMargin,
    debtToEquity,
    roe,
    updatedAt,
  );

  /// Create a copy of FinancialRatio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialRatioImplCopyWith<_$FinancialRatioImpl> get copyWith =>
      __$$FinancialRatioImplCopyWithImpl<_$FinancialRatioImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialRatioImplToJson(this);
  }
}

abstract class _FinancialRatio implements FinancialRatio {
  const factory _FinancialRatio({
    final int? id,
    required final String symbol,
    final double? peRatio,
    final double? pbRatio,
    final double? eps,
    final double? dividendYield,
    final double? beta,
    final String week52High,
    final String week52Low,
    final double? marketCap,
    final double? revenueGrowth,
    final double? profitMargin,
    final double? debtToEquity,
    final double? roe,
    final DateTime? updatedAt,
  }) = _$FinancialRatioImpl;

  factory _FinancialRatio.fromJson(Map<String, dynamic> json) =
      _$FinancialRatioImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  double? get peRatio;
  @override
  double? get pbRatio;
  @override
  double? get eps;
  @override
  double? get dividendYield;
  @override
  double? get beta;
  @override
  String get week52High;
  @override
  String get week52Low;
  @override
  double? get marketCap;
  @override
  double? get revenueGrowth;
  @override
  double? get profitMargin;
  @override
  double? get debtToEquity;
  @override
  double? get roe;
  @override
  DateTime? get updatedAt;

  /// Create a copy of FinancialRatio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialRatioImplCopyWith<_$FinancialRatioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
