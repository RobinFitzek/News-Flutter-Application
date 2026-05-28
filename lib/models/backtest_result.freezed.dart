// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backtest_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BacktestResult _$BacktestResultFromJson(Map<String, dynamic> json) {
  return _BacktestResult.fromJson(json);
}

/// @nodoc
mixin _$BacktestResult {
  int? get id => throw _privateConstructorUsedError;
  String get strategy => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  double get initialCapital => throw _privateConstructorUsedError;
  double get finalCapital => throw _privateConstructorUsedError;
  double get totalReturn => throw _privateConstructorUsedError;
  double get totalReturnPercent => throw _privateConstructorUsedError;
  double get maxDrawdown => throw _privateConstructorUsedError;
  double get maxDrawdownPercent => throw _privateConstructorUsedError;
  int get totalTrades => throw _privateConstructorUsedError;
  int get winningTrades => throw _privateConstructorUsedError;
  int get losingTrades => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  double get avgWin => throw _privateConstructorUsedError;
  double get avgLoss => throw _privateConstructorUsedError;
  double get profitFactor => throw _privateConstructorUsedError;
  List<String> get symbols => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BacktestResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BacktestResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BacktestResultCopyWith<BacktestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BacktestResultCopyWith<$Res> {
  factory $BacktestResultCopyWith(
    BacktestResult value,
    $Res Function(BacktestResult) then,
  ) = _$BacktestResultCopyWithImpl<$Res, BacktestResult>;
  @useResult
  $Res call({
    int? id,
    String strategy,
    DateTime startDate,
    DateTime endDate,
    double initialCapital,
    double finalCapital,
    double totalReturn,
    double totalReturnPercent,
    double maxDrawdown,
    double maxDrawdownPercent,
    int totalTrades,
    int winningTrades,
    int losingTrades,
    double winRate,
    double avgWin,
    double avgLoss,
    double profitFactor,
    List<String> symbols,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$BacktestResultCopyWithImpl<$Res, $Val extends BacktestResult>
    implements $BacktestResultCopyWith<$Res> {
  _$BacktestResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BacktestResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? strategy = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? initialCapital = null,
    Object? finalCapital = null,
    Object? totalReturn = null,
    Object? totalReturnPercent = null,
    Object? maxDrawdown = null,
    Object? maxDrawdownPercent = null,
    Object? totalTrades = null,
    Object? winningTrades = null,
    Object? losingTrades = null,
    Object? winRate = null,
    Object? avgWin = null,
    Object? avgLoss = null,
    Object? profitFactor = null,
    Object? symbols = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            strategy: null == strategy
                ? _value.strategy
                : strategy // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            initialCapital: null == initialCapital
                ? _value.initialCapital
                : initialCapital // ignore: cast_nullable_to_non_nullable
                      as double,
            finalCapital: null == finalCapital
                ? _value.finalCapital
                : finalCapital // ignore: cast_nullable_to_non_nullable
                      as double,
            totalReturn: null == totalReturn
                ? _value.totalReturn
                : totalReturn // ignore: cast_nullable_to_non_nullable
                      as double,
            totalReturnPercent: null == totalReturnPercent
                ? _value.totalReturnPercent
                : totalReturnPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            maxDrawdown: null == maxDrawdown
                ? _value.maxDrawdown
                : maxDrawdown // ignore: cast_nullable_to_non_nullable
                      as double,
            maxDrawdownPercent: null == maxDrawdownPercent
                ? _value.maxDrawdownPercent
                : maxDrawdownPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            totalTrades: null == totalTrades
                ? _value.totalTrades
                : totalTrades // ignore: cast_nullable_to_non_nullable
                      as int,
            winningTrades: null == winningTrades
                ? _value.winningTrades
                : winningTrades // ignore: cast_nullable_to_non_nullable
                      as int,
            losingTrades: null == losingTrades
                ? _value.losingTrades
                : losingTrades // ignore: cast_nullable_to_non_nullable
                      as int,
            winRate: null == winRate
                ? _value.winRate
                : winRate // ignore: cast_nullable_to_non_nullable
                      as double,
            avgWin: null == avgWin
                ? _value.avgWin
                : avgWin // ignore: cast_nullable_to_non_nullable
                      as double,
            avgLoss: null == avgLoss
                ? _value.avgLoss
                : avgLoss // ignore: cast_nullable_to_non_nullable
                      as double,
            profitFactor: null == profitFactor
                ? _value.profitFactor
                : profitFactor // ignore: cast_nullable_to_non_nullable
                      as double,
            symbols: null == symbols
                ? _value.symbols
                : symbols // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$BacktestResultImplCopyWith<$Res>
    implements $BacktestResultCopyWith<$Res> {
  factory _$$BacktestResultImplCopyWith(
    _$BacktestResultImpl value,
    $Res Function(_$BacktestResultImpl) then,
  ) = __$$BacktestResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String strategy,
    DateTime startDate,
    DateTime endDate,
    double initialCapital,
    double finalCapital,
    double totalReturn,
    double totalReturnPercent,
    double maxDrawdown,
    double maxDrawdownPercent,
    int totalTrades,
    int winningTrades,
    int losingTrades,
    double winRate,
    double avgWin,
    double avgLoss,
    double profitFactor,
    List<String> symbols,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$BacktestResultImplCopyWithImpl<$Res>
    extends _$BacktestResultCopyWithImpl<$Res, _$BacktestResultImpl>
    implements _$$BacktestResultImplCopyWith<$Res> {
  __$$BacktestResultImplCopyWithImpl(
    _$BacktestResultImpl _value,
    $Res Function(_$BacktestResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BacktestResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? strategy = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? initialCapital = null,
    Object? finalCapital = null,
    Object? totalReturn = null,
    Object? totalReturnPercent = null,
    Object? maxDrawdown = null,
    Object? maxDrawdownPercent = null,
    Object? totalTrades = null,
    Object? winningTrades = null,
    Object? losingTrades = null,
    Object? winRate = null,
    Object? avgWin = null,
    Object? avgLoss = null,
    Object? profitFactor = null,
    Object? symbols = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BacktestResultImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        strategy: null == strategy
            ? _value.strategy
            : strategy // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        initialCapital: null == initialCapital
            ? _value.initialCapital
            : initialCapital // ignore: cast_nullable_to_non_nullable
                  as double,
        finalCapital: null == finalCapital
            ? _value.finalCapital
            : finalCapital // ignore: cast_nullable_to_non_nullable
                  as double,
        totalReturn: null == totalReturn
            ? _value.totalReturn
            : totalReturn // ignore: cast_nullable_to_non_nullable
                  as double,
        totalReturnPercent: null == totalReturnPercent
            ? _value.totalReturnPercent
            : totalReturnPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        maxDrawdown: null == maxDrawdown
            ? _value.maxDrawdown
            : maxDrawdown // ignore: cast_nullable_to_non_nullable
                  as double,
        maxDrawdownPercent: null == maxDrawdownPercent
            ? _value.maxDrawdownPercent
            : maxDrawdownPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        totalTrades: null == totalTrades
            ? _value.totalTrades
            : totalTrades // ignore: cast_nullable_to_non_nullable
                  as int,
        winningTrades: null == winningTrades
            ? _value.winningTrades
            : winningTrades // ignore: cast_nullable_to_non_nullable
                  as int,
        losingTrades: null == losingTrades
            ? _value.losingTrades
            : losingTrades // ignore: cast_nullable_to_non_nullable
                  as int,
        winRate: null == winRate
            ? _value.winRate
            : winRate // ignore: cast_nullable_to_non_nullable
                  as double,
        avgWin: null == avgWin
            ? _value.avgWin
            : avgWin // ignore: cast_nullable_to_non_nullable
                  as double,
        avgLoss: null == avgLoss
            ? _value.avgLoss
            : avgLoss // ignore: cast_nullable_to_non_nullable
                  as double,
        profitFactor: null == profitFactor
            ? _value.profitFactor
            : profitFactor // ignore: cast_nullable_to_non_nullable
                  as double,
        symbols: null == symbols
            ? _value._symbols
            : symbols // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
class _$BacktestResultImpl implements _BacktestResult {
  const _$BacktestResultImpl({
    this.id,
    required this.strategy,
    required this.startDate,
    required this.endDate,
    required this.initialCapital,
    required this.finalCapital,
    required this.totalReturn,
    required this.totalReturnPercent,
    required this.maxDrawdown,
    required this.maxDrawdownPercent,
    required this.totalTrades,
    required this.winningTrades,
    required this.losingTrades,
    required this.winRate,
    required this.avgWin,
    required this.avgLoss,
    required this.profitFactor,
    required final List<String> symbols,
    this.createdAt,
  }) : _symbols = symbols;

  factory _$BacktestResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BacktestResultImplFromJson(json);

  @override
  final int? id;
  @override
  final String strategy;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final double initialCapital;
  @override
  final double finalCapital;
  @override
  final double totalReturn;
  @override
  final double totalReturnPercent;
  @override
  final double maxDrawdown;
  @override
  final double maxDrawdownPercent;
  @override
  final int totalTrades;
  @override
  final int winningTrades;
  @override
  final int losingTrades;
  @override
  final double winRate;
  @override
  final double avgWin;
  @override
  final double avgLoss;
  @override
  final double profitFactor;
  final List<String> _symbols;
  @override
  List<String> get symbols {
    if (_symbols is EqualUnmodifiableListView) return _symbols;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symbols);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BacktestResult(id: $id, strategy: $strategy, startDate: $startDate, endDate: $endDate, initialCapital: $initialCapital, finalCapital: $finalCapital, totalReturn: $totalReturn, totalReturnPercent: $totalReturnPercent, maxDrawdown: $maxDrawdown, maxDrawdownPercent: $maxDrawdownPercent, totalTrades: $totalTrades, winningTrades: $winningTrades, losingTrades: $losingTrades, winRate: $winRate, avgWin: $avgWin, avgLoss: $avgLoss, profitFactor: $profitFactor, symbols: $symbols, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BacktestResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.strategy, strategy) ||
                other.strategy == strategy) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.initialCapital, initialCapital) ||
                other.initialCapital == initialCapital) &&
            (identical(other.finalCapital, finalCapital) ||
                other.finalCapital == finalCapital) &&
            (identical(other.totalReturn, totalReturn) ||
                other.totalReturn == totalReturn) &&
            (identical(other.totalReturnPercent, totalReturnPercent) ||
                other.totalReturnPercent == totalReturnPercent) &&
            (identical(other.maxDrawdown, maxDrawdown) ||
                other.maxDrawdown == maxDrawdown) &&
            (identical(other.maxDrawdownPercent, maxDrawdownPercent) ||
                other.maxDrawdownPercent == maxDrawdownPercent) &&
            (identical(other.totalTrades, totalTrades) ||
                other.totalTrades == totalTrades) &&
            (identical(other.winningTrades, winningTrades) ||
                other.winningTrades == winningTrades) &&
            (identical(other.losingTrades, losingTrades) ||
                other.losingTrades == losingTrades) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.avgWin, avgWin) || other.avgWin == avgWin) &&
            (identical(other.avgLoss, avgLoss) || other.avgLoss == avgLoss) &&
            (identical(other.profitFactor, profitFactor) ||
                other.profitFactor == profitFactor) &&
            const DeepCollectionEquality().equals(other._symbols, _symbols) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    strategy,
    startDate,
    endDate,
    initialCapital,
    finalCapital,
    totalReturn,
    totalReturnPercent,
    maxDrawdown,
    maxDrawdownPercent,
    totalTrades,
    winningTrades,
    losingTrades,
    winRate,
    avgWin,
    avgLoss,
    profitFactor,
    const DeepCollectionEquality().hash(_symbols),
    createdAt,
  ]);

  /// Create a copy of BacktestResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BacktestResultImplCopyWith<_$BacktestResultImpl> get copyWith =>
      __$$BacktestResultImplCopyWithImpl<_$BacktestResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BacktestResultImplToJson(this);
  }
}

abstract class _BacktestResult implements BacktestResult {
  const factory _BacktestResult({
    final int? id,
    required final String strategy,
    required final DateTime startDate,
    required final DateTime endDate,
    required final double initialCapital,
    required final double finalCapital,
    required final double totalReturn,
    required final double totalReturnPercent,
    required final double maxDrawdown,
    required final double maxDrawdownPercent,
    required final int totalTrades,
    required final int winningTrades,
    required final int losingTrades,
    required final double winRate,
    required final double avgWin,
    required final double avgLoss,
    required final double profitFactor,
    required final List<String> symbols,
    final DateTime? createdAt,
  }) = _$BacktestResultImpl;

  factory _BacktestResult.fromJson(Map<String, dynamic> json) =
      _$BacktestResultImpl.fromJson;

  @override
  int? get id;
  @override
  String get strategy;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  double get initialCapital;
  @override
  double get finalCapital;
  @override
  double get totalReturn;
  @override
  double get totalReturnPercent;
  @override
  double get maxDrawdown;
  @override
  double get maxDrawdownPercent;
  @override
  int get totalTrades;
  @override
  int get winningTrades;
  @override
  int get losingTrades;
  @override
  double get winRate;
  @override
  double get avgWin;
  @override
  double get avgLoss;
  @override
  double get profitFactor;
  @override
  List<String> get symbols;
  @override
  DateTime? get createdAt;

  /// Create a copy of BacktestResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BacktestResultImplCopyWith<_$BacktestResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
