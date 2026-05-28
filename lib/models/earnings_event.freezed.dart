// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EarningsEvent _$EarningsEventFromJson(Map<String, dynamic> json) {
  return _EarningsEvent.fromJson(json);
}

/// @nodoc
mixin _$EarningsEvent {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  DateTime get reportDate => throw _privateConstructorUsedError;
  double? get estimatedEps => throw _privateConstructorUsedError;
  double? get actualEps => throw _privateConstructorUsedError;
  double? get surprise => throw _privateConstructorUsedError;
  double? get surprisePercent => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;

  /// Serializes this EarningsEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarningsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarningsEventCopyWith<EarningsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarningsEventCopyWith<$Res> {
  factory $EarningsEventCopyWith(
    EarningsEvent value,
    $Res Function(EarningsEvent) then,
  ) = _$EarningsEventCopyWithImpl<$Res, EarningsEvent>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    DateTime reportDate,
    double? estimatedEps,
    double? actualEps,
    double? surprise,
    double? surprisePercent,
    String period,
  });
}

/// @nodoc
class _$EarningsEventCopyWithImpl<$Res, $Val extends EarningsEvent>
    implements $EarningsEventCopyWith<$Res> {
  _$EarningsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarningsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? reportDate = null,
    Object? estimatedEps = freezed,
    Object? actualEps = freezed,
    Object? surprise = freezed,
    Object? surprisePercent = freezed,
    Object? period = null,
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
            reportDate: null == reportDate
                ? _value.reportDate
                : reportDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            estimatedEps: freezed == estimatedEps
                ? _value.estimatedEps
                : estimatedEps // ignore: cast_nullable_to_non_nullable
                      as double?,
            actualEps: freezed == actualEps
                ? _value.actualEps
                : actualEps // ignore: cast_nullable_to_non_nullable
                      as double?,
            surprise: freezed == surprise
                ? _value.surprise
                : surprise // ignore: cast_nullable_to_non_nullable
                      as double?,
            surprisePercent: freezed == surprisePercent
                ? _value.surprisePercent
                : surprisePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarningsEventImplCopyWith<$Res>
    implements $EarningsEventCopyWith<$Res> {
  factory _$$EarningsEventImplCopyWith(
    _$EarningsEventImpl value,
    $Res Function(_$EarningsEventImpl) then,
  ) = __$$EarningsEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    DateTime reportDate,
    double? estimatedEps,
    double? actualEps,
    double? surprise,
    double? surprisePercent,
    String period,
  });
}

/// @nodoc
class __$$EarningsEventImplCopyWithImpl<$Res>
    extends _$EarningsEventCopyWithImpl<$Res, _$EarningsEventImpl>
    implements _$$EarningsEventImplCopyWith<$Res> {
  __$$EarningsEventImplCopyWithImpl(
    _$EarningsEventImpl _value,
    $Res Function(_$EarningsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarningsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? reportDate = null,
    Object? estimatedEps = freezed,
    Object? actualEps = freezed,
    Object? surprise = freezed,
    Object? surprisePercent = freezed,
    Object? period = null,
  }) {
    return _then(
      _$EarningsEventImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        reportDate: null == reportDate
            ? _value.reportDate
            : reportDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        estimatedEps: freezed == estimatedEps
            ? _value.estimatedEps
            : estimatedEps // ignore: cast_nullable_to_non_nullable
                  as double?,
        actualEps: freezed == actualEps
            ? _value.actualEps
            : actualEps // ignore: cast_nullable_to_non_nullable
                  as double?,
        surprise: freezed == surprise
            ? _value.surprise
            : surprise // ignore: cast_nullable_to_non_nullable
                  as double?,
        surprisePercent: freezed == surprisePercent
            ? _value.surprisePercent
            : surprisePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarningsEventImpl implements _EarningsEvent {
  const _$EarningsEventImpl({
    this.id,
    required this.symbol,
    required this.reportDate,
    this.estimatedEps,
    this.actualEps,
    this.surprise,
    this.surprisePercent,
    this.period = '',
  });

  factory _$EarningsEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarningsEventImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final DateTime reportDate;
  @override
  final double? estimatedEps;
  @override
  final double? actualEps;
  @override
  final double? surprise;
  @override
  final double? surprisePercent;
  @override
  @JsonKey()
  final String period;

  @override
  String toString() {
    return 'EarningsEvent(id: $id, symbol: $symbol, reportDate: $reportDate, estimatedEps: $estimatedEps, actualEps: $actualEps, surprise: $surprise, surprisePercent: $surprisePercent, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarningsEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.reportDate, reportDate) ||
                other.reportDate == reportDate) &&
            (identical(other.estimatedEps, estimatedEps) ||
                other.estimatedEps == estimatedEps) &&
            (identical(other.actualEps, actualEps) ||
                other.actualEps == actualEps) &&
            (identical(other.surprise, surprise) ||
                other.surprise == surprise) &&
            (identical(other.surprisePercent, surprisePercent) ||
                other.surprisePercent == surprisePercent) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    reportDate,
    estimatedEps,
    actualEps,
    surprise,
    surprisePercent,
    period,
  );

  /// Create a copy of EarningsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarningsEventImplCopyWith<_$EarningsEventImpl> get copyWith =>
      __$$EarningsEventImplCopyWithImpl<_$EarningsEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarningsEventImplToJson(this);
  }
}

abstract class _EarningsEvent implements EarningsEvent {
  const factory _EarningsEvent({
    final int? id,
    required final String symbol,
    required final DateTime reportDate,
    final double? estimatedEps,
    final double? actualEps,
    final double? surprise,
    final double? surprisePercent,
    final String period,
  }) = _$EarningsEventImpl;

  factory _EarningsEvent.fromJson(Map<String, dynamic> json) =
      _$EarningsEventImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  DateTime get reportDate;
  @override
  double? get estimatedEps;
  @override
  double? get actualEps;
  @override
  double? get surprise;
  @override
  double? get surprisePercent;
  @override
  String get period;

  /// Create a copy of EarningsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarningsEventImplCopyWith<_$EarningsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
