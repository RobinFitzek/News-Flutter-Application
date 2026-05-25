// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Discovery _$DiscoveryFromJson(Map<String, dynamic> json) {
  return _Discovery.fromJson(json);
}

/// @nodoc
mixin _$Discovery {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String get strategy => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get discoveredAt => throw _privateConstructorUsedError;
  bool get isPromoted => throw _privateConstructorUsedError;
  bool get isDismissed => throw _privateConstructorUsedError;
  double? get potentialUpside => throw _privateConstructorUsedError;

  /// Serializes this Discovery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Discovery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoveryCopyWith<Discovery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoveryCopyWith<$Res> {
  factory $DiscoveryCopyWith(Discovery value, $Res Function(Discovery) then) =
      _$DiscoveryCopyWithImpl<$Res, Discovery>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    String companyName,
    String reason,
    String strategy,
    double currentPrice,
    double confidence,
    DateTime discoveredAt,
    bool isPromoted,
    bool isDismissed,
    double? potentialUpside,
  });
}

/// @nodoc
class _$DiscoveryCopyWithImpl<$Res, $Val extends Discovery>
    implements $DiscoveryCopyWith<$Res> {
  _$DiscoveryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Discovery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? companyName = null,
    Object? reason = null,
    Object? strategy = null,
    Object? currentPrice = null,
    Object? confidence = null,
    Object? discoveredAt = null,
    Object? isPromoted = null,
    Object? isDismissed = null,
    Object? potentialUpside = freezed,
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
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            strategy: null == strategy
                ? _value.strategy
                : strategy // ignore: cast_nullable_to_non_nullable
                      as String,
            currentPrice: null == currentPrice
                ? _value.currentPrice
                : currentPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            discoveredAt: null == discoveredAt
                ? _value.discoveredAt
                : discoveredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isPromoted: null == isPromoted
                ? _value.isPromoted
                : isPromoted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDismissed: null == isDismissed
                ? _value.isDismissed
                : isDismissed // ignore: cast_nullable_to_non_nullable
                      as bool,
            potentialUpside: freezed == potentialUpside
                ? _value.potentialUpside
                : potentialUpside // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoveryImplCopyWith<$Res>
    implements $DiscoveryCopyWith<$Res> {
  factory _$$DiscoveryImplCopyWith(
    _$DiscoveryImpl value,
    $Res Function(_$DiscoveryImpl) then,
  ) = __$$DiscoveryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    String companyName,
    String reason,
    String strategy,
    double currentPrice,
    double confidence,
    DateTime discoveredAt,
    bool isPromoted,
    bool isDismissed,
    double? potentialUpside,
  });
}

/// @nodoc
class __$$DiscoveryImplCopyWithImpl<$Res>
    extends _$DiscoveryCopyWithImpl<$Res, _$DiscoveryImpl>
    implements _$$DiscoveryImplCopyWith<$Res> {
  __$$DiscoveryImplCopyWithImpl(
    _$DiscoveryImpl _value,
    $Res Function(_$DiscoveryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Discovery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? companyName = null,
    Object? reason = null,
    Object? strategy = null,
    Object? currentPrice = null,
    Object? confidence = null,
    Object? discoveredAt = null,
    Object? isPromoted = null,
    Object? isDismissed = null,
    Object? potentialUpside = freezed,
  }) {
    return _then(
      _$DiscoveryImpl(
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
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        strategy: null == strategy
            ? _value.strategy
            : strategy // ignore: cast_nullable_to_non_nullable
                  as String,
        currentPrice: null == currentPrice
            ? _value.currentPrice
            : currentPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        discoveredAt: null == discoveredAt
            ? _value.discoveredAt
            : discoveredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isPromoted: null == isPromoted
            ? _value.isPromoted
            : isPromoted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDismissed: null == isDismissed
            ? _value.isDismissed
            : isDismissed // ignore: cast_nullable_to_non_nullable
                  as bool,
        potentialUpside: freezed == potentialUpside
            ? _value.potentialUpside
            : potentialUpside // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoveryImpl implements _Discovery {
  const _$DiscoveryImpl({
    this.id,
    required this.symbol,
    required this.companyName,
    required this.reason,
    required this.strategy,
    required this.currentPrice,
    required this.confidence,
    required this.discoveredAt,
    this.isPromoted = false,
    this.isDismissed = false,
    this.potentialUpside,
  });

  factory _$DiscoveryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoveryImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final String reason;
  @override
  final String strategy;
  @override
  final double currentPrice;
  @override
  final double confidence;
  @override
  final DateTime discoveredAt;
  @override
  @JsonKey()
  final bool isPromoted;
  @override
  @JsonKey()
  final bool isDismissed;
  @override
  final double? potentialUpside;

  @override
  String toString() {
    return 'Discovery(id: $id, symbol: $symbol, companyName: $companyName, reason: $reason, strategy: $strategy, currentPrice: $currentPrice, confidence: $confidence, discoveredAt: $discoveredAt, isPromoted: $isPromoted, isDismissed: $isDismissed, potentialUpside: $potentialUpside)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.strategy, strategy) ||
                other.strategy == strategy) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.discoveredAt, discoveredAt) ||
                other.discoveredAt == discoveredAt) &&
            (identical(other.isPromoted, isPromoted) ||
                other.isPromoted == isPromoted) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.potentialUpside, potentialUpside) ||
                other.potentialUpside == potentialUpside));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    companyName,
    reason,
    strategy,
    currentPrice,
    confidence,
    discoveredAt,
    isPromoted,
    isDismissed,
    potentialUpside,
  );

  /// Create a copy of Discovery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveryImplCopyWith<_$DiscoveryImpl> get copyWith =>
      __$$DiscoveryImplCopyWithImpl<_$DiscoveryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoveryImplToJson(this);
  }
}

abstract class _Discovery implements Discovery {
  const factory _Discovery({
    final int? id,
    required final String symbol,
    required final String companyName,
    required final String reason,
    required final String strategy,
    required final double currentPrice,
    required final double confidence,
    required final DateTime discoveredAt,
    final bool isPromoted,
    final bool isDismissed,
    final double? potentialUpside,
  }) = _$DiscoveryImpl;

  factory _Discovery.fromJson(Map<String, dynamic> json) =
      _$DiscoveryImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  String get companyName;
  @override
  String get reason;
  @override
  String get strategy;
  @override
  double get currentPrice;
  @override
  double get confidence;
  @override
  DateTime get discoveredAt;
  @override
  bool get isPromoted;
  @override
  bool get isDismissed;
  @override
  double? get potentialUpside;

  /// Create a copy of Discovery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoveryImplCopyWith<_$DiscoveryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
