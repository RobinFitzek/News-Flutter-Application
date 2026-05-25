// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StockPrediction _$StockPredictionFromJson(Map<String, dynamic> json) {
  return _StockPrediction.fromJson(json);
}

/// @nodoc
mixin _$StockPrediction {
  String get symbol => throw _privateConstructorUsedError;
  double get predictedPrice => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  TimeFrame get timeframe => throw _privateConstructorUsedError;

  /// Serializes this StockPrediction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockPredictionCopyWith<StockPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockPredictionCopyWith<$Res> {
  factory $StockPredictionCopyWith(
    StockPrediction value,
    $Res Function(StockPrediction) then,
  ) = _$StockPredictionCopyWithImpl<$Res, StockPrediction>;
  @useResult
  $Res call({
    String symbol,
    double predictedPrice,
    double confidence,
    DateTime timestamp,
    TimeFrame timeframe,
  });
}

/// @nodoc
class _$StockPredictionCopyWithImpl<$Res, $Val extends StockPrediction>
    implements $StockPredictionCopyWith<$Res> {
  _$StockPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? predictedPrice = null,
    Object? confidence = null,
    Object? timestamp = null,
    Object? timeframe = null,
  }) {
    return _then(
      _value.copyWith(
            symbol: null == symbol
                ? _value.symbol
                : symbol // ignore: cast_nullable_to_non_nullable
                      as String,
            predictedPrice: null == predictedPrice
                ? _value.predictedPrice
                : predictedPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            timeframe: null == timeframe
                ? _value.timeframe
                : timeframe // ignore: cast_nullable_to_non_nullable
                      as TimeFrame,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StockPredictionImplCopyWith<$Res>
    implements $StockPredictionCopyWith<$Res> {
  factory _$$StockPredictionImplCopyWith(
    _$StockPredictionImpl value,
    $Res Function(_$StockPredictionImpl) then,
  ) = __$$StockPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String symbol,
    double predictedPrice,
    double confidence,
    DateTime timestamp,
    TimeFrame timeframe,
  });
}

/// @nodoc
class __$$StockPredictionImplCopyWithImpl<$Res>
    extends _$StockPredictionCopyWithImpl<$Res, _$StockPredictionImpl>
    implements _$$StockPredictionImplCopyWith<$Res> {
  __$$StockPredictionImplCopyWithImpl(
    _$StockPredictionImpl _value,
    $Res Function(_$StockPredictionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StockPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? predictedPrice = null,
    Object? confidence = null,
    Object? timestamp = null,
    Object? timeframe = null,
  }) {
    return _then(
      _$StockPredictionImpl(
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        predictedPrice: null == predictedPrice
            ? _value.predictedPrice
            : predictedPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        timeframe: null == timeframe
            ? _value.timeframe
            : timeframe // ignore: cast_nullable_to_non_nullable
                  as TimeFrame,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StockPredictionImpl implements _StockPrediction {
  const _$StockPredictionImpl({
    required this.symbol,
    required this.predictedPrice,
    required this.confidence,
    required this.timestamp,
    required this.timeframe,
  });

  factory _$StockPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockPredictionImplFromJson(json);

  @override
  final String symbol;
  @override
  final double predictedPrice;
  @override
  final double confidence;
  @override
  final DateTime timestamp;
  @override
  final TimeFrame timeframe;

  @override
  String toString() {
    return 'StockPrediction(symbol: $symbol, predictedPrice: $predictedPrice, confidence: $confidence, timestamp: $timestamp, timeframe: $timeframe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockPredictionImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.predictedPrice, predictedPrice) ||
                other.predictedPrice == predictedPrice) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    symbol,
    predictedPrice,
    confidence,
    timestamp,
    timeframe,
  );

  /// Create a copy of StockPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockPredictionImplCopyWith<_$StockPredictionImpl> get copyWith =>
      __$$StockPredictionImplCopyWithImpl<_$StockPredictionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StockPredictionImplToJson(this);
  }
}

abstract class _StockPrediction implements StockPrediction {
  const factory _StockPrediction({
    required final String symbol,
    required final double predictedPrice,
    required final double confidence,
    required final DateTime timestamp,
    required final TimeFrame timeframe,
  }) = _$StockPredictionImpl;

  factory _StockPrediction.fromJson(Map<String, dynamic> json) =
      _$StockPredictionImpl.fromJson;

  @override
  String get symbol;
  @override
  double get predictedPrice;
  @override
  double get confidence;
  @override
  DateTime get timestamp;
  @override
  TimeFrame get timeframe;

  /// Create a copy of StockPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockPredictionImplCopyWith<_$StockPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
