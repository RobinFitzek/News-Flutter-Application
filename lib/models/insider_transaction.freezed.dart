// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insider_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InsiderTransaction _$InsiderTransactionFromJson(Map<String, dynamic> json) {
  return _InsiderTransaction.fromJson(json);
}

/// @nodoc
mixin _$InsiderTransaction {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get insiderName => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get shares => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get totalValue => throw _privateConstructorUsedError;
  DateTime get filingDate => throw _privateConstructorUsedError;
  DateTime get transactionDate => throw _privateConstructorUsedError;

  /// Serializes this InsiderTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InsiderTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsiderTransactionCopyWith<InsiderTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsiderTransactionCopyWith<$Res> {
  factory $InsiderTransactionCopyWith(
    InsiderTransaction value,
    $Res Function(InsiderTransaction) then,
  ) = _$InsiderTransactionCopyWithImpl<$Res, InsiderTransaction>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    String insiderName,
    String title,
    String type,
    double shares,
    double price,
    double totalValue,
    DateTime filingDate,
    DateTime transactionDate,
  });
}

/// @nodoc
class _$InsiderTransactionCopyWithImpl<$Res, $Val extends InsiderTransaction>
    implements $InsiderTransactionCopyWith<$Res> {
  _$InsiderTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsiderTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? insiderName = null,
    Object? title = null,
    Object? type = null,
    Object? shares = null,
    Object? price = null,
    Object? totalValue = null,
    Object? filingDate = null,
    Object? transactionDate = null,
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
            insiderName: null == insiderName
                ? _value.insiderName
                : insiderName // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
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
            totalValue: null == totalValue
                ? _value.totalValue
                : totalValue // ignore: cast_nullable_to_non_nullable
                      as double,
            filingDate: null == filingDate
                ? _value.filingDate
                : filingDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            transactionDate: null == transactionDate
                ? _value.transactionDate
                : transactionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InsiderTransactionImplCopyWith<$Res>
    implements $InsiderTransactionCopyWith<$Res> {
  factory _$$InsiderTransactionImplCopyWith(
    _$InsiderTransactionImpl value,
    $Res Function(_$InsiderTransactionImpl) then,
  ) = __$$InsiderTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    String insiderName,
    String title,
    String type,
    double shares,
    double price,
    double totalValue,
    DateTime filingDate,
    DateTime transactionDate,
  });
}

/// @nodoc
class __$$InsiderTransactionImplCopyWithImpl<$Res>
    extends _$InsiderTransactionCopyWithImpl<$Res, _$InsiderTransactionImpl>
    implements _$$InsiderTransactionImplCopyWith<$Res> {
  __$$InsiderTransactionImplCopyWithImpl(
    _$InsiderTransactionImpl _value,
    $Res Function(_$InsiderTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InsiderTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? insiderName = null,
    Object? title = null,
    Object? type = null,
    Object? shares = null,
    Object? price = null,
    Object? totalValue = null,
    Object? filingDate = null,
    Object? transactionDate = null,
  }) {
    return _then(
      _$InsiderTransactionImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        symbol: null == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String,
        insiderName: null == insiderName
            ? _value.insiderName
            : insiderName // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
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
        totalValue: null == totalValue
            ? _value.totalValue
            : totalValue // ignore: cast_nullable_to_non_nullable
                  as double,
        filingDate: null == filingDate
            ? _value.filingDate
            : filingDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        transactionDate: null == transactionDate
            ? _value.transactionDate
            : transactionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InsiderTransactionImpl implements _InsiderTransaction {
  const _$InsiderTransactionImpl({
    this.id,
    required this.symbol,
    required this.insiderName,
    required this.title,
    required this.type,
    required this.shares,
    required this.price,
    required this.totalValue,
    required this.filingDate,
    required this.transactionDate,
  });

  factory _$InsiderTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsiderTransactionImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final String insiderName;
  @override
  final String title;
  @override
  final String type;
  @override
  final double shares;
  @override
  final double price;
  @override
  final double totalValue;
  @override
  final DateTime filingDate;
  @override
  final DateTime transactionDate;

  @override
  String toString() {
    return 'InsiderTransaction(id: $id, symbol: $symbol, insiderName: $insiderName, title: $title, type: $type, shares: $shares, price: $price, totalValue: $totalValue, filingDate: $filingDate, transactionDate: $transactionDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsiderTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.insiderName, insiderName) ||
                other.insiderName == insiderName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.filingDate, filingDate) ||
                other.filingDate == filingDate) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    insiderName,
    title,
    type,
    shares,
    price,
    totalValue,
    filingDate,
    transactionDate,
  );

  /// Create a copy of InsiderTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsiderTransactionImplCopyWith<_$InsiderTransactionImpl> get copyWith =>
      __$$InsiderTransactionImplCopyWithImpl<_$InsiderTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InsiderTransactionImplToJson(this);
  }
}

abstract class _InsiderTransaction implements InsiderTransaction {
  const factory _InsiderTransaction({
    final int? id,
    required final String symbol,
    required final String insiderName,
    required final String title,
    required final String type,
    required final double shares,
    required final double price,
    required final double totalValue,
    required final DateTime filingDate,
    required final DateTime transactionDate,
  }) = _$InsiderTransactionImpl;

  factory _InsiderTransaction.fromJson(Map<String, dynamic> json) =
      _$InsiderTransactionImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  String get insiderName;
  @override
  String get title;
  @override
  String get type;
  @override
  double get shares;
  @override
  double get price;
  @override
  double get totalValue;
  @override
  DateTime get filingDate;
  @override
  DateTime get transactionDate;

  /// Create a copy of InsiderTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsiderTransactionImplCopyWith<_$InsiderTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
