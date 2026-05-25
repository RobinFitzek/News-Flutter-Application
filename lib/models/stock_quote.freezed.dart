// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StockQuote _$StockQuoteFromJson(Map<String, dynamic> json) {
  return _StockQuote.fromJson(json);
}

/// @nodoc
mixin _$StockQuote {
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  double get previousClose => throw _privateConstructorUsedError;
  double get change => throw _privateConstructorUsedError;
  double get changePercent => throw _privateConstructorUsedError;
  double get dayHigh => throw _privateConstructorUsedError;
  double get dayLow => throw _privateConstructorUsedError;
  int get volume => throw _privateConstructorUsedError;
  double? get marketCap => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this StockQuote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockQuoteCopyWith<StockQuote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockQuoteCopyWith<$Res> {
  factory $StockQuoteCopyWith(
    StockQuote value,
    $Res Function(StockQuote) then,
  ) = _$StockQuoteCopyWithImpl<$Res, StockQuote>;
  @useResult
  $Res call({
    String symbol,
    String companyName,
    double currentPrice,
    double previousClose,
    double change,
    double changePercent,
    double dayHigh,
    double dayLow,
    int volume,
    double? marketCap,
    DateTime timestamp,
  });
}

/// @nodoc
class _$StockQuoteCopyWithImpl<$Res, $Val extends StockQuote>
    implements $StockQuoteCopyWith<$Res> {
  _$StockQuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? currentPrice = null,
    Object? previousClose = null,
    Object? change = null,
    Object? changePercent = null,
    Object? dayHigh = null,
    Object? dayLow = null,
    Object? volume = null,
    Object? marketCap = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            symbol: null == symbol
                ? _value.symbol
                : symbol // ignore: cast_nullable_to_non_nullable
                      as String,
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            currentPrice: null == currentPrice
                ? _value.currentPrice
                : currentPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            previousClose: null == previousClose
                ? _value.previousClose
                : previousClose // ignore: cast_nullable_to_non_nullable
                      as double,
            change: null == change
                ? _value.change
                : change // ignore: cast_nullable_to_non_nullable
                      as double,
            changePercent: null == changePercent
                ? _value.changePercent
                : changePercent // ignore: cast_nullable_to_non_nullable
                      as double,
            dayHigh: null == dayHigh
                ? _value.dayHigh
                : dayHigh // ignore: cast_nullable_to_non_nullable
                      as double,
            dayLow: null == dayLow
                ? _value.dayLow
                : dayLow // ignore: cast_nullable_to_non_nullable
                      as double,
            volume: null == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                      as int,
            marketCap: freezed == marketCap
                ? _value.marketCap
                : marketCap // ignore: cast_nullable_to_non_nullable
                      as double?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StockQuoteImplCopyWith<$Res>
    implements $StockQuoteCopyWith<$Res> {
  factory _$$StockQuoteImplCopyWith(
    _$StockQuoteImpl value,
    $Res Function(_$StockQuoteImpl) then,
  ) = __$$StockQuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String symbol,
    String companyName,
    double currentPrice,
    double previousClose,
    double change,
    double changePercent,
    double dayHigh,
    double dayLow,
    int volume,
    double? marketCap,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$StockQuoteImplCopyWithImpl<$Res>
    extends _$StockQuoteCopyWithImpl<$Res, _$StockQuoteImpl>
    implements _$$StockQuoteImplCopyWith<$Res> {
  __$$StockQuoteImplCopyWithImpl(
    _$StockQuoteImpl _value,
    $Res Function(_$StockQuoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StockQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? currentPrice = null,
    Object? previousClose = null,
    Object? change = null,
    Object? changePercent = null,
    Object? dayHigh = null,
    Object? dayLow = null,
    Object? volume = null,
    Object? marketCap = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _$StockQuoteImpl(
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        currentPrice: null == currentPrice
            ? _value.currentPrice
            : currentPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        previousClose: null == previousClose
            ? _value.previousClose
            : previousClose // ignore: cast_nullable_to_non_nullable
                  as double,
        change: null == change
            ? _value.change
            : change // ignore: cast_nullable_to_non_nullable
                  as double,
        changePercent: null == changePercent
            ? _value.changePercent
            : changePercent // ignore: cast_nullable_to_non_nullable
                  as double,
        dayHigh: null == dayHigh
            ? _value.dayHigh
            : dayHigh // ignore: cast_nullable_to_non_nullable
                  as double,
        dayLow: null == dayLow
            ? _value.dayLow
            : dayLow // ignore: cast_nullable_to_non_nullable
                  as double,
        volume: null == volume
            ? _value.volume
            : volume // ignore: cast_nullable_to_non_nullable
                  as int,
        marketCap: freezed == marketCap
            ? _value.marketCap
            : marketCap // ignore: cast_nullable_to_non_nullable
                  as double?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StockQuoteImpl implements _StockQuote {
  const _$StockQuoteImpl({
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.previousClose,
    required this.change,
    required this.changePercent,
    required this.dayHigh,
    required this.dayLow,
    required this.volume,
    this.marketCap = null,
    required this.timestamp,
  });

  factory _$StockQuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockQuoteImplFromJson(json);

  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final double currentPrice;
  @override
  final double previousClose;
  @override
  final double change;
  @override
  final double changePercent;
  @override
  final double dayHigh;
  @override
  final double dayLow;
  @override
  final int volume;
  @override
  @JsonKey()
  final double? marketCap;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'StockQuote(symbol: $symbol, companyName: $companyName, currentPrice: $currentPrice, previousClose: $previousClose, change: $change, changePercent: $changePercent, dayHigh: $dayHigh, dayLow: $dayLow, volume: $volume, marketCap: $marketCap, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockQuoteImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.previousClose, previousClose) ||
                other.previousClose == previousClose) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.dayHigh, dayHigh) || other.dayHigh == dayHigh) &&
            (identical(other.dayLow, dayLow) || other.dayLow == dayLow) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    symbol,
    companyName,
    currentPrice,
    previousClose,
    change,
    changePercent,
    dayHigh,
    dayLow,
    volume,
    marketCap,
    timestamp,
  );

  /// Create a copy of StockQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockQuoteImplCopyWith<_$StockQuoteImpl> get copyWith =>
      __$$StockQuoteImplCopyWithImpl<_$StockQuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockQuoteImplToJson(this);
  }
}

abstract class _StockQuote implements StockQuote {
  const factory _StockQuote({
    required final String symbol,
    required final String companyName,
    required final double currentPrice,
    required final double previousClose,
    required final double change,
    required final double changePercent,
    required final double dayHigh,
    required final double dayLow,
    required final int volume,
    final double? marketCap,
    required final DateTime timestamp,
  }) = _$StockQuoteImpl;

  factory _StockQuote.fromJson(Map<String, dynamic> json) =
      _$StockQuoteImpl.fromJson;

  @override
  String get symbol;
  @override
  String get companyName;
  @override
  double get currentPrice;
  @override
  double get previousClose;
  @override
  double get change;
  @override
  double get changePercent;
  @override
  double get dayHigh;
  @override
  double get dayLow;
  @override
  int get volume;
  @override
  double? get marketCap;
  @override
  DateTime get timestamp;

  /// Create a copy of StockQuote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockQuoteImplCopyWith<_$StockQuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
