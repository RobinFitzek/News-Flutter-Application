// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) {
  return _JournalEntry.fromJson(json);
}

/// @nodoc
mixin _$JournalEntry {
  int? get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get entryPrice => throw _privateConstructorUsedError;
  double? get exitPrice => throw _privateConstructorUsedError;
  double? get shares => throw _privateConstructorUsedError;
  double? get pnl => throw _privateConstructorUsedError;
  DateTime get entryDate => throw _privateConstructorUsedError;
  DateTime? get exitDate => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  String get mood => throw _privateConstructorUsedError;
  String get tags => throw _privateConstructorUsedError;
  bool get isClosed => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this JournalEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JournalEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JournalEntryCopyWith<JournalEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JournalEntryCopyWith<$Res> {
  factory $JournalEntryCopyWith(
    JournalEntry value,
    $Res Function(JournalEntry) then,
  ) = _$JournalEntryCopyWithImpl<$Res, JournalEntry>;
  @useResult
  $Res call({
    int? id,
    String symbol,
    String type,
    double entryPrice,
    double? exitPrice,
    double? shares,
    double? pnl,
    DateTime entryDate,
    DateTime? exitDate,
    String notes,
    String mood,
    String tags,
    bool isClosed,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$JournalEntryCopyWithImpl<$Res, $Val extends JournalEntry>
    implements $JournalEntryCopyWith<$Res> {
  _$JournalEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JournalEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? type = null,
    Object? entryPrice = null,
    Object? exitPrice = freezed,
    Object? shares = freezed,
    Object? pnl = freezed,
    Object? entryDate = null,
    Object? exitDate = freezed,
    Object? notes = null,
    Object? mood = null,
    Object? tags = null,
    Object? isClosed = null,
    Object? createdAt = freezed,
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
            entryPrice: null == entryPrice
                ? _value.entryPrice
                : entryPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            exitPrice: freezed == exitPrice
                ? _value.exitPrice
                : exitPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            shares: freezed == shares
                ? _value.shares
                : shares // ignore: cast_nullable_to_non_nullable
                      as double?,
            pnl: freezed == pnl
                ? _value.pnl
                : pnl // ignore: cast_nullable_to_non_nullable
                      as double?,
            entryDate: null == entryDate
                ? _value.entryDate
                : entryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            exitDate: freezed == exitDate
                ? _value.exitDate
                : exitDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            mood: null == mood
                ? _value.mood
                : mood // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as String,
            isClosed: null == isClosed
                ? _value.isClosed
                : isClosed // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$JournalEntryImplCopyWith<$Res>
    implements $JournalEntryCopyWith<$Res> {
  factory _$$JournalEntryImplCopyWith(
    _$JournalEntryImpl value,
    $Res Function(_$JournalEntryImpl) then,
  ) = __$$JournalEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String symbol,
    String type,
    double entryPrice,
    double? exitPrice,
    double? shares,
    double? pnl,
    DateTime entryDate,
    DateTime? exitDate,
    String notes,
    String mood,
    String tags,
    bool isClosed,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$JournalEntryImplCopyWithImpl<$Res>
    extends _$JournalEntryCopyWithImpl<$Res, _$JournalEntryImpl>
    implements _$$JournalEntryImplCopyWith<$Res> {
  __$$JournalEntryImplCopyWithImpl(
    _$JournalEntryImpl _value,
    $Res Function(_$JournalEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JournalEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? symbol = null,
    Object? type = null,
    Object? entryPrice = null,
    Object? exitPrice = freezed,
    Object? shares = freezed,
    Object? pnl = freezed,
    Object? entryDate = null,
    Object? exitDate = freezed,
    Object? notes = null,
    Object? mood = null,
    Object? tags = null,
    Object? isClosed = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$JournalEntryImpl(
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
        entryPrice: null == entryPrice
            ? _value.entryPrice
            : entryPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        exitPrice: freezed == exitPrice
            ? _value.exitPrice
            : exitPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        shares: freezed == shares
            ? _value.shares
            : shares // ignore: cast_nullable_to_non_nullable
                  as double?,
        pnl: freezed == pnl
            ? _value.pnl
            : pnl // ignore: cast_nullable_to_non_nullable
                  as double?,
        entryDate: null == entryDate
            ? _value.entryDate
            : entryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        exitDate: freezed == exitDate
            ? _value.exitDate
            : exitDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        mood: null == mood
            ? _value.mood
            : mood // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value.tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as String,
        isClosed: null == isClosed
            ? _value.isClosed
            : isClosed // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$JournalEntryImpl implements _JournalEntry {
  const _$JournalEntryImpl({
    this.id,
    required this.symbol,
    required this.type,
    required this.entryPrice,
    this.exitPrice,
    this.shares,
    this.pnl,
    required this.entryDate,
    this.exitDate,
    required this.notes,
    this.mood = '',
    this.tags = '',
    this.isClosed = false,
    this.createdAt,
  });

  factory _$JournalEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$JournalEntryImplFromJson(json);

  @override
  final int? id;
  @override
  final String symbol;
  @override
  final String type;
  @override
  final double entryPrice;
  @override
  final double? exitPrice;
  @override
  final double? shares;
  @override
  final double? pnl;
  @override
  final DateTime entryDate;
  @override
  final DateTime? exitDate;
  @override
  final String notes;
  @override
  @JsonKey()
  final String mood;
  @override
  @JsonKey()
  final String tags;
  @override
  @JsonKey()
  final bool isClosed;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'JournalEntry(id: $id, symbol: $symbol, type: $type, entryPrice: $entryPrice, exitPrice: $exitPrice, shares: $shares, pnl: $pnl, entryDate: $entryDate, exitDate: $exitDate, notes: $notes, mood: $mood, tags: $tags, isClosed: $isClosed, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JournalEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.entryPrice, entryPrice) ||
                other.entryPrice == entryPrice) &&
            (identical(other.exitPrice, exitPrice) ||
                other.exitPrice == exitPrice) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.pnl, pnl) || other.pnl == pnl) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.exitDate, exitDate) ||
                other.exitDate == exitDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    symbol,
    type,
    entryPrice,
    exitPrice,
    shares,
    pnl,
    entryDate,
    exitDate,
    notes,
    mood,
    tags,
    isClosed,
    createdAt,
  );

  /// Create a copy of JournalEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JournalEntryImplCopyWith<_$JournalEntryImpl> get copyWith =>
      __$$JournalEntryImplCopyWithImpl<_$JournalEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JournalEntryImplToJson(this);
  }
}

abstract class _JournalEntry implements JournalEntry {
  const factory _JournalEntry({
    final int? id,
    required final String symbol,
    required final String type,
    required final double entryPrice,
    final double? exitPrice,
    final double? shares,
    final double? pnl,
    required final DateTime entryDate,
    final DateTime? exitDate,
    required final String notes,
    final String mood,
    final String tags,
    final bool isClosed,
    final DateTime? createdAt,
  }) = _$JournalEntryImpl;

  factory _JournalEntry.fromJson(Map<String, dynamic> json) =
      _$JournalEntryImpl.fromJson;

  @override
  int? get id;
  @override
  String get symbol;
  @override
  String get type;
  @override
  double get entryPrice;
  @override
  double? get exitPrice;
  @override
  double? get shares;
  @override
  double? get pnl;
  @override
  DateTime get entryDate;
  @override
  DateTime? get exitDate;
  @override
  String get notes;
  @override
  String get mood;
  @override
  String get tags;
  @override
  bool get isClosed;
  @override
  DateTime? get createdAt;

  /// Create a copy of JournalEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JournalEntryImplCopyWith<_$JournalEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
