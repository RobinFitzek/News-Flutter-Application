// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CorporateAction _$CorporateActionFromJson(Map<String, dynamic> json) {
  return _CorporateAction.fromJson(json);
}

/// @nodoc
mixin _$CorporateAction {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this CorporateAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CorporateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CorporateActionCopyWith<CorporateAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateActionCopyWith<$Res> {
  factory $CorporateActionCopyWith(
    CorporateAction value,
    $Res Function(CorporateAction) then,
  ) = _$CorporateActionCopyWithImpl<$Res, CorporateAction>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    String type,
    DateTime date,
    String? description,
    double? amount,
    String currency,
  });
}

/// @nodoc
class _$CorporateActionCopyWithImpl<$Res, $Val extends CorporateAction>
    implements $CorporateActionCopyWith<$Res> {
  _$CorporateActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CorporateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? type = null,
    Object? date = null,
    Object? description = freezed,
    Object? amount = freezed,
    Object? currency = null,
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
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double?,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CorporateActionImplCopyWith<$Res>
    implements $CorporateActionCopyWith<$Res> {
  factory _$$CorporateActionImplCopyWith(
    _$CorporateActionImpl value,
    $Res Function(_$CorporateActionImpl) then,
  ) = __$$CorporateActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    String type,
    DateTime date,
    String? description,
    double? amount,
    String currency,
  });
}

/// @nodoc
class __$$CorporateActionImplCopyWithImpl<$Res>
    extends _$CorporateActionCopyWithImpl<$Res, _$CorporateActionImpl>
    implements _$$CorporateActionImplCopyWith<$Res> {
  __$$CorporateActionImplCopyWithImpl(
    _$CorporateActionImpl _value,
    $Res Function(_$CorporateActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CorporateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? type = null,
    Object? date = null,
    Object? description = freezed,
    Object? amount = freezed,
    Object? currency = null,
  }) {
    return _then(
      _$CorporateActionImpl(
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
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double?,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateActionImpl implements _CorporateAction {
  const _$CorporateActionImpl({
    this.id,
    required this.symbol,
    required this.type,
    required this.date,
    this.description,
    this.amount,
    this.currency = '',
  });

  factory _$CorporateActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporateActionImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final String type;
  @override
  final DateTime date;
  @override
  final String? description;
  @override
  final double? amount;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'CorporateAction(id: $id, symbol: $symbol, type: $type, date: $date, description: $description, amount: $amount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorporateActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    type,
    date,
    description,
    amount,
    currency,
  );

  /// Create a copy of CorporateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateActionImplCopyWith<_$CorporateActionImpl> get copyWith =>
      __$$CorporateActionImplCopyWithImpl<_$CorporateActionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateActionImplToJson(this);
  }
}

abstract class _CorporateAction implements CorporateAction {
  const factory _CorporateAction({
    final int? id,
    required final String symbol,
    required final String type,
    required final DateTime date,
    final String? description,
    final double? amount,
    final String currency,
  }) = _$CorporateActionImpl;

  factory _CorporateAction.fromJson(Map<String, dynamic> json) =
      _$CorporateActionImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  String get type;
  @override
  DateTime get date;
  @override
  String? get description;
  @override
  double? get amount;
  @override
  String get currency;

  /// Create a copy of CorporateAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CorporateActionImplCopyWith<_$CorporateActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
