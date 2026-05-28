// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiProvider _$AiProviderFromJson(Map<String, dynamic> json) {
  return _AiProvider.fromJson(json);
}

/// @nodoc
mixin _$AiProvider {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ProviderType get type => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;
  String get apiKey => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  int get totalCalls => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  DateTime? get lastTestedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AiProvider to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiProviderCopyWith<AiProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiProviderCopyWith<$Res> {
  factory $AiProviderCopyWith(
    AiProvider value,
    $Res Function(AiProvider) then,
  ) = _$AiProviderCopyWithImpl<$Res, AiProvider>;
  @useResult
  $Res call({
    int? id,
    String name,
    ProviderType type,
    String baseUrl,
    String apiKey,
    String model,
    bool isEnabled,
    bool isConnected,
    int totalCalls,
    double totalCost,
    DateTime? lastTestedAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$AiProviderCopyWithImpl<$Res, $Val extends AiProvider>
    implements $AiProviderCopyWith<$Res> {
  _$AiProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? baseUrl = null,
    Object? apiKey = null,
    Object? model = null,
    Object? isEnabled = null,
    Object? isConnected = null,
    Object? totalCalls = null,
    Object? totalCost = null,
    Object? lastTestedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ProviderType,
            baseUrl: null == baseUrl
                ? _value.baseUrl
                : baseUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            apiKey: null == apiKey
                ? _value.apiKey
                : apiKey // ignore: cast_nullable_to_non_nullable
                      as String,
            model: null == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isConnected: null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalCalls: null == totalCalls
                ? _value.totalCalls
                : totalCalls // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCost: null == totalCost
                ? _value.totalCost
                : totalCost // ignore: cast_nullable_to_non_nullable
                      as double,
            lastTestedAt: freezed == lastTestedAt
                ? _value.lastTestedAt
                : lastTestedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiProviderImplCopyWith<$Res>
    implements $AiProviderCopyWith<$Res> {
  factory _$$AiProviderImplCopyWith(
    _$AiProviderImpl value,
    $Res Function(_$AiProviderImpl) then,
  ) = __$$AiProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String name,
    ProviderType type,
    String baseUrl,
    String apiKey,
    String model,
    bool isEnabled,
    bool isConnected,
    int totalCalls,
    double totalCost,
    DateTime? lastTestedAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$AiProviderImplCopyWithImpl<$Res>
    extends _$AiProviderCopyWithImpl<$Res, _$AiProviderImpl>
    implements _$$AiProviderImplCopyWith<$Res> {
  __$$AiProviderImplCopyWithImpl(
    _$AiProviderImpl _value,
    $Res Function(_$AiProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? baseUrl = null,
    Object? apiKey = null,
    Object? model = null,
    Object? isEnabled = null,
    Object? isConnected = null,
    Object? totalCalls = null,
    Object? totalCost = null,
    Object? lastTestedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$AiProviderImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ProviderType,
        baseUrl: null == baseUrl
            ? _value.baseUrl
            : baseUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
        model: null == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isConnected: null == isConnected
            ? _value.isConnected
            : isConnected // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalCalls: null == totalCalls
            ? _value.totalCalls
            : totalCalls // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCost: null == totalCost
            ? _value.totalCost
            : totalCost // ignore: cast_nullable_to_non_nullable
                  as double,
        lastTestedAt: freezed == lastTestedAt
            ? _value.lastTestedAt
            : lastTestedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiProviderImpl implements _AiProvider {
  const _$AiProviderImpl({
    this.id,
    required this.name,
    required this.type,
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    this.isEnabled = true,
    this.isConnected = false,
    this.totalCalls = 0,
    this.totalCost = 0.0,
    this.lastTestedAt,
    this.createdAt,
  });

  factory _$AiProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiProviderImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final ProviderType type;
  @override
  final String baseUrl;
  @override
  final String apiKey;
  @override
  final String model;
  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final int totalCalls;
  @override
  @JsonKey()
  final double totalCost;
  @override
  final DateTime? lastTestedAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AiProvider(id: $id, name: $name, type: $type, baseUrl: $baseUrl, apiKey: $apiKey, model: $model, isEnabled: $isEnabled, isConnected: $isConnected, totalCalls: $totalCalls, totalCost: $totalCost, lastTestedAt: $lastTestedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiProviderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.totalCalls, totalCalls) ||
                other.totalCalls == totalCalls) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.lastTestedAt, lastTestedAt) ||
                other.lastTestedAt == lastTestedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    baseUrl,
    apiKey,
    model,
    isEnabled,
    isConnected,
    totalCalls,
    totalCost,
    lastTestedAt,
    createdAt,
  );

  /// Create a copy of AiProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiProviderImplCopyWith<_$AiProviderImpl> get copyWith =>
      __$$AiProviderImplCopyWithImpl<_$AiProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiProviderImplToJson(this);
  }
}

abstract class _AiProvider implements AiProvider {
  const factory _AiProvider({
    final int? id,
    required final String name,
    required final ProviderType type,
    required final String baseUrl,
    required final String apiKey,
    required final String model,
    final bool isEnabled,
    final bool isConnected,
    final int totalCalls,
    final double totalCost,
    final DateTime? lastTestedAt,
    final DateTime? createdAt,
  }) = _$AiProviderImpl;

  factory _AiProvider.fromJson(Map<String, dynamic> json) =
      _$AiProviderImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  ProviderType get type;
  @override
  String get baseUrl;
  @override
  String get apiKey;
  @override
  String get model;
  @override
  bool get isEnabled;
  @override
  bool get isConnected;
  @override
  int get totalCalls;
  @override
  double get totalCost;
  @override
  DateTime? get lastTestedAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of AiProvider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiProviderImplCopyWith<_$AiProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
