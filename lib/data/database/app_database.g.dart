// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _geminiApiKeyMeta = const VerificationMeta(
    'geminiApiKey',
  );
  @override
  late final GeneratedColumn<String> geminiApiKey = GeneratedColumn<String>(
    'gemini_api_key',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _perplexityApiKeyMeta = const VerificationMeta(
    'perplexityApiKey',
  );
  @override
  late final GeneratedColumn<String> perplexityApiKey = GeneratedColumn<String>(
    'perplexity_api_key',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _analysisIntervalMeta = const VerificationMeta(
    'analysisInterval',
  );
  @override
  late final GeneratedColumn<int> analysisInterval = GeneratedColumn<int>(
    'analysis_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _maxPositionPercentMeta =
      const VerificationMeta('maxPositionPercent');
  @override
  late final GeneratedColumn<double> maxPositionPercent =
      GeneratedColumn<double>(
        'max_position_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(10.0),
      );
  static const VerificationMeta _stopLossPercentMeta = const VerificationMeta(
    'stopLossPercent',
  );
  @override
  late final GeneratedColumn<double> stopLossPercent = GeneratedColumn<double>(
    'stop_loss_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(15.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    geminiApiKey,
    perplexityApiKey,
    themeMode,
    analysisInterval,
    maxPositionPercent,
    stopLossPercent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gemini_api_key')) {
      context.handle(
        _geminiApiKeyMeta,
        geminiApiKey.isAcceptableOrUnknown(
          data['gemini_api_key']!,
          _geminiApiKeyMeta,
        ),
      );
    }
    if (data.containsKey('perplexity_api_key')) {
      context.handle(
        _perplexityApiKeyMeta,
        perplexityApiKey.isAcceptableOrUnknown(
          data['perplexity_api_key']!,
          _perplexityApiKeyMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('analysis_interval')) {
      context.handle(
        _analysisIntervalMeta,
        analysisInterval.isAcceptableOrUnknown(
          data['analysis_interval']!,
          _analysisIntervalMeta,
        ),
      );
    }
    if (data.containsKey('max_position_percent')) {
      context.handle(
        _maxPositionPercentMeta,
        maxPositionPercent.isAcceptableOrUnknown(
          data['max_position_percent']!,
          _maxPositionPercentMeta,
        ),
      );
    }
    if (data.containsKey('stop_loss_percent')) {
      context.handle(
        _stopLossPercentMeta,
        stopLossPercent.isAcceptableOrUnknown(
          data['stop_loss_percent']!,
          _stopLossPercentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      geminiApiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gemini_api_key'],
      ),
      perplexityApiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}perplexity_api_key'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      analysisInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}analysis_interval'],
      )!,
      maxPositionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_position_percent'],
      )!,
      stopLossPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stop_loss_percent'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final int id;
  final String? geminiApiKey;
  final String? perplexityApiKey;
  final String themeMode;
  final int analysisInterval;
  final double maxPositionPercent;
  final double stopLossPercent;
  const UserSetting({
    required this.id,
    this.geminiApiKey,
    this.perplexityApiKey,
    required this.themeMode,
    required this.analysisInterval,
    required this.maxPositionPercent,
    required this.stopLossPercent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || geminiApiKey != null) {
      map['gemini_api_key'] = Variable<String>(geminiApiKey);
    }
    if (!nullToAbsent || perplexityApiKey != null) {
      map['perplexity_api_key'] = Variable<String>(perplexityApiKey);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['analysis_interval'] = Variable<int>(analysisInterval);
    map['max_position_percent'] = Variable<double>(maxPositionPercent);
    map['stop_loss_percent'] = Variable<double>(stopLossPercent);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      geminiApiKey: geminiApiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(geminiApiKey),
      perplexityApiKey: perplexityApiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(perplexityApiKey),
      themeMode: Value(themeMode),
      analysisInterval: Value(analysisInterval),
      maxPositionPercent: Value(maxPositionPercent),
      stopLossPercent: Value(stopLossPercent),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      id: serializer.fromJson<int>(json['id']),
      geminiApiKey: serializer.fromJson<String?>(json['geminiApiKey']),
      perplexityApiKey: serializer.fromJson<String?>(json['perplexityApiKey']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      analysisInterval: serializer.fromJson<int>(json['analysisInterval']),
      maxPositionPercent: serializer.fromJson<double>(
        json['maxPositionPercent'],
      ),
      stopLossPercent: serializer.fromJson<double>(json['stopLossPercent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'geminiApiKey': serializer.toJson<String?>(geminiApiKey),
      'perplexityApiKey': serializer.toJson<String?>(perplexityApiKey),
      'themeMode': serializer.toJson<String>(themeMode),
      'analysisInterval': serializer.toJson<int>(analysisInterval),
      'maxPositionPercent': serializer.toJson<double>(maxPositionPercent),
      'stopLossPercent': serializer.toJson<double>(stopLossPercent),
    };
  }

  UserSetting copyWith({
    int? id,
    Value<String?> geminiApiKey = const Value.absent(),
    Value<String?> perplexityApiKey = const Value.absent(),
    String? themeMode,
    int? analysisInterval,
    double? maxPositionPercent,
    double? stopLossPercent,
  }) => UserSetting(
    id: id ?? this.id,
    geminiApiKey: geminiApiKey.present ? geminiApiKey.value : this.geminiApiKey,
    perplexityApiKey: perplexityApiKey.present
        ? perplexityApiKey.value
        : this.perplexityApiKey,
    themeMode: themeMode ?? this.themeMode,
    analysisInterval: analysisInterval ?? this.analysisInterval,
    maxPositionPercent: maxPositionPercent ?? this.maxPositionPercent,
    stopLossPercent: stopLossPercent ?? this.stopLossPercent,
  );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      id: data.id.present ? data.id.value : this.id,
      geminiApiKey: data.geminiApiKey.present
          ? data.geminiApiKey.value
          : this.geminiApiKey,
      perplexityApiKey: data.perplexityApiKey.present
          ? data.perplexityApiKey.value
          : this.perplexityApiKey,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      analysisInterval: data.analysisInterval.present
          ? data.analysisInterval.value
          : this.analysisInterval,
      maxPositionPercent: data.maxPositionPercent.present
          ? data.maxPositionPercent.value
          : this.maxPositionPercent,
      stopLossPercent: data.stopLossPercent.present
          ? data.stopLossPercent.value
          : this.stopLossPercent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('id: $id, ')
          ..write('geminiApiKey: $geminiApiKey, ')
          ..write('perplexityApiKey: $perplexityApiKey, ')
          ..write('themeMode: $themeMode, ')
          ..write('analysisInterval: $analysisInterval, ')
          ..write('maxPositionPercent: $maxPositionPercent, ')
          ..write('stopLossPercent: $stopLossPercent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    geminiApiKey,
    perplexityApiKey,
    themeMode,
    analysisInterval,
    maxPositionPercent,
    stopLossPercent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.id == this.id &&
          other.geminiApiKey == this.geminiApiKey &&
          other.perplexityApiKey == this.perplexityApiKey &&
          other.themeMode == this.themeMode &&
          other.analysisInterval == this.analysisInterval &&
          other.maxPositionPercent == this.maxPositionPercent &&
          other.stopLossPercent == this.stopLossPercent);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<int> id;
  final Value<String?> geminiApiKey;
  final Value<String?> perplexityApiKey;
  final Value<String> themeMode;
  final Value<int> analysisInterval;
  final Value<double> maxPositionPercent;
  final Value<double> stopLossPercent;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.geminiApiKey = const Value.absent(),
    this.perplexityApiKey = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.analysisInterval = const Value.absent(),
    this.maxPositionPercent = const Value.absent(),
    this.stopLossPercent = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.geminiApiKey = const Value.absent(),
    this.perplexityApiKey = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.analysisInterval = const Value.absent(),
    this.maxPositionPercent = const Value.absent(),
    this.stopLossPercent = const Value.absent(),
  });
  static Insertable<UserSetting> custom({
    Expression<int>? id,
    Expression<String>? geminiApiKey,
    Expression<String>? perplexityApiKey,
    Expression<String>? themeMode,
    Expression<int>? analysisInterval,
    Expression<double>? maxPositionPercent,
    Expression<double>? stopLossPercent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (geminiApiKey != null) 'gemini_api_key': geminiApiKey,
      if (perplexityApiKey != null) 'perplexity_api_key': perplexityApiKey,
      if (themeMode != null) 'theme_mode': themeMode,
      if (analysisInterval != null) 'analysis_interval': analysisInterval,
      if (maxPositionPercent != null)
        'max_position_percent': maxPositionPercent,
      if (stopLossPercent != null) 'stop_loss_percent': stopLossPercent,
    });
  }

  UserSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? geminiApiKey,
    Value<String?>? perplexityApiKey,
    Value<String>? themeMode,
    Value<int>? analysisInterval,
    Value<double>? maxPositionPercent,
    Value<double>? stopLossPercent,
  }) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      geminiApiKey: geminiApiKey ?? this.geminiApiKey,
      perplexityApiKey: perplexityApiKey ?? this.perplexityApiKey,
      themeMode: themeMode ?? this.themeMode,
      analysisInterval: analysisInterval ?? this.analysisInterval,
      maxPositionPercent: maxPositionPercent ?? this.maxPositionPercent,
      stopLossPercent: stopLossPercent ?? this.stopLossPercent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (geminiApiKey.present) {
      map['gemini_api_key'] = Variable<String>(geminiApiKey.value);
    }
    if (perplexityApiKey.present) {
      map['perplexity_api_key'] = Variable<String>(perplexityApiKey.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (analysisInterval.present) {
      map['analysis_interval'] = Variable<int>(analysisInterval.value);
    }
    if (maxPositionPercent.present) {
      map['max_position_percent'] = Variable<double>(maxPositionPercent.value);
    }
    if (stopLossPercent.present) {
      map['stop_loss_percent'] = Variable<double>(stopLossPercent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('geminiApiKey: $geminiApiKey, ')
          ..write('perplexityApiKey: $perplexityApiKey, ')
          ..write('themeMode: $themeMode, ')
          ..write('analysisInterval: $analysisInterval, ')
          ..write('maxPositionPercent: $maxPositionPercent, ')
          ..write('stopLossPercent: $stopLossPercent')
          ..write(')'))
        .toString();
  }
}

class $ApiKeysTable extends ApiKeys with TableInfo<$ApiKeysTable, ApiKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serviceMeta = const VerificationMeta(
    'service',
  );
  @override
  late final GeneratedColumn<String> service = GeneratedColumn<String>(
    'service',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyValueMeta = const VerificationMeta(
    'keyValue',
  );
  @override
  late final GeneratedColumn<String> keyValue = GeneratedColumn<String>(
    'key_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, service, keyValue, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'api_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApiKey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('service')) {
      context.handle(
        _serviceMeta,
        service.isAcceptableOrUnknown(data['service']!, _serviceMeta),
      );
    } else if (isInserting) {
      context.missing(_serviceMeta);
    }
    if (data.containsKey('key_value')) {
      context.handle(
        _keyValueMeta,
        keyValue.isAcceptableOrUnknown(data['key_value']!, _keyValueMeta),
      );
    } else if (isInserting) {
      context.missing(_keyValueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApiKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApiKey(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      service: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service'],
      )!,
      keyValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ApiKeysTable createAlias(String alias) {
    return $ApiKeysTable(attachedDatabase, alias);
  }
}

class ApiKey extends DataClass implements Insertable<ApiKey> {
  final int id;
  final String service;
  final String keyValue;
  final DateTime createdAt;
  const ApiKey({
    required this.id,
    required this.service,
    required this.keyValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['service'] = Variable<String>(service);
    map['key_value'] = Variable<String>(keyValue);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ApiKeysCompanion toCompanion(bool nullToAbsent) {
    return ApiKeysCompanion(
      id: Value(id),
      service: Value(service),
      keyValue: Value(keyValue),
      createdAt: Value(createdAt),
    );
  }

  factory ApiKey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiKey(
      id: serializer.fromJson<int>(json['id']),
      service: serializer.fromJson<String>(json['service']),
      keyValue: serializer.fromJson<String>(json['keyValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'service': serializer.toJson<String>(service),
      'keyValue': serializer.toJson<String>(keyValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ApiKey copyWith({
    int? id,
    String? service,
    String? keyValue,
    DateTime? createdAt,
  }) => ApiKey(
    id: id ?? this.id,
    service: service ?? this.service,
    keyValue: keyValue ?? this.keyValue,
    createdAt: createdAt ?? this.createdAt,
  );
  ApiKey copyWithCompanion(ApiKeysCompanion data) {
    return ApiKey(
      id: data.id.present ? data.id.value : this.id,
      service: data.service.present ? data.service.value : this.service,
      keyValue: data.keyValue.present ? data.keyValue.value : this.keyValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApiKey(')
          ..write('id: $id, ')
          ..write('service: $service, ')
          ..write('keyValue: $keyValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, service, keyValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiKey &&
          other.id == this.id &&
          other.service == this.service &&
          other.keyValue == this.keyValue &&
          other.createdAt == this.createdAt);
}

class ApiKeysCompanion extends UpdateCompanion<ApiKey> {
  final Value<int> id;
  final Value<String> service;
  final Value<String> keyValue;
  final Value<DateTime> createdAt;
  const ApiKeysCompanion({
    this.id = const Value.absent(),
    this.service = const Value.absent(),
    this.keyValue = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ApiKeysCompanion.insert({
    this.id = const Value.absent(),
    required String service,
    required String keyValue,
    required DateTime createdAt,
  }) : service = Value(service),
       keyValue = Value(keyValue),
       createdAt = Value(createdAt);
  static Insertable<ApiKey> custom({
    Expression<int>? id,
    Expression<String>? service,
    Expression<String>? keyValue,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (service != null) 'service': service,
      if (keyValue != null) 'key_value': keyValue,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ApiKeysCompanion copyWith({
    Value<int>? id,
    Value<String>? service,
    Value<String>? keyValue,
    Value<DateTime>? createdAt,
  }) {
    return ApiKeysCompanion(
      id: id ?? this.id,
      service: service ?? this.service,
      keyValue: keyValue ?? this.keyValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (keyValue.present) {
      map['key_value'] = Variable<String>(keyValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiKeysCompanion(')
          ..write('id: $id, ')
          ..write('service: $service, ')
          ..write('keyValue: $keyValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WatchlistItemsTable extends WatchlistItems
    with TableInfo<$WatchlistItemsTable, WatchlistItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchlistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('core'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastPriceMeta = const VerificationMeta(
    'lastPrice',
  );
  @override
  late final GeneratedColumn<double> lastPrice = GeneratedColumn<double>(
    'last_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastPriceChangeMeta = const VerificationMeta(
    'lastPriceChange',
  );
  @override
  late final GeneratedColumn<double> lastPriceChange = GeneratedColumn<double>(
    'last_price_change',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    addedAt,
    tier,
    note,
    groupName,
    lastPrice,
    lastPriceChange,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'watchlist_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<WatchlistItemData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    }
    if (data.containsKey('last_price')) {
      context.handle(
        _lastPriceMeta,
        lastPrice.isAcceptableOrUnknown(data['last_price']!, _lastPriceMeta),
      );
    }
    if (data.containsKey('last_price_change')) {
      context.handle(
        _lastPriceChangeMeta,
        lastPriceChange.isAcceptableOrUnknown(
          data['last_price_change']!,
          _lastPriceChangeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WatchlistItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WatchlistItemData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      ),
      lastPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_price'],
      ),
      lastPriceChange: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_price_change'],
      ),
    );
  }

  @override
  $WatchlistItemsTable createAlias(String alias) {
    return $WatchlistItemsTable(attachedDatabase, alias);
  }
}

class WatchlistItemData extends DataClass
    implements Insertable<WatchlistItemData> {
  final int id;
  final String symbol;
  final DateTime addedAt;
  final String tier;
  final String? note;
  final String? groupName;
  final double? lastPrice;
  final double? lastPriceChange;
  const WatchlistItemData({
    required this.id,
    required this.symbol,
    required this.addedAt,
    required this.tier,
    this.note,
    this.groupName,
    this.lastPrice,
    this.lastPriceChange,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['added_at'] = Variable<DateTime>(addedAt);
    map['tier'] = Variable<String>(tier);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || groupName != null) {
      map['group_name'] = Variable<String>(groupName);
    }
    if (!nullToAbsent || lastPrice != null) {
      map['last_price'] = Variable<double>(lastPrice);
    }
    if (!nullToAbsent || lastPriceChange != null) {
      map['last_price_change'] = Variable<double>(lastPriceChange);
    }
    return map;
  }

  WatchlistItemsCompanion toCompanion(bool nullToAbsent) {
    return WatchlistItemsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      addedAt: Value(addedAt),
      tier: Value(tier),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      groupName: groupName == null && nullToAbsent
          ? const Value.absent()
          : Value(groupName),
      lastPrice: lastPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPrice),
      lastPriceChange: lastPriceChange == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPriceChange),
    );
  }

  factory WatchlistItemData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchlistItemData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      tier: serializer.fromJson<String>(json['tier']),
      note: serializer.fromJson<String?>(json['note']),
      groupName: serializer.fromJson<String?>(json['groupName']),
      lastPrice: serializer.fromJson<double?>(json['lastPrice']),
      lastPriceChange: serializer.fromJson<double?>(json['lastPriceChange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'tier': serializer.toJson<String>(tier),
      'note': serializer.toJson<String?>(note),
      'groupName': serializer.toJson<String?>(groupName),
      'lastPrice': serializer.toJson<double?>(lastPrice),
      'lastPriceChange': serializer.toJson<double?>(lastPriceChange),
    };
  }

  WatchlistItemData copyWith({
    int? id,
    String? symbol,
    DateTime? addedAt,
    String? tier,
    Value<String?> note = const Value.absent(),
    Value<String?> groupName = const Value.absent(),
    Value<double?> lastPrice = const Value.absent(),
    Value<double?> lastPriceChange = const Value.absent(),
  }) => WatchlistItemData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    addedAt: addedAt ?? this.addedAt,
    tier: tier ?? this.tier,
    note: note.present ? note.value : this.note,
    groupName: groupName.present ? groupName.value : this.groupName,
    lastPrice: lastPrice.present ? lastPrice.value : this.lastPrice,
    lastPriceChange: lastPriceChange.present
        ? lastPriceChange.value
        : this.lastPriceChange,
  );
  WatchlistItemData copyWithCompanion(WatchlistItemsCompanion data) {
    return WatchlistItemData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      tier: data.tier.present ? data.tier.value : this.tier,
      note: data.note.present ? data.note.value : this.note,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      lastPrice: data.lastPrice.present ? data.lastPrice.value : this.lastPrice,
      lastPriceChange: data.lastPriceChange.present
          ? data.lastPriceChange.value
          : this.lastPriceChange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WatchlistItemData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('addedAt: $addedAt, ')
          ..write('tier: $tier, ')
          ..write('note: $note, ')
          ..write('groupName: $groupName, ')
          ..write('lastPrice: $lastPrice, ')
          ..write('lastPriceChange: $lastPriceChange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    addedAt,
    tier,
    note,
    groupName,
    lastPrice,
    lastPriceChange,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchlistItemData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.addedAt == this.addedAt &&
          other.tier == this.tier &&
          other.note == this.note &&
          other.groupName == this.groupName &&
          other.lastPrice == this.lastPrice &&
          other.lastPriceChange == this.lastPriceChange);
}

class WatchlistItemsCompanion extends UpdateCompanion<WatchlistItemData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<DateTime> addedAt;
  final Value<String> tier;
  final Value<String?> note;
  final Value<String?> groupName;
  final Value<double?> lastPrice;
  final Value<double?> lastPriceChange;
  const WatchlistItemsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.tier = const Value.absent(),
    this.note = const Value.absent(),
    this.groupName = const Value.absent(),
    this.lastPrice = const Value.absent(),
    this.lastPriceChange = const Value.absent(),
  });
  WatchlistItemsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    this.addedAt = const Value.absent(),
    this.tier = const Value.absent(),
    this.note = const Value.absent(),
    this.groupName = const Value.absent(),
    this.lastPrice = const Value.absent(),
    this.lastPriceChange = const Value.absent(),
  }) : symbol = Value(symbol);
  static Insertable<WatchlistItemData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<DateTime>? addedAt,
    Expression<String>? tier,
    Expression<String>? note,
    Expression<String>? groupName,
    Expression<double>? lastPrice,
    Expression<double>? lastPriceChange,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (addedAt != null) 'added_at': addedAt,
      if (tier != null) 'tier': tier,
      if (note != null) 'note': note,
      if (groupName != null) 'group_name': groupName,
      if (lastPrice != null) 'last_price': lastPrice,
      if (lastPriceChange != null) 'last_price_change': lastPriceChange,
    });
  }

  WatchlistItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<DateTime>? addedAt,
    Value<String>? tier,
    Value<String?>? note,
    Value<String?>? groupName,
    Value<double?>? lastPrice,
    Value<double?>? lastPriceChange,
  }) {
    return WatchlistItemsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      addedAt: addedAt ?? this.addedAt,
      tier: tier ?? this.tier,
      note: note ?? this.note,
      groupName: groupName ?? this.groupName,
      lastPrice: lastPrice ?? this.lastPrice,
      lastPriceChange: lastPriceChange ?? this.lastPriceChange,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (lastPrice.present) {
      map['last_price'] = Variable<double>(lastPrice.value);
    }
    if (lastPriceChange.present) {
      map['last_price_change'] = Variable<double>(lastPriceChange.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchlistItemsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('addedAt: $addedAt, ')
          ..write('tier: $tier, ')
          ..write('note: $note, ')
          ..write('groupName: $groupName, ')
          ..write('lastPrice: $lastPrice, ')
          ..write('lastPriceChange: $lastPriceChange')
          ..write(')'))
        .toString();
  }
}

class $StockCacheTable extends StockCache
    with TableInfo<$StockCacheTable, StockCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousCloseMeta = const VerificationMeta(
    'previousClose',
  );
  @override
  late final GeneratedColumn<double> previousClose = GeneratedColumn<double>(
    'previous_close',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeMeta = const VerificationMeta('change');
  @override
  late final GeneratedColumn<double> change = GeneratedColumn<double>(
    'change',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changePercentMeta = const VerificationMeta(
    'changePercent',
  );
  @override
  late final GeneratedColumn<double> changePercent = GeneratedColumn<double>(
    'change_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayHighMeta = const VerificationMeta(
    'dayHigh',
  );
  @override
  late final GeneratedColumn<double> dayHigh = GeneratedColumn<double>(
    'day_high',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayLowMeta = const VerificationMeta('dayLow');
  @override
  late final GeneratedColumn<double> dayLow = GeneratedColumn<double>(
    'day_low',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
    'volume',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketCapMeta = const VerificationMeta(
    'marketCap',
  );
  @override
  late final GeneratedColumn<double> marketCap = GeneratedColumn<double>(
    'market_cap',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
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
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPriceMeta);
    }
    if (data.containsKey('previous_close')) {
      context.handle(
        _previousCloseMeta,
        previousClose.isAcceptableOrUnknown(
          data['previous_close']!,
          _previousCloseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousCloseMeta);
    }
    if (data.containsKey('change')) {
      context.handle(
        _changeMeta,
        change.isAcceptableOrUnknown(data['change']!, _changeMeta),
      );
    } else if (isInserting) {
      context.missing(_changeMeta);
    }
    if (data.containsKey('change_percent')) {
      context.handle(
        _changePercentMeta,
        changePercent.isAcceptableOrUnknown(
          data['change_percent']!,
          _changePercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_changePercentMeta);
    }
    if (data.containsKey('day_high')) {
      context.handle(
        _dayHighMeta,
        dayHigh.isAcceptableOrUnknown(data['day_high']!, _dayHighMeta),
      );
    } else if (isInserting) {
      context.missing(_dayHighMeta);
    }
    if (data.containsKey('day_low')) {
      context.handle(
        _dayLowMeta,
        dayLow.isAcceptableOrUnknown(data['day_low']!, _dayLowMeta),
      );
    } else if (isInserting) {
      context.missing(_dayLowMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(
        _volumeMeta,
        volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('market_cap')) {
      context.handle(
        _marketCapMeta,
        marketCap.isAcceptableOrUnknown(data['market_cap']!, _marketCapMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      previousClose: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_close'],
      )!,
      change: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}change'],
      )!,
      changePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}change_percent'],
      )!,
      dayHigh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}day_high'],
      )!,
      dayLow: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}day_low'],
      )!,
      volume: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume'],
      )!,
      marketCap: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}market_cap'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $StockCacheTable createAlias(String alias) {
    return $StockCacheTable(attachedDatabase, alias);
  }
}

class StockCacheData extends DataClass implements Insertable<StockCacheData> {
  final int id;
  final String symbol;
  final String companyName;
  final double currentPrice;
  final double previousClose;
  final double change;
  final double changePercent;
  final double dayHigh;
  final double dayLow;
  final int volume;
  final double? marketCap;
  final DateTime timestamp;
  final DateTime cachedAt;
  const StockCacheData({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.previousClose,
    required this.change,
    required this.changePercent,
    required this.dayHigh,
    required this.dayLow,
    required this.volume,
    this.marketCap,
    required this.timestamp,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['company_name'] = Variable<String>(companyName);
    map['current_price'] = Variable<double>(currentPrice);
    map['previous_close'] = Variable<double>(previousClose);
    map['change'] = Variable<double>(change);
    map['change_percent'] = Variable<double>(changePercent);
    map['day_high'] = Variable<double>(dayHigh);
    map['day_low'] = Variable<double>(dayLow);
    map['volume'] = Variable<int>(volume);
    if (!nullToAbsent || marketCap != null) {
      map['market_cap'] = Variable<double>(marketCap);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  StockCacheCompanion toCompanion(bool nullToAbsent) {
    return StockCacheCompanion(
      id: Value(id),
      symbol: Value(symbol),
      companyName: Value(companyName),
      currentPrice: Value(currentPrice),
      previousClose: Value(previousClose),
      change: Value(change),
      changePercent: Value(changePercent),
      dayHigh: Value(dayHigh),
      dayLow: Value(dayLow),
      volume: Value(volume),
      marketCap: marketCap == null && nullToAbsent
          ? const Value.absent()
          : Value(marketCap),
      timestamp: Value(timestamp),
      cachedAt: Value(cachedAt),
    );
  }

  factory StockCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockCacheData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      companyName: serializer.fromJson<String>(json['companyName']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      previousClose: serializer.fromJson<double>(json['previousClose']),
      change: serializer.fromJson<double>(json['change']),
      changePercent: serializer.fromJson<double>(json['changePercent']),
      dayHigh: serializer.fromJson<double>(json['dayHigh']),
      dayLow: serializer.fromJson<double>(json['dayLow']),
      volume: serializer.fromJson<int>(json['volume']),
      marketCap: serializer.fromJson<double?>(json['marketCap']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'companyName': serializer.toJson<String>(companyName),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'previousClose': serializer.toJson<double>(previousClose),
      'change': serializer.toJson<double>(change),
      'changePercent': serializer.toJson<double>(changePercent),
      'dayHigh': serializer.toJson<double>(dayHigh),
      'dayLow': serializer.toJson<double>(dayLow),
      'volume': serializer.toJson<int>(volume),
      'marketCap': serializer.toJson<double?>(marketCap),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  StockCacheData copyWith({
    int? id,
    String? symbol,
    String? companyName,
    double? currentPrice,
    double? previousClose,
    double? change,
    double? changePercent,
    double? dayHigh,
    double? dayLow,
    int? volume,
    Value<double?> marketCap = const Value.absent(),
    DateTime? timestamp,
    DateTime? cachedAt,
  }) => StockCacheData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    companyName: companyName ?? this.companyName,
    currentPrice: currentPrice ?? this.currentPrice,
    previousClose: previousClose ?? this.previousClose,
    change: change ?? this.change,
    changePercent: changePercent ?? this.changePercent,
    dayHigh: dayHigh ?? this.dayHigh,
    dayLow: dayLow ?? this.dayLow,
    volume: volume ?? this.volume,
    marketCap: marketCap.present ? marketCap.value : this.marketCap,
    timestamp: timestamp ?? this.timestamp,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  StockCacheData copyWithCompanion(StockCacheCompanion data) {
    return StockCacheData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      previousClose: data.previousClose.present
          ? data.previousClose.value
          : this.previousClose,
      change: data.change.present ? data.change.value : this.change,
      changePercent: data.changePercent.present
          ? data.changePercent.value
          : this.changePercent,
      dayHigh: data.dayHigh.present ? data.dayHigh.value : this.dayHigh,
      dayLow: data.dayLow.present ? data.dayLow.value : this.dayLow,
      volume: data.volume.present ? data.volume.value : this.volume,
      marketCap: data.marketCap.present ? data.marketCap.value : this.marketCap,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockCacheData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('companyName: $companyName, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('previousClose: $previousClose, ')
          ..write('change: $change, ')
          ..write('changePercent: $changePercent, ')
          ..write('dayHigh: $dayHigh, ')
          ..write('dayLow: $dayLow, ')
          ..write('volume: $volume, ')
          ..write('marketCap: $marketCap, ')
          ..write('timestamp: $timestamp, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
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
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockCacheData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.companyName == this.companyName &&
          other.currentPrice == this.currentPrice &&
          other.previousClose == this.previousClose &&
          other.change == this.change &&
          other.changePercent == this.changePercent &&
          other.dayHigh == this.dayHigh &&
          other.dayLow == this.dayLow &&
          other.volume == this.volume &&
          other.marketCap == this.marketCap &&
          other.timestamp == this.timestamp &&
          other.cachedAt == this.cachedAt);
}

class StockCacheCompanion extends UpdateCompanion<StockCacheData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> companyName;
  final Value<double> currentPrice;
  final Value<double> previousClose;
  final Value<double> change;
  final Value<double> changePercent;
  final Value<double> dayHigh;
  final Value<double> dayLow;
  final Value<int> volume;
  final Value<double?> marketCap;
  final Value<DateTime> timestamp;
  final Value<DateTime> cachedAt;
  const StockCacheCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.companyName = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.previousClose = const Value.absent(),
    this.change = const Value.absent(),
    this.changePercent = const Value.absent(),
    this.dayHigh = const Value.absent(),
    this.dayLow = const Value.absent(),
    this.volume = const Value.absent(),
    this.marketCap = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  StockCacheCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    this.companyName = const Value.absent(),
    required double currentPrice,
    required double previousClose,
    required double change,
    required double changePercent,
    required double dayHigh,
    required double dayLow,
    required int volume,
    this.marketCap = const Value.absent(),
    required DateTime timestamp,
    this.cachedAt = const Value.absent(),
  }) : symbol = Value(symbol),
       currentPrice = Value(currentPrice),
       previousClose = Value(previousClose),
       change = Value(change),
       changePercent = Value(changePercent),
       dayHigh = Value(dayHigh),
       dayLow = Value(dayLow),
       volume = Value(volume),
       timestamp = Value(timestamp);
  static Insertable<StockCacheData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? companyName,
    Expression<double>? currentPrice,
    Expression<double>? previousClose,
    Expression<double>? change,
    Expression<double>? changePercent,
    Expression<double>? dayHigh,
    Expression<double>? dayLow,
    Expression<int>? volume,
    Expression<double>? marketCap,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (companyName != null) 'company_name': companyName,
      if (currentPrice != null) 'current_price': currentPrice,
      if (previousClose != null) 'previous_close': previousClose,
      if (change != null) 'change': change,
      if (changePercent != null) 'change_percent': changePercent,
      if (dayHigh != null) 'day_high': dayHigh,
      if (dayLow != null) 'day_low': dayLow,
      if (volume != null) 'volume': volume,
      if (marketCap != null) 'market_cap': marketCap,
      if (timestamp != null) 'timestamp': timestamp,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  StockCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? companyName,
    Value<double>? currentPrice,
    Value<double>? previousClose,
    Value<double>? change,
    Value<double>? changePercent,
    Value<double>? dayHigh,
    Value<double>? dayLow,
    Value<int>? volume,
    Value<double?>? marketCap,
    Value<DateTime>? timestamp,
    Value<DateTime>? cachedAt,
  }) {
    return StockCacheCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      currentPrice: currentPrice ?? this.currentPrice,
      previousClose: previousClose ?? this.previousClose,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      dayHigh: dayHigh ?? this.dayHigh,
      dayLow: dayLow ?? this.dayLow,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      timestamp: timestamp ?? this.timestamp,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (previousClose.present) {
      map['previous_close'] = Variable<double>(previousClose.value);
    }
    if (change.present) {
      map['change'] = Variable<double>(change.value);
    }
    if (changePercent.present) {
      map['change_percent'] = Variable<double>(changePercent.value);
    }
    if (dayHigh.present) {
      map['day_high'] = Variable<double>(dayHigh.value);
    }
    if (dayLow.present) {
      map['day_low'] = Variable<double>(dayLow.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (marketCap.present) {
      map['market_cap'] = Variable<double>(marketCap.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockCacheCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('companyName: $companyName, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('previousClose: $previousClose, ')
          ..write('change: $change, ')
          ..write('changePercent: $changePercent, ')
          ..write('dayHigh: $dayHigh, ')
          ..write('dayLow: $dayLow, ')
          ..write('volume: $volume, ')
          ..write('marketCap: $marketCap, ')
          ..write('timestamp: $timestamp, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

class $AiProvidersTable extends AiProviders
    with TableInfo<$AiProvidersTable, AiProviderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isConnectedMeta = const VerificationMeta(
    'isConnected',
  );
  @override
  late final GeneratedColumn<bool> isConnected = GeneratedColumn<bool>(
    'is_connected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_connected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _totalCallsMeta = const VerificationMeta(
    'totalCalls',
  );
  @override
  late final GeneratedColumn<int> totalCalls = GeneratedColumn<int>(
    'total_calls',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastTestedAtMeta = const VerificationMeta(
    'lastTestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastTestedAt = GeneratedColumn<DateTime>(
    'last_tested_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProviderData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_apiKeyMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('is_connected')) {
      context.handle(
        _isConnectedMeta,
        isConnected.isAcceptableOrUnknown(
          data['is_connected']!,
          _isConnectedMeta,
        ),
      );
    }
    if (data.containsKey('total_calls')) {
      context.handle(
        _totalCallsMeta,
        totalCalls.isAcceptableOrUnknown(data['total_calls']!, _totalCallsMeta),
      );
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    }
    if (data.containsKey('last_tested_at')) {
      context.handle(
        _lastTestedAtMeta,
        lastTestedAt.isAcceptableOrUnknown(
          data['last_tested_at']!,
          _lastTestedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiProviderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProviderData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      isConnected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_connected'],
      )!,
      totalCalls: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_calls'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      lastTestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_tested_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AiProvidersTable createAlias(String alias) {
    return $AiProvidersTable(attachedDatabase, alias);
  }
}

class AiProviderData extends DataClass implements Insertable<AiProviderData> {
  final int id;
  final String name;
  final String type;
  final String baseUrl;
  final String apiKey;
  final String model;
  final bool isEnabled;
  final bool isConnected;
  final int totalCalls;
  final double totalCost;
  final DateTime? lastTestedAt;
  final DateTime createdAt;
  const AiProviderData({
    required this.id,
    required this.name,
    required this.type,
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    required this.isEnabled,
    required this.isConnected,
    required this.totalCalls,
    required this.totalCost,
    this.lastTestedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['base_url'] = Variable<String>(baseUrl);
    map['api_key'] = Variable<String>(apiKey);
    map['model'] = Variable<String>(model);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['is_connected'] = Variable<bool>(isConnected);
    map['total_calls'] = Variable<int>(totalCalls);
    map['total_cost'] = Variable<double>(totalCost);
    if (!nullToAbsent || lastTestedAt != null) {
      map['last_tested_at'] = Variable<DateTime>(lastTestedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AiProvidersCompanion toCompanion(bool nullToAbsent) {
    return AiProvidersCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      baseUrl: Value(baseUrl),
      apiKey: Value(apiKey),
      model: Value(model),
      isEnabled: Value(isEnabled),
      isConnected: Value(isConnected),
      totalCalls: Value(totalCalls),
      totalCost: Value(totalCost),
      lastTestedAt: lastTestedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTestedAt),
      createdAt: Value(createdAt),
    );
  }

  factory AiProviderData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProviderData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      apiKey: serializer.fromJson<String>(json['apiKey']),
      model: serializer.fromJson<String>(json['model']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      isConnected: serializer.fromJson<bool>(json['isConnected']),
      totalCalls: serializer.fromJson<int>(json['totalCalls']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      lastTestedAt: serializer.fromJson<DateTime?>(json['lastTestedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'apiKey': serializer.toJson<String>(apiKey),
      'model': serializer.toJson<String>(model),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'isConnected': serializer.toJson<bool>(isConnected),
      'totalCalls': serializer.toJson<int>(totalCalls),
      'totalCost': serializer.toJson<double>(totalCost),
      'lastTestedAt': serializer.toJson<DateTime?>(lastTestedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AiProviderData copyWith({
    int? id,
    String? name,
    String? type,
    String? baseUrl,
    String? apiKey,
    String? model,
    bool? isEnabled,
    bool? isConnected,
    int? totalCalls,
    double? totalCost,
    Value<DateTime?> lastTestedAt = const Value.absent(),
    DateTime? createdAt,
  }) => AiProviderData(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    baseUrl: baseUrl ?? this.baseUrl,
    apiKey: apiKey ?? this.apiKey,
    model: model ?? this.model,
    isEnabled: isEnabled ?? this.isEnabled,
    isConnected: isConnected ?? this.isConnected,
    totalCalls: totalCalls ?? this.totalCalls,
    totalCost: totalCost ?? this.totalCost,
    lastTestedAt: lastTestedAt.present ? lastTestedAt.value : this.lastTestedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  AiProviderData copyWithCompanion(AiProvidersCompanion data) {
    return AiProviderData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      model: data.model.present ? data.model.value : this.model,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      isConnected: data.isConnected.present
          ? data.isConnected.value
          : this.isConnected,
      totalCalls: data.totalCalls.present
          ? data.totalCalls.value
          : this.totalCalls,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      lastTestedAt: data.lastTestedAt.present
          ? data.lastTestedAt.value
          : this.lastTestedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('model: $model, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isConnected: $isConnected, ')
          ..write('totalCalls: $totalCalls, ')
          ..write('totalCost: $totalCost, ')
          ..write('lastTestedAt: $lastTestedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProviderData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.baseUrl == this.baseUrl &&
          other.apiKey == this.apiKey &&
          other.model == this.model &&
          other.isEnabled == this.isEnabled &&
          other.isConnected == this.isConnected &&
          other.totalCalls == this.totalCalls &&
          other.totalCost == this.totalCost &&
          other.lastTestedAt == this.lastTestedAt &&
          other.createdAt == this.createdAt);
}

class AiProvidersCompanion extends UpdateCompanion<AiProviderData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> baseUrl;
  final Value<String> apiKey;
  final Value<String> model;
  final Value<bool> isEnabled;
  final Value<bool> isConnected;
  final Value<int> totalCalls;
  final Value<double> totalCost;
  final Value<DateTime?> lastTestedAt;
  final Value<DateTime> createdAt;
  const AiProvidersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.model = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.isConnected = const Value.absent(),
    this.totalCalls = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.lastTestedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AiProvidersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    required String baseUrl,
    required String apiKey,
    required String model,
    this.isEnabled = const Value.absent(),
    this.isConnected = const Value.absent(),
    this.totalCalls = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.lastTestedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       type = Value(type),
       baseUrl = Value(baseUrl),
       apiKey = Value(apiKey),
       model = Value(model);
  static Insertable<AiProviderData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? baseUrl,
    Expression<String>? apiKey,
    Expression<String>? model,
    Expression<bool>? isEnabled,
    Expression<bool>? isConnected,
    Expression<int>? totalCalls,
    Expression<double>? totalCost,
    Expression<DateTime>? lastTestedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (baseUrl != null) 'base_url': baseUrl,
      if (apiKey != null) 'api_key': apiKey,
      if (model != null) 'model': model,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (isConnected != null) 'is_connected': isConnected,
      if (totalCalls != null) 'total_calls': totalCalls,
      if (totalCost != null) 'total_cost': totalCost,
      if (lastTestedAt != null) 'last_tested_at': lastTestedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AiProvidersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? baseUrl,
    Value<String>? apiKey,
    Value<String>? model,
    Value<bool>? isEnabled,
    Value<bool>? isConnected,
    Value<int>? totalCalls,
    Value<double>? totalCost,
    Value<DateTime?>? lastTestedAt,
    Value<DateTime>? createdAt,
  }) {
    return AiProvidersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      model: model ?? this.model,
      isEnabled: isEnabled ?? this.isEnabled,
      isConnected: isConnected ?? this.isConnected,
      totalCalls: totalCalls ?? this.totalCalls,
      totalCost: totalCost ?? this.totalCost,
      lastTestedAt: lastTestedAt ?? this.lastTestedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (isConnected.present) {
      map['is_connected'] = Variable<bool>(isConnected.value);
    }
    if (totalCalls.present) {
      map['total_calls'] = Variable<int>(totalCalls.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (lastTestedAt.present) {
      map['last_tested_at'] = Variable<DateTime>(lastTestedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProvidersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('model: $model, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isConnected: $isConnected, ')
          ..write('totalCalls: $totalCalls, ')
          ..write('totalCost: $totalCost, ')
          ..write('lastTestedAt: $lastTestedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StageAssignmentsTable extends StageAssignments
    with TableInfo<$StageAssignmentsTable, StageAssignmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StageAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, stage, providerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stage_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<StageAssignmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StageAssignmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StageAssignmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
    );
  }

  @override
  $StageAssignmentsTable createAlias(String alias) {
    return $StageAssignmentsTable(attachedDatabase, alias);
  }
}

class StageAssignmentData extends DataClass
    implements Insertable<StageAssignmentData> {
  final int id;
  final String stage;
  final int providerId;
  const StageAssignmentData({
    required this.id,
    required this.stage,
    required this.providerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stage'] = Variable<String>(stage);
    map['provider_id'] = Variable<int>(providerId);
    return map;
  }

  StageAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return StageAssignmentsCompanion(
      id: Value(id),
      stage: Value(stage),
      providerId: Value(providerId),
    );
  }

  factory StageAssignmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StageAssignmentData(
      id: serializer.fromJson<int>(json['id']),
      stage: serializer.fromJson<String>(json['stage']),
      providerId: serializer.fromJson<int>(json['providerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stage': serializer.toJson<String>(stage),
      'providerId': serializer.toJson<int>(providerId),
    };
  }

  StageAssignmentData copyWith({int? id, String? stage, int? providerId}) =>
      StageAssignmentData(
        id: id ?? this.id,
        stage: stage ?? this.stage,
        providerId: providerId ?? this.providerId,
      );
  StageAssignmentData copyWithCompanion(StageAssignmentsCompanion data) {
    return StageAssignmentData(
      id: data.id.present ? data.id.value : this.id,
      stage: data.stage.present ? data.stage.value : this.stage,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StageAssignmentData(')
          ..write('id: $id, ')
          ..write('stage: $stage, ')
          ..write('providerId: $providerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stage, providerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StageAssignmentData &&
          other.id == this.id &&
          other.stage == this.stage &&
          other.providerId == this.providerId);
}

class StageAssignmentsCompanion extends UpdateCompanion<StageAssignmentData> {
  final Value<int> id;
  final Value<String> stage;
  final Value<int> providerId;
  const StageAssignmentsCompanion({
    this.id = const Value.absent(),
    this.stage = const Value.absent(),
    this.providerId = const Value.absent(),
  });
  StageAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required String stage,
    required int providerId,
  }) : stage = Value(stage),
       providerId = Value(providerId);
  static Insertable<StageAssignmentData> custom({
    Expression<int>? id,
    Expression<String>? stage,
    Expression<int>? providerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stage != null) 'stage': stage,
      if (providerId != null) 'provider_id': providerId,
    });
  }

  StageAssignmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? stage,
    Value<int>? providerId,
  }) {
    return StageAssignmentsCompanion(
      id: id ?? this.id,
      stage: stage ?? this.stage,
      providerId: providerId ?? this.providerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StageAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('stage: $stage, ')
          ..write('providerId: $providerId')
          ..write(')'))
        .toString();
  }
}

class $AnalysisResultsTable extends AnalysisResults
    with TableInfo<$AnalysisResultsTable, AnalysisResultData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnalysisResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _predictedPriceMeta = const VerificationMeta(
    'predictedPrice',
  );
  @override
  late final GeneratedColumn<double> predictedPrice = GeneratedColumn<double>(
    'predicted_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recommendationMeta = const VerificationMeta(
    'recommendation',
  );
  @override
  late final GeneratedColumn<String> recommendation = GeneratedColumn<String>(
    'recommendation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasoningMeta = const VerificationMeta(
    'reasoning',
  );
  @override
  late final GeneratedColumn<String> reasoning = GeneratedColumn<String>(
    'reasoning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newsSummaryMeta = const VerificationMeta(
    'newsSummary',
  );
  @override
  late final GeneratedColumn<String> newsSummary = GeneratedColumn<String>(
    'news_summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _timeframeMeta = const VerificationMeta(
    'timeframe',
  );
  @override
  late final GeneratedColumn<String> timeframe = GeneratedColumn<String>(
    'timeframe',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('daily'),
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    predictedPrice,
    confidence,
    recommendation,
    reasoning,
    newsSummary,
    timeframe,
    currentPrice,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'analysis_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnalysisResultData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('predicted_price')) {
      context.handle(
        _predictedPriceMeta,
        predictedPrice.isAcceptableOrUnknown(
          data['predicted_price']!,
          _predictedPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_predictedPriceMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('recommendation')) {
      context.handle(
        _recommendationMeta,
        recommendation.isAcceptableOrUnknown(
          data['recommendation']!,
          _recommendationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recommendationMeta);
    }
    if (data.containsKey('reasoning')) {
      context.handle(
        _reasoningMeta,
        reasoning.isAcceptableOrUnknown(data['reasoning']!, _reasoningMeta),
      );
    } else if (isInserting) {
      context.missing(_reasoningMeta);
    }
    if (data.containsKey('news_summary')) {
      context.handle(
        _newsSummaryMeta,
        newsSummary.isAcceptableOrUnknown(
          data['news_summary']!,
          _newsSummaryMeta,
        ),
      );
    }
    if (data.containsKey('timeframe')) {
      context.handle(
        _timeframeMeta,
        timeframe.isAcceptableOrUnknown(data['timeframe']!, _timeframeMeta),
      );
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPriceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnalysisResultData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnalysisResultData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      predictedPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}predicted_price'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      recommendation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation'],
      )!,
      reasoning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reasoning'],
      )!,
      newsSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}news_summary'],
      )!,
      timeframe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timeframe'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AnalysisResultsTable createAlias(String alias) {
    return $AnalysisResultsTable(attachedDatabase, alias);
  }
}

class AnalysisResultData extends DataClass
    implements Insertable<AnalysisResultData> {
  final int id;
  final String symbol;
  final double predictedPrice;
  final double confidence;
  final String recommendation;
  final String reasoning;
  final String newsSummary;
  final String timeframe;
  final double currentPrice;
  final DateTime createdAt;
  const AnalysisResultData({
    required this.id,
    required this.symbol,
    required this.predictedPrice,
    required this.confidence,
    required this.recommendation,
    required this.reasoning,
    required this.newsSummary,
    required this.timeframe,
    required this.currentPrice,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['predicted_price'] = Variable<double>(predictedPrice);
    map['confidence'] = Variable<double>(confidence);
    map['recommendation'] = Variable<String>(recommendation);
    map['reasoning'] = Variable<String>(reasoning);
    map['news_summary'] = Variable<String>(newsSummary);
    map['timeframe'] = Variable<String>(timeframe);
    map['current_price'] = Variable<double>(currentPrice);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AnalysisResultsCompanion toCompanion(bool nullToAbsent) {
    return AnalysisResultsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      predictedPrice: Value(predictedPrice),
      confidence: Value(confidence),
      recommendation: Value(recommendation),
      reasoning: Value(reasoning),
      newsSummary: Value(newsSummary),
      timeframe: Value(timeframe),
      currentPrice: Value(currentPrice),
      createdAt: Value(createdAt),
    );
  }

  factory AnalysisResultData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnalysisResultData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      predictedPrice: serializer.fromJson<double>(json['predictedPrice']),
      confidence: serializer.fromJson<double>(json['confidence']),
      recommendation: serializer.fromJson<String>(json['recommendation']),
      reasoning: serializer.fromJson<String>(json['reasoning']),
      newsSummary: serializer.fromJson<String>(json['newsSummary']),
      timeframe: serializer.fromJson<String>(json['timeframe']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'predictedPrice': serializer.toJson<double>(predictedPrice),
      'confidence': serializer.toJson<double>(confidence),
      'recommendation': serializer.toJson<String>(recommendation),
      'reasoning': serializer.toJson<String>(reasoning),
      'newsSummary': serializer.toJson<String>(newsSummary),
      'timeframe': serializer.toJson<String>(timeframe),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AnalysisResultData copyWith({
    int? id,
    String? symbol,
    double? predictedPrice,
    double? confidence,
    String? recommendation,
    String? reasoning,
    String? newsSummary,
    String? timeframe,
    double? currentPrice,
    DateTime? createdAt,
  }) => AnalysisResultData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    predictedPrice: predictedPrice ?? this.predictedPrice,
    confidence: confidence ?? this.confidence,
    recommendation: recommendation ?? this.recommendation,
    reasoning: reasoning ?? this.reasoning,
    newsSummary: newsSummary ?? this.newsSummary,
    timeframe: timeframe ?? this.timeframe,
    currentPrice: currentPrice ?? this.currentPrice,
    createdAt: createdAt ?? this.createdAt,
  );
  AnalysisResultData copyWithCompanion(AnalysisResultsCompanion data) {
    return AnalysisResultData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      predictedPrice: data.predictedPrice.present
          ? data.predictedPrice.value
          : this.predictedPrice,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      recommendation: data.recommendation.present
          ? data.recommendation.value
          : this.recommendation,
      reasoning: data.reasoning.present ? data.reasoning.value : this.reasoning,
      newsSummary: data.newsSummary.present
          ? data.newsSummary.value
          : this.newsSummary,
      timeframe: data.timeframe.present ? data.timeframe.value : this.timeframe,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnalysisResultData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('predictedPrice: $predictedPrice, ')
          ..write('confidence: $confidence, ')
          ..write('recommendation: $recommendation, ')
          ..write('reasoning: $reasoning, ')
          ..write('newsSummary: $newsSummary, ')
          ..write('timeframe: $timeframe, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    predictedPrice,
    confidence,
    recommendation,
    reasoning,
    newsSummary,
    timeframe,
    currentPrice,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnalysisResultData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.predictedPrice == this.predictedPrice &&
          other.confidence == this.confidence &&
          other.recommendation == this.recommendation &&
          other.reasoning == this.reasoning &&
          other.newsSummary == this.newsSummary &&
          other.timeframe == this.timeframe &&
          other.currentPrice == this.currentPrice &&
          other.createdAt == this.createdAt);
}

class AnalysisResultsCompanion extends UpdateCompanion<AnalysisResultData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<double> predictedPrice;
  final Value<double> confidence;
  final Value<String> recommendation;
  final Value<String> reasoning;
  final Value<String> newsSummary;
  final Value<String> timeframe;
  final Value<double> currentPrice;
  final Value<DateTime> createdAt;
  const AnalysisResultsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.predictedPrice = const Value.absent(),
    this.confidence = const Value.absent(),
    this.recommendation = const Value.absent(),
    this.reasoning = const Value.absent(),
    this.newsSummary = const Value.absent(),
    this.timeframe = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AnalysisResultsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required double predictedPrice,
    required double confidence,
    required String recommendation,
    required String reasoning,
    this.newsSummary = const Value.absent(),
    this.timeframe = const Value.absent(),
    required double currentPrice,
    this.createdAt = const Value.absent(),
  }) : symbol = Value(symbol),
       predictedPrice = Value(predictedPrice),
       confidence = Value(confidence),
       recommendation = Value(recommendation),
       reasoning = Value(reasoning),
       currentPrice = Value(currentPrice);
  static Insertable<AnalysisResultData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<double>? predictedPrice,
    Expression<double>? confidence,
    Expression<String>? recommendation,
    Expression<String>? reasoning,
    Expression<String>? newsSummary,
    Expression<String>? timeframe,
    Expression<double>? currentPrice,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (predictedPrice != null) 'predicted_price': predictedPrice,
      if (confidence != null) 'confidence': confidence,
      if (recommendation != null) 'recommendation': recommendation,
      if (reasoning != null) 'reasoning': reasoning,
      if (newsSummary != null) 'news_summary': newsSummary,
      if (timeframe != null) 'timeframe': timeframe,
      if (currentPrice != null) 'current_price': currentPrice,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AnalysisResultsCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<double>? predictedPrice,
    Value<double>? confidence,
    Value<String>? recommendation,
    Value<String>? reasoning,
    Value<String>? newsSummary,
    Value<String>? timeframe,
    Value<double>? currentPrice,
    Value<DateTime>? createdAt,
  }) {
    return AnalysisResultsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      predictedPrice: predictedPrice ?? this.predictedPrice,
      confidence: confidence ?? this.confidence,
      recommendation: recommendation ?? this.recommendation,
      reasoning: reasoning ?? this.reasoning,
      newsSummary: newsSummary ?? this.newsSummary,
      timeframe: timeframe ?? this.timeframe,
      currentPrice: currentPrice ?? this.currentPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (predictedPrice.present) {
      map['predicted_price'] = Variable<double>(predictedPrice.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (recommendation.present) {
      map['recommendation'] = Variable<String>(recommendation.value);
    }
    if (reasoning.present) {
      map['reasoning'] = Variable<String>(reasoning.value);
    }
    if (newsSummary.present) {
      map['news_summary'] = Variable<String>(newsSummary.value);
    }
    if (timeframe.present) {
      map['timeframe'] = Variable<String>(timeframe.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnalysisResultsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('predictedPrice: $predictedPrice, ')
          ..write('confidence: $confidence, ')
          ..write('recommendation: $recommendation, ')
          ..write('reasoning: $reasoning, ')
          ..write('newsSummary: $newsSummary, ')
          ..write('timeframe: $timeframe, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PortfolioPositionsTable extends PortfolioPositions
    with TableInfo<$PortfolioPositionsTable, PositionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortfolioPositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<double> shares = GeneratedColumn<double>(
    'shares',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgCostBasisMeta = const VerificationMeta(
    'avgCostBasis',
  );
  @override
  late final GeneratedColumn<double> avgCostBasis = GeneratedColumn<double>(
    'avg_cost_basis',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _acquiredAtMeta = const VerificationMeta(
    'acquiredAt',
  );
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
    'acquired_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    companyName,
    shares,
    avgCostBasis,
    currentPrice,
    acquiredAt,
    currency,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'portfolio_positions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PositionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
    }
    if (data.containsKey('avg_cost_basis')) {
      context.handle(
        _avgCostBasisMeta,
        avgCostBasis.isAcceptableOrUnknown(
          data['avg_cost_basis']!,
          _avgCostBasisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_avgCostBasisMeta);
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
        _acquiredAtMeta,
        acquiredAt.isAcceptableOrUnknown(data['acquired_at']!, _acquiredAtMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PositionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PositionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shares'],
      )!,
      avgCostBasis: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_cost_basis'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      acquiredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquired_at'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PortfolioPositionsTable createAlias(String alias) {
    return $PortfolioPositionsTable(attachedDatabase, alias);
  }
}

class PositionData extends DataClass implements Insertable<PositionData> {
  final int id;
  final String symbol;
  final String companyName;
  final double shares;
  final double avgCostBasis;
  final double currentPrice;
  final DateTime acquiredAt;
  final String currency;
  final String? note;
  const PositionData({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.shares,
    required this.avgCostBasis,
    required this.currentPrice,
    required this.acquiredAt,
    required this.currency,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['company_name'] = Variable<String>(companyName);
    map['shares'] = Variable<double>(shares);
    map['avg_cost_basis'] = Variable<double>(avgCostBasis);
    map['current_price'] = Variable<double>(currentPrice);
    map['acquired_at'] = Variable<DateTime>(acquiredAt);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PortfolioPositionsCompanion toCompanion(bool nullToAbsent) {
    return PortfolioPositionsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      companyName: Value(companyName),
      shares: Value(shares),
      avgCostBasis: Value(avgCostBasis),
      currentPrice: Value(currentPrice),
      acquiredAt: Value(acquiredAt),
      currency: Value(currency),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PositionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PositionData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      companyName: serializer.fromJson<String>(json['companyName']),
      shares: serializer.fromJson<double>(json['shares']),
      avgCostBasis: serializer.fromJson<double>(json['avgCostBasis']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      acquiredAt: serializer.fromJson<DateTime>(json['acquiredAt']),
      currency: serializer.fromJson<String>(json['currency']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'companyName': serializer.toJson<String>(companyName),
      'shares': serializer.toJson<double>(shares),
      'avgCostBasis': serializer.toJson<double>(avgCostBasis),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'acquiredAt': serializer.toJson<DateTime>(acquiredAt),
      'currency': serializer.toJson<String>(currency),
      'note': serializer.toJson<String?>(note),
    };
  }

  PositionData copyWith({
    int? id,
    String? symbol,
    String? companyName,
    double? shares,
    double? avgCostBasis,
    double? currentPrice,
    DateTime? acquiredAt,
    String? currency,
    Value<String?> note = const Value.absent(),
  }) => PositionData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    companyName: companyName ?? this.companyName,
    shares: shares ?? this.shares,
    avgCostBasis: avgCostBasis ?? this.avgCostBasis,
    currentPrice: currentPrice ?? this.currentPrice,
    acquiredAt: acquiredAt ?? this.acquiredAt,
    currency: currency ?? this.currency,
    note: note.present ? note.value : this.note,
  );
  PositionData copyWithCompanion(PortfolioPositionsCompanion data) {
    return PositionData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      shares: data.shares.present ? data.shares.value : this.shares,
      avgCostBasis: data.avgCostBasis.present
          ? data.avgCostBasis.value
          : this.avgCostBasis,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      acquiredAt: data.acquiredAt.present
          ? data.acquiredAt.value
          : this.acquiredAt,
      currency: data.currency.present ? data.currency.value : this.currency,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PositionData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('companyName: $companyName, ')
          ..write('shares: $shares, ')
          ..write('avgCostBasis: $avgCostBasis, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('currency: $currency, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    companyName,
    shares,
    avgCostBasis,
    currentPrice,
    acquiredAt,
    currency,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PositionData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.companyName == this.companyName &&
          other.shares == this.shares &&
          other.avgCostBasis == this.avgCostBasis &&
          other.currentPrice == this.currentPrice &&
          other.acquiredAt == this.acquiredAt &&
          other.currency == this.currency &&
          other.note == this.note);
}

class PortfolioPositionsCompanion extends UpdateCompanion<PositionData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> companyName;
  final Value<double> shares;
  final Value<double> avgCostBasis;
  final Value<double> currentPrice;
  final Value<DateTime> acquiredAt;
  final Value<String> currency;
  final Value<String?> note;
  const PortfolioPositionsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.companyName = const Value.absent(),
    this.shares = const Value.absent(),
    this.avgCostBasis = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.currency = const Value.absent(),
    this.note = const Value.absent(),
  });
  PortfolioPositionsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    this.companyName = const Value.absent(),
    required double shares,
    required double avgCostBasis,
    this.currentPrice = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.currency = const Value.absent(),
    this.note = const Value.absent(),
  }) : symbol = Value(symbol),
       shares = Value(shares),
       avgCostBasis = Value(avgCostBasis);
  static Insertable<PositionData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? companyName,
    Expression<double>? shares,
    Expression<double>? avgCostBasis,
    Expression<double>? currentPrice,
    Expression<DateTime>? acquiredAt,
    Expression<String>? currency,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (companyName != null) 'company_name': companyName,
      if (shares != null) 'shares': shares,
      if (avgCostBasis != null) 'avg_cost_basis': avgCostBasis,
      if (currentPrice != null) 'current_price': currentPrice,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
      if (currency != null) 'currency': currency,
      if (note != null) 'note': note,
    });
  }

  PortfolioPositionsCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? companyName,
    Value<double>? shares,
    Value<double>? avgCostBasis,
    Value<double>? currentPrice,
    Value<DateTime>? acquiredAt,
    Value<String>? currency,
    Value<String?>? note,
  }) {
    return PortfolioPositionsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      shares: shares ?? this.shares,
      avgCostBasis: avgCostBasis ?? this.avgCostBasis,
      currentPrice: currentPrice ?? this.currentPrice,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      currency: currency ?? this.currency,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (shares.present) {
      map['shares'] = Variable<double>(shares.value);
    }
    if (avgCostBasis.present) {
      map['avg_cost_basis'] = Variable<double>(avgCostBasis.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortfolioPositionsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('companyName: $companyName, ')
          ..write('shares: $shares, ')
          ..write('avgCostBasis: $avgCostBasis, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('currency: $currency, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $PaperTradesTable extends PaperTrades
    with TableInfo<$PaperTradesTable, PaperTradeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaperTradesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<double> shares = GeneratedColumn<double>(
    'shares',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _executedAtMeta = const VerificationMeta(
    'executedAt',
  );
  @override
  late final GeneratedColumn<DateTime> executedAt = GeneratedColumn<DateTime>(
    'executed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('OPEN'),
  );
  static const VerificationMeta _exitReasonMeta = const VerificationMeta(
    'exitReason',
  );
  @override
  late final GeneratedColumn<String> exitReason = GeneratedColumn<String>(
    'exit_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exitPriceMeta = const VerificationMeta(
    'exitPrice',
  );
  @override
  late final GeneratedColumn<double> exitPrice = GeneratedColumn<double>(
    'exit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _realizedPnlMeta = const VerificationMeta(
    'realizedPnl',
  );
  @override
  late final GeneratedColumn<double> realizedPnl = GeneratedColumn<double>(
    'realized_pnl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    type,
    shares,
    price,
    executedAt,
    status,
    exitReason,
    exitPrice,
    closedAt,
    realizedPnl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paper_trades';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaperTradeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('executed_at')) {
      context.handle(
        _executedAtMeta,
        executedAt.isAcceptableOrUnknown(data['executed_at']!, _executedAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('exit_reason')) {
      context.handle(
        _exitReasonMeta,
        exitReason.isAcceptableOrUnknown(data['exit_reason']!, _exitReasonMeta),
      );
    }
    if (data.containsKey('exit_price')) {
      context.handle(
        _exitPriceMeta,
        exitPrice.isAcceptableOrUnknown(data['exit_price']!, _exitPriceMeta),
      );
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    if (data.containsKey('realized_pnl')) {
      context.handle(
        _realizedPnlMeta,
        realizedPnl.isAcceptableOrUnknown(
          data['realized_pnl']!,
          _realizedPnlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaperTradeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaperTradeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shares'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      executedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}executed_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      exitReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exit_reason'],
      ),
      exitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exit_price'],
      ),
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
      realizedPnl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}realized_pnl'],
      ),
    );
  }

  @override
  $PaperTradesTable createAlias(String alias) {
    return $PaperTradesTable(attachedDatabase, alias);
  }
}

class PaperTradeData extends DataClass implements Insertable<PaperTradeData> {
  final int id;
  final String symbol;
  final String type;
  final double shares;
  final double price;
  final DateTime executedAt;
  final String status;
  final String? exitReason;
  final double? exitPrice;
  final DateTime? closedAt;
  final double? realizedPnl;
  const PaperTradeData({
    required this.id,
    required this.symbol,
    required this.type,
    required this.shares,
    required this.price,
    required this.executedAt,
    required this.status,
    this.exitReason,
    this.exitPrice,
    this.closedAt,
    this.realizedPnl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['type'] = Variable<String>(type);
    map['shares'] = Variable<double>(shares);
    map['price'] = Variable<double>(price);
    map['executed_at'] = Variable<DateTime>(executedAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || exitReason != null) {
      map['exit_reason'] = Variable<String>(exitReason);
    }
    if (!nullToAbsent || exitPrice != null) {
      map['exit_price'] = Variable<double>(exitPrice);
    }
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || realizedPnl != null) {
      map['realized_pnl'] = Variable<double>(realizedPnl);
    }
    return map;
  }

  PaperTradesCompanion toCompanion(bool nullToAbsent) {
    return PaperTradesCompanion(
      id: Value(id),
      symbol: Value(symbol),
      type: Value(type),
      shares: Value(shares),
      price: Value(price),
      executedAt: Value(executedAt),
      status: Value(status),
      exitReason: exitReason == null && nullToAbsent
          ? const Value.absent()
          : Value(exitReason),
      exitPrice: exitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(exitPrice),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      realizedPnl: realizedPnl == null && nullToAbsent
          ? const Value.absent()
          : Value(realizedPnl),
    );
  }

  factory PaperTradeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaperTradeData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      type: serializer.fromJson<String>(json['type']),
      shares: serializer.fromJson<double>(json['shares']),
      price: serializer.fromJson<double>(json['price']),
      executedAt: serializer.fromJson<DateTime>(json['executedAt']),
      status: serializer.fromJson<String>(json['status']),
      exitReason: serializer.fromJson<String?>(json['exitReason']),
      exitPrice: serializer.fromJson<double?>(json['exitPrice']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      realizedPnl: serializer.fromJson<double?>(json['realizedPnl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'type': serializer.toJson<String>(type),
      'shares': serializer.toJson<double>(shares),
      'price': serializer.toJson<double>(price),
      'executedAt': serializer.toJson<DateTime>(executedAt),
      'status': serializer.toJson<String>(status),
      'exitReason': serializer.toJson<String?>(exitReason),
      'exitPrice': serializer.toJson<double?>(exitPrice),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'realizedPnl': serializer.toJson<double?>(realizedPnl),
    };
  }

  PaperTradeData copyWith({
    int? id,
    String? symbol,
    String? type,
    double? shares,
    double? price,
    DateTime? executedAt,
    String? status,
    Value<String?> exitReason = const Value.absent(),
    Value<double?> exitPrice = const Value.absent(),
    Value<DateTime?> closedAt = const Value.absent(),
    Value<double?> realizedPnl = const Value.absent(),
  }) => PaperTradeData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    type: type ?? this.type,
    shares: shares ?? this.shares,
    price: price ?? this.price,
    executedAt: executedAt ?? this.executedAt,
    status: status ?? this.status,
    exitReason: exitReason.present ? exitReason.value : this.exitReason,
    exitPrice: exitPrice.present ? exitPrice.value : this.exitPrice,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
    realizedPnl: realizedPnl.present ? realizedPnl.value : this.realizedPnl,
  );
  PaperTradeData copyWithCompanion(PaperTradesCompanion data) {
    return PaperTradeData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      type: data.type.present ? data.type.value : this.type,
      shares: data.shares.present ? data.shares.value : this.shares,
      price: data.price.present ? data.price.value : this.price,
      executedAt: data.executedAt.present
          ? data.executedAt.value
          : this.executedAt,
      status: data.status.present ? data.status.value : this.status,
      exitReason: data.exitReason.present
          ? data.exitReason.value
          : this.exitReason,
      exitPrice: data.exitPrice.present ? data.exitPrice.value : this.exitPrice,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      realizedPnl: data.realizedPnl.present
          ? data.realizedPnl.value
          : this.realizedPnl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaperTradeData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('shares: $shares, ')
          ..write('price: $price, ')
          ..write('executedAt: $executedAt, ')
          ..write('status: $status, ')
          ..write('exitReason: $exitReason, ')
          ..write('exitPrice: $exitPrice, ')
          ..write('closedAt: $closedAt, ')
          ..write('realizedPnl: $realizedPnl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    type,
    shares,
    price,
    executedAt,
    status,
    exitReason,
    exitPrice,
    closedAt,
    realizedPnl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaperTradeData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.type == this.type &&
          other.shares == this.shares &&
          other.price == this.price &&
          other.executedAt == this.executedAt &&
          other.status == this.status &&
          other.exitReason == this.exitReason &&
          other.exitPrice == this.exitPrice &&
          other.closedAt == this.closedAt &&
          other.realizedPnl == this.realizedPnl);
}

class PaperTradesCompanion extends UpdateCompanion<PaperTradeData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> type;
  final Value<double> shares;
  final Value<double> price;
  final Value<DateTime> executedAt;
  final Value<String> status;
  final Value<String?> exitReason;
  final Value<double?> exitPrice;
  final Value<DateTime?> closedAt;
  final Value<double?> realizedPnl;
  const PaperTradesCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.type = const Value.absent(),
    this.shares = const Value.absent(),
    this.price = const Value.absent(),
    this.executedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.exitReason = const Value.absent(),
    this.exitPrice = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.realizedPnl = const Value.absent(),
  });
  PaperTradesCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required String type,
    required double shares,
    required double price,
    this.executedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.exitReason = const Value.absent(),
    this.exitPrice = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.realizedPnl = const Value.absent(),
  }) : symbol = Value(symbol),
       type = Value(type),
       shares = Value(shares),
       price = Value(price);
  static Insertable<PaperTradeData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? type,
    Expression<double>? shares,
    Expression<double>? price,
    Expression<DateTime>? executedAt,
    Expression<String>? status,
    Expression<String>? exitReason,
    Expression<double>? exitPrice,
    Expression<DateTime>? closedAt,
    Expression<double>? realizedPnl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (type != null) 'type': type,
      if (shares != null) 'shares': shares,
      if (price != null) 'price': price,
      if (executedAt != null) 'executed_at': executedAt,
      if (status != null) 'status': status,
      if (exitReason != null) 'exit_reason': exitReason,
      if (exitPrice != null) 'exit_price': exitPrice,
      if (closedAt != null) 'closed_at': closedAt,
      if (realizedPnl != null) 'realized_pnl': realizedPnl,
    });
  }

  PaperTradesCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? type,
    Value<double>? shares,
    Value<double>? price,
    Value<DateTime>? executedAt,
    Value<String>? status,
    Value<String?>? exitReason,
    Value<double?>? exitPrice,
    Value<DateTime?>? closedAt,
    Value<double?>? realizedPnl,
  }) {
    return PaperTradesCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      shares: shares ?? this.shares,
      price: price ?? this.price,
      executedAt: executedAt ?? this.executedAt,
      status: status ?? this.status,
      exitReason: exitReason ?? this.exitReason,
      exitPrice: exitPrice ?? this.exitPrice,
      closedAt: closedAt ?? this.closedAt,
      realizedPnl: realizedPnl ?? this.realizedPnl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (shares.present) {
      map['shares'] = Variable<double>(shares.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (executedAt.present) {
      map['executed_at'] = Variable<DateTime>(executedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (exitReason.present) {
      map['exit_reason'] = Variable<String>(exitReason.value);
    }
    if (exitPrice.present) {
      map['exit_price'] = Variable<double>(exitPrice.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (realizedPnl.present) {
      map['realized_pnl'] = Variable<double>(realizedPnl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaperTradesCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('shares: $shares, ')
          ..write('price: $price, ')
          ..write('executedAt: $executedAt, ')
          ..write('status: $status, ')
          ..write('exitReason: $exitReason, ')
          ..write('exitPrice: $exitPrice, ')
          ..write('closedAt: $closedAt, ')
          ..write('realizedPnl: $realizedPnl')
          ..write(')'))
        .toString();
  }
}

class $PaperSettingsTable extends PaperSettings
    with TableInfo<$PaperSettingsTable, PaperSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaperSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startingCapitalMeta = const VerificationMeta(
    'startingCapital',
  );
  @override
  late final GeneratedColumn<double> startingCapital = GeneratedColumn<double>(
    'starting_capital',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(100000.0),
  );
  static const VerificationMeta _takeProfitPercentMeta = const VerificationMeta(
    'takeProfitPercent',
  );
  @override
  late final GeneratedColumn<double> takeProfitPercent =
      GeneratedColumn<double>(
        'take_profit_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(15.0),
      );
  static const VerificationMeta _stopLossPercentMeta = const VerificationMeta(
    'stopLossPercent',
  );
  @override
  late final GeneratedColumn<double> stopLossPercent = GeneratedColumn<double>(
    'stop_loss_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(10.0),
  );
  static const VerificationMeta _maxOpenTradesMeta = const VerificationMeta(
    'maxOpenTrades',
  );
  @override
  late final GeneratedColumn<int> maxOpenTrades = GeneratedColumn<int>(
    'max_open_trades',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _positionSizePercentMeta =
      const VerificationMeta('positionSizePercent');
  @override
  late final GeneratedColumn<double> positionSizePercent =
      GeneratedColumn<double>(
        'position_size_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(20.0),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startingCapital,
    takeProfitPercent,
    stopLossPercent,
    maxOpenTrades,
    positionSizePercent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paper_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaperSettingsData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('starting_capital')) {
      context.handle(
        _startingCapitalMeta,
        startingCapital.isAcceptableOrUnknown(
          data['starting_capital']!,
          _startingCapitalMeta,
        ),
      );
    }
    if (data.containsKey('take_profit_percent')) {
      context.handle(
        _takeProfitPercentMeta,
        takeProfitPercent.isAcceptableOrUnknown(
          data['take_profit_percent']!,
          _takeProfitPercentMeta,
        ),
      );
    }
    if (data.containsKey('stop_loss_percent')) {
      context.handle(
        _stopLossPercentMeta,
        stopLossPercent.isAcceptableOrUnknown(
          data['stop_loss_percent']!,
          _stopLossPercentMeta,
        ),
      );
    }
    if (data.containsKey('max_open_trades')) {
      context.handle(
        _maxOpenTradesMeta,
        maxOpenTrades.isAcceptableOrUnknown(
          data['max_open_trades']!,
          _maxOpenTradesMeta,
        ),
      );
    }
    if (data.containsKey('position_size_percent')) {
      context.handle(
        _positionSizePercentMeta,
        positionSizePercent.isAcceptableOrUnknown(
          data['position_size_percent']!,
          _positionSizePercentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaperSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaperSettingsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startingCapital: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}starting_capital'],
      )!,
      takeProfitPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}take_profit_percent'],
      )!,
      stopLossPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stop_loss_percent'],
      )!,
      maxOpenTrades: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_open_trades'],
      )!,
      positionSizePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}position_size_percent'],
      )!,
    );
  }

  @override
  $PaperSettingsTable createAlias(String alias) {
    return $PaperSettingsTable(attachedDatabase, alias);
  }
}

class PaperSettingsData extends DataClass
    implements Insertable<PaperSettingsData> {
  final int id;
  final double startingCapital;
  final double takeProfitPercent;
  final double stopLossPercent;
  final int maxOpenTrades;
  final double positionSizePercent;
  const PaperSettingsData({
    required this.id,
    required this.startingCapital,
    required this.takeProfitPercent,
    required this.stopLossPercent,
    required this.maxOpenTrades,
    required this.positionSizePercent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['starting_capital'] = Variable<double>(startingCapital);
    map['take_profit_percent'] = Variable<double>(takeProfitPercent);
    map['stop_loss_percent'] = Variable<double>(stopLossPercent);
    map['max_open_trades'] = Variable<int>(maxOpenTrades);
    map['position_size_percent'] = Variable<double>(positionSizePercent);
    return map;
  }

  PaperSettingsCompanion toCompanion(bool nullToAbsent) {
    return PaperSettingsCompanion(
      id: Value(id),
      startingCapital: Value(startingCapital),
      takeProfitPercent: Value(takeProfitPercent),
      stopLossPercent: Value(stopLossPercent),
      maxOpenTrades: Value(maxOpenTrades),
      positionSizePercent: Value(positionSizePercent),
    );
  }

  factory PaperSettingsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaperSettingsData(
      id: serializer.fromJson<int>(json['id']),
      startingCapital: serializer.fromJson<double>(json['startingCapital']),
      takeProfitPercent: serializer.fromJson<double>(json['takeProfitPercent']),
      stopLossPercent: serializer.fromJson<double>(json['stopLossPercent']),
      maxOpenTrades: serializer.fromJson<int>(json['maxOpenTrades']),
      positionSizePercent: serializer.fromJson<double>(
        json['positionSizePercent'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startingCapital': serializer.toJson<double>(startingCapital),
      'takeProfitPercent': serializer.toJson<double>(takeProfitPercent),
      'stopLossPercent': serializer.toJson<double>(stopLossPercent),
      'maxOpenTrades': serializer.toJson<int>(maxOpenTrades),
      'positionSizePercent': serializer.toJson<double>(positionSizePercent),
    };
  }

  PaperSettingsData copyWith({
    int? id,
    double? startingCapital,
    double? takeProfitPercent,
    double? stopLossPercent,
    int? maxOpenTrades,
    double? positionSizePercent,
  }) => PaperSettingsData(
    id: id ?? this.id,
    startingCapital: startingCapital ?? this.startingCapital,
    takeProfitPercent: takeProfitPercent ?? this.takeProfitPercent,
    stopLossPercent: stopLossPercent ?? this.stopLossPercent,
    maxOpenTrades: maxOpenTrades ?? this.maxOpenTrades,
    positionSizePercent: positionSizePercent ?? this.positionSizePercent,
  );
  PaperSettingsData copyWithCompanion(PaperSettingsCompanion data) {
    return PaperSettingsData(
      id: data.id.present ? data.id.value : this.id,
      startingCapital: data.startingCapital.present
          ? data.startingCapital.value
          : this.startingCapital,
      takeProfitPercent: data.takeProfitPercent.present
          ? data.takeProfitPercent.value
          : this.takeProfitPercent,
      stopLossPercent: data.stopLossPercent.present
          ? data.stopLossPercent.value
          : this.stopLossPercent,
      maxOpenTrades: data.maxOpenTrades.present
          ? data.maxOpenTrades.value
          : this.maxOpenTrades,
      positionSizePercent: data.positionSizePercent.present
          ? data.positionSizePercent.value
          : this.positionSizePercent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaperSettingsData(')
          ..write('id: $id, ')
          ..write('startingCapital: $startingCapital, ')
          ..write('takeProfitPercent: $takeProfitPercent, ')
          ..write('stopLossPercent: $stopLossPercent, ')
          ..write('maxOpenTrades: $maxOpenTrades, ')
          ..write('positionSizePercent: $positionSizePercent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startingCapital,
    takeProfitPercent,
    stopLossPercent,
    maxOpenTrades,
    positionSizePercent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaperSettingsData &&
          other.id == this.id &&
          other.startingCapital == this.startingCapital &&
          other.takeProfitPercent == this.takeProfitPercent &&
          other.stopLossPercent == this.stopLossPercent &&
          other.maxOpenTrades == this.maxOpenTrades &&
          other.positionSizePercent == this.positionSizePercent);
}

class PaperSettingsCompanion extends UpdateCompanion<PaperSettingsData> {
  final Value<int> id;
  final Value<double> startingCapital;
  final Value<double> takeProfitPercent;
  final Value<double> stopLossPercent;
  final Value<int> maxOpenTrades;
  final Value<double> positionSizePercent;
  const PaperSettingsCompanion({
    this.id = const Value.absent(),
    this.startingCapital = const Value.absent(),
    this.takeProfitPercent = const Value.absent(),
    this.stopLossPercent = const Value.absent(),
    this.maxOpenTrades = const Value.absent(),
    this.positionSizePercent = const Value.absent(),
  });
  PaperSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.startingCapital = const Value.absent(),
    this.takeProfitPercent = const Value.absent(),
    this.stopLossPercent = const Value.absent(),
    this.maxOpenTrades = const Value.absent(),
    this.positionSizePercent = const Value.absent(),
  });
  static Insertable<PaperSettingsData> custom({
    Expression<int>? id,
    Expression<double>? startingCapital,
    Expression<double>? takeProfitPercent,
    Expression<double>? stopLossPercent,
    Expression<int>? maxOpenTrades,
    Expression<double>? positionSizePercent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startingCapital != null) 'starting_capital': startingCapital,
      if (takeProfitPercent != null) 'take_profit_percent': takeProfitPercent,
      if (stopLossPercent != null) 'stop_loss_percent': stopLossPercent,
      if (maxOpenTrades != null) 'max_open_trades': maxOpenTrades,
      if (positionSizePercent != null)
        'position_size_percent': positionSizePercent,
    });
  }

  PaperSettingsCompanion copyWith({
    Value<int>? id,
    Value<double>? startingCapital,
    Value<double>? takeProfitPercent,
    Value<double>? stopLossPercent,
    Value<int>? maxOpenTrades,
    Value<double>? positionSizePercent,
  }) {
    return PaperSettingsCompanion(
      id: id ?? this.id,
      startingCapital: startingCapital ?? this.startingCapital,
      takeProfitPercent: takeProfitPercent ?? this.takeProfitPercent,
      stopLossPercent: stopLossPercent ?? this.stopLossPercent,
      maxOpenTrades: maxOpenTrades ?? this.maxOpenTrades,
      positionSizePercent: positionSizePercent ?? this.positionSizePercent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startingCapital.present) {
      map['starting_capital'] = Variable<double>(startingCapital.value);
    }
    if (takeProfitPercent.present) {
      map['take_profit_percent'] = Variable<double>(takeProfitPercent.value);
    }
    if (stopLossPercent.present) {
      map['stop_loss_percent'] = Variable<double>(stopLossPercent.value);
    }
    if (maxOpenTrades.present) {
      map['max_open_trades'] = Variable<int>(maxOpenTrades.value);
    }
    if (positionSizePercent.present) {
      map['position_size_percent'] = Variable<double>(
        positionSizePercent.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaperSettingsCompanion(')
          ..write('id: $id, ')
          ..write('startingCapital: $startingCapital, ')
          ..write('takeProfitPercent: $takeProfitPercent, ')
          ..write('stopLossPercent: $stopLossPercent, ')
          ..write('maxOpenTrades: $maxOpenTrades, ')
          ..write('positionSizePercent: $positionSizePercent')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $ApiKeysTable apiKeys = $ApiKeysTable(this);
  late final $WatchlistItemsTable watchlistItems = $WatchlistItemsTable(this);
  late final $StockCacheTable stockCache = $StockCacheTable(this);
  late final $AiProvidersTable aiProviders = $AiProvidersTable(this);
  late final $StageAssignmentsTable stageAssignments = $StageAssignmentsTable(
    this,
  );
  late final $AnalysisResultsTable analysisResults = $AnalysisResultsTable(
    this,
  );
  late final $PortfolioPositionsTable portfolioPositions =
      $PortfolioPositionsTable(this);
  late final $PaperTradesTable paperTrades = $PaperTradesTable(this);
  late final $PaperSettingsTable paperSettings = $PaperSettingsTable(this);
  late final Index idxWatchlistSymbol = Index(
    'idx_watchlist_symbol',
    'CREATE INDEX idx_watchlist_symbol ON watchlist_items (symbol)',
  );
  late final Index idxCacheSymbol = Index(
    'idx_cache_symbol',
    'CREATE UNIQUE INDEX idx_cache_symbol ON stock_cache (symbol)',
  );
  late final Index idxStageUnique = Index(
    'idx_stage_unique',
    'CREATE UNIQUE INDEX idx_stage_unique ON stage_assignments (stage)',
  );
  late final Index idxAnalysisSymbol = Index(
    'idx_analysis_symbol',
    'CREATE INDEX idx_analysis_symbol ON analysis_results (symbol)',
  );
  late final Index idxAnalysisCreated = Index(
    'idx_analysis_created',
    'CREATE INDEX idx_analysis_created ON analysis_results (created_at)',
  );
  late final Index idxPositionSymbol = Index(
    'idx_position_symbol',
    'CREATE INDEX idx_position_symbol ON portfolio_positions (symbol)',
  );
  late final Index idxPaperSymbol = Index(
    'idx_paper_symbol',
    'CREATE INDEX idx_paper_symbol ON paper_trades (symbol)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userSettings,
    apiKeys,
    watchlistItems,
    stockCache,
    aiProviders,
    stageAssignments,
    analysisResults,
    portfolioPositions,
    paperTrades,
    paperSettings,
    idxWatchlistSymbol,
    idxCacheSymbol,
    idxStageUnique,
    idxAnalysisSymbol,
    idxAnalysisCreated,
    idxPositionSymbol,
    idxPaperSymbol,
  ];
}

typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<int> id,
      Value<String?> geminiApiKey,
      Value<String?> perplexityApiKey,
      Value<String> themeMode,
      Value<int> analysisInterval,
      Value<double> maxPositionPercent,
      Value<double> stopLossPercent,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<int> id,
      Value<String?> geminiApiKey,
      Value<String?> perplexityApiKey,
      Value<String> themeMode,
      Value<int> analysisInterval,
      Value<double> maxPositionPercent,
      Value<double> stopLossPercent,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get geminiApiKey => $composableBuilder(
    column: $table.geminiApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get perplexityApiKey => $composableBuilder(
    column: $table.perplexityApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get analysisInterval => $composableBuilder(
    column: $table.analysisInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxPositionPercent => $composableBuilder(
    column: $table.maxPositionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stopLossPercent => $composableBuilder(
    column: $table.stopLossPercent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get geminiApiKey => $composableBuilder(
    column: $table.geminiApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get perplexityApiKey => $composableBuilder(
    column: $table.perplexityApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get analysisInterval => $composableBuilder(
    column: $table.analysisInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxPositionPercent => $composableBuilder(
    column: $table.maxPositionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stopLossPercent => $composableBuilder(
    column: $table.stopLossPercent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get geminiApiKey => $composableBuilder(
    column: $table.geminiApiKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get perplexityApiKey => $composableBuilder(
    column: $table.perplexityApiKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get analysisInterval => $composableBuilder(
    column: $table.analysisInterval,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxPositionPercent => $composableBuilder(
    column: $table.maxPositionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stopLossPercent => $composableBuilder(
    column: $table.stopLossPercent,
    builder: (column) => column,
  );
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> geminiApiKey = const Value.absent(),
                Value<String?> perplexityApiKey = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> analysisInterval = const Value.absent(),
                Value<double> maxPositionPercent = const Value.absent(),
                Value<double> stopLossPercent = const Value.absent(),
              }) => UserSettingsCompanion(
                id: id,
                geminiApiKey: geminiApiKey,
                perplexityApiKey: perplexityApiKey,
                themeMode: themeMode,
                analysisInterval: analysisInterval,
                maxPositionPercent: maxPositionPercent,
                stopLossPercent: stopLossPercent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> geminiApiKey = const Value.absent(),
                Value<String?> perplexityApiKey = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> analysisInterval = const Value.absent(),
                Value<double> maxPositionPercent = const Value.absent(),
                Value<double> stopLossPercent = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                id: id,
                geminiApiKey: geminiApiKey,
                perplexityApiKey: perplexityApiKey,
                themeMode: themeMode,
                analysisInterval: analysisInterval,
                maxPositionPercent: maxPositionPercent,
                stopLossPercent: stopLossPercent,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;
typedef $$ApiKeysTableCreateCompanionBuilder =
    ApiKeysCompanion Function({
      Value<int> id,
      required String service,
      required String keyValue,
      required DateTime createdAt,
    });
typedef $$ApiKeysTableUpdateCompanionBuilder =
    ApiKeysCompanion Function({
      Value<int> id,
      Value<String> service,
      Value<String> keyValue,
      Value<DateTime> createdAt,
    });

class $$ApiKeysTableFilterComposer
    extends Composer<_$AppDatabase, $ApiKeysTable> {
  $$ApiKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyValue => $composableBuilder(
    column: $table.keyValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApiKeysTableOrderingComposer
    extends Composer<_$AppDatabase, $ApiKeysTable> {
  $$ApiKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyValue => $composableBuilder(
    column: $table.keyValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApiKeysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApiKeysTable> {
  $$ApiKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get service =>
      $composableBuilder(column: $table.service, builder: (column) => column);

  GeneratedColumn<String> get keyValue =>
      $composableBuilder(column: $table.keyValue, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ApiKeysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApiKeysTable,
          ApiKey,
          $$ApiKeysTableFilterComposer,
          $$ApiKeysTableOrderingComposer,
          $$ApiKeysTableAnnotationComposer,
          $$ApiKeysTableCreateCompanionBuilder,
          $$ApiKeysTableUpdateCompanionBuilder,
          (ApiKey, BaseReferences<_$AppDatabase, $ApiKeysTable, ApiKey>),
          ApiKey,
          PrefetchHooks Function()
        > {
  $$ApiKeysTableTableManager(_$AppDatabase db, $ApiKeysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> service = const Value.absent(),
                Value<String> keyValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ApiKeysCompanion(
                id: id,
                service: service,
                keyValue: keyValue,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String service,
                required String keyValue,
                required DateTime createdAt,
              }) => ApiKeysCompanion.insert(
                id: id,
                service: service,
                keyValue: keyValue,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ApiKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApiKeysTable,
      ApiKey,
      $$ApiKeysTableFilterComposer,
      $$ApiKeysTableOrderingComposer,
      $$ApiKeysTableAnnotationComposer,
      $$ApiKeysTableCreateCompanionBuilder,
      $$ApiKeysTableUpdateCompanionBuilder,
      (ApiKey, BaseReferences<_$AppDatabase, $ApiKeysTable, ApiKey>),
      ApiKey,
      PrefetchHooks Function()
    >;
typedef $$WatchlistItemsTableCreateCompanionBuilder =
    WatchlistItemsCompanion Function({
      Value<int> id,
      required String symbol,
      Value<DateTime> addedAt,
      Value<String> tier,
      Value<String?> note,
      Value<String?> groupName,
      Value<double?> lastPrice,
      Value<double?> lastPriceChange,
    });
typedef $$WatchlistItemsTableUpdateCompanionBuilder =
    WatchlistItemsCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<DateTime> addedAt,
      Value<String> tier,
      Value<String?> note,
      Value<String?> groupName,
      Value<double?> lastPrice,
      Value<double?> lastPriceChange,
    });

class $$WatchlistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $WatchlistItemsTable> {
  $$WatchlistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastPrice => $composableBuilder(
    column: $table.lastPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastPriceChange => $composableBuilder(
    column: $table.lastPriceChange,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WatchlistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $WatchlistItemsTable> {
  $$WatchlistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastPrice => $composableBuilder(
    column: $table.lastPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastPriceChange => $composableBuilder(
    column: $table.lastPriceChange,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WatchlistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WatchlistItemsTable> {
  $$WatchlistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<double> get lastPrice =>
      $composableBuilder(column: $table.lastPrice, builder: (column) => column);

  GeneratedColumn<double> get lastPriceChange => $composableBuilder(
    column: $table.lastPriceChange,
    builder: (column) => column,
  );
}

class $$WatchlistItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WatchlistItemsTable,
          WatchlistItemData,
          $$WatchlistItemsTableFilterComposer,
          $$WatchlistItemsTableOrderingComposer,
          $$WatchlistItemsTableAnnotationComposer,
          $$WatchlistItemsTableCreateCompanionBuilder,
          $$WatchlistItemsTableUpdateCompanionBuilder,
          (
            WatchlistItemData,
            BaseReferences<
              _$AppDatabase,
              $WatchlistItemsTable,
              WatchlistItemData
            >,
          ),
          WatchlistItemData,
          PrefetchHooks Function()
        > {
  $$WatchlistItemsTableTableManager(
    _$AppDatabase db,
    $WatchlistItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WatchlistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WatchlistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WatchlistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<double?> lastPrice = const Value.absent(),
                Value<double?> lastPriceChange = const Value.absent(),
              }) => WatchlistItemsCompanion(
                id: id,
                symbol: symbol,
                addedAt: addedAt,
                tier: tier,
                note: note,
                groupName: groupName,
                lastPrice: lastPrice,
                lastPriceChange: lastPriceChange,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                Value<DateTime> addedAt = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<double?> lastPrice = const Value.absent(),
                Value<double?> lastPriceChange = const Value.absent(),
              }) => WatchlistItemsCompanion.insert(
                id: id,
                symbol: symbol,
                addedAt: addedAt,
                tier: tier,
                note: note,
                groupName: groupName,
                lastPrice: lastPrice,
                lastPriceChange: lastPriceChange,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WatchlistItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WatchlistItemsTable,
      WatchlistItemData,
      $$WatchlistItemsTableFilterComposer,
      $$WatchlistItemsTableOrderingComposer,
      $$WatchlistItemsTableAnnotationComposer,
      $$WatchlistItemsTableCreateCompanionBuilder,
      $$WatchlistItemsTableUpdateCompanionBuilder,
      (
        WatchlistItemData,
        BaseReferences<_$AppDatabase, $WatchlistItemsTable, WatchlistItemData>,
      ),
      WatchlistItemData,
      PrefetchHooks Function()
    >;
typedef $$StockCacheTableCreateCompanionBuilder =
    StockCacheCompanion Function({
      Value<int> id,
      required String symbol,
      Value<String> companyName,
      required double currentPrice,
      required double previousClose,
      required double change,
      required double changePercent,
      required double dayHigh,
      required double dayLow,
      required int volume,
      Value<double?> marketCap,
      required DateTime timestamp,
      Value<DateTime> cachedAt,
    });
typedef $$StockCacheTableUpdateCompanionBuilder =
    StockCacheCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> companyName,
      Value<double> currentPrice,
      Value<double> previousClose,
      Value<double> change,
      Value<double> changePercent,
      Value<double> dayHigh,
      Value<double> dayLow,
      Value<int> volume,
      Value<double?> marketCap,
      Value<DateTime> timestamp,
      Value<DateTime> cachedAt,
    });

class $$StockCacheTableFilterComposer
    extends Composer<_$AppDatabase, $StockCacheTable> {
  $$StockCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousClose => $composableBuilder(
    column: $table.previousClose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get change => $composableBuilder(
    column: $table.change,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get changePercent => $composableBuilder(
    column: $table.changePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dayHigh => $composableBuilder(
    column: $table.dayHigh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dayLow => $composableBuilder(
    column: $table.dayLow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get marketCap => $composableBuilder(
    column: $table.marketCap,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $StockCacheTable> {
  $$StockCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousClose => $composableBuilder(
    column: $table.previousClose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get change => $composableBuilder(
    column: $table.change,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get changePercent => $composableBuilder(
    column: $table.changePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dayHigh => $composableBuilder(
    column: $table.dayHigh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dayLow => $composableBuilder(
    column: $table.dayLow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get marketCap => $composableBuilder(
    column: $table.marketCap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockCacheTable> {
  $$StockCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get previousClose => $composableBuilder(
    column: $table.previousClose,
    builder: (column) => column,
  );

  GeneratedColumn<double> get change =>
      $composableBuilder(column: $table.change, builder: (column) => column);

  GeneratedColumn<double> get changePercent => $composableBuilder(
    column: $table.changePercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dayHigh =>
      $composableBuilder(column: $table.dayHigh, builder: (column) => column);

  GeneratedColumn<double> get dayLow =>
      $composableBuilder(column: $table.dayLow, builder: (column) => column);

  GeneratedColumn<int> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumn<double> get marketCap =>
      $composableBuilder(column: $table.marketCap, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$StockCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockCacheTable,
          StockCacheData,
          $$StockCacheTableFilterComposer,
          $$StockCacheTableOrderingComposer,
          $$StockCacheTableAnnotationComposer,
          $$StockCacheTableCreateCompanionBuilder,
          $$StockCacheTableUpdateCompanionBuilder,
          (
            StockCacheData,
            BaseReferences<_$AppDatabase, $StockCacheTable, StockCacheData>,
          ),
          StockCacheData,
          PrefetchHooks Function()
        > {
  $$StockCacheTableTableManager(_$AppDatabase db, $StockCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<double> previousClose = const Value.absent(),
                Value<double> change = const Value.absent(),
                Value<double> changePercent = const Value.absent(),
                Value<double> dayHigh = const Value.absent(),
                Value<double> dayLow = const Value.absent(),
                Value<int> volume = const Value.absent(),
                Value<double?> marketCap = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
              }) => StockCacheCompanion(
                id: id,
                symbol: symbol,
                companyName: companyName,
                currentPrice: currentPrice,
                previousClose: previousClose,
                change: change,
                changePercent: changePercent,
                dayHigh: dayHigh,
                dayLow: dayLow,
                volume: volume,
                marketCap: marketCap,
                timestamp: timestamp,
                cachedAt: cachedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                Value<String> companyName = const Value.absent(),
                required double currentPrice,
                required double previousClose,
                required double change,
                required double changePercent,
                required double dayHigh,
                required double dayLow,
                required int volume,
                Value<double?> marketCap = const Value.absent(),
                required DateTime timestamp,
                Value<DateTime> cachedAt = const Value.absent(),
              }) => StockCacheCompanion.insert(
                id: id,
                symbol: symbol,
                companyName: companyName,
                currentPrice: currentPrice,
                previousClose: previousClose,
                change: change,
                changePercent: changePercent,
                dayHigh: dayHigh,
                dayLow: dayLow,
                volume: volume,
                marketCap: marketCap,
                timestamp: timestamp,
                cachedAt: cachedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockCacheTable,
      StockCacheData,
      $$StockCacheTableFilterComposer,
      $$StockCacheTableOrderingComposer,
      $$StockCacheTableAnnotationComposer,
      $$StockCacheTableCreateCompanionBuilder,
      $$StockCacheTableUpdateCompanionBuilder,
      (
        StockCacheData,
        BaseReferences<_$AppDatabase, $StockCacheTable, StockCacheData>,
      ),
      StockCacheData,
      PrefetchHooks Function()
    >;
typedef $$AiProvidersTableCreateCompanionBuilder =
    AiProvidersCompanion Function({
      Value<int> id,
      required String name,
      required String type,
      required String baseUrl,
      required String apiKey,
      required String model,
      Value<bool> isEnabled,
      Value<bool> isConnected,
      Value<int> totalCalls,
      Value<double> totalCost,
      Value<DateTime?> lastTestedAt,
      Value<DateTime> createdAt,
    });
typedef $$AiProvidersTableUpdateCompanionBuilder =
    AiProvidersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> type,
      Value<String> baseUrl,
      Value<String> apiKey,
      Value<String> model,
      Value<bool> isEnabled,
      Value<bool> isConnected,
      Value<int> totalCalls,
      Value<double> totalCost,
      Value<DateTime?> lastTestedAt,
      Value<DateTime> createdAt,
    });

class $$AiProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isConnected => $composableBuilder(
    column: $table.isConnected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCalls => $composableBuilder(
    column: $table.totalCalls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastTestedAt => $composableBuilder(
    column: $table.lastTestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isConnected => $composableBuilder(
    column: $table.isConnected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCalls => $composableBuilder(
    column: $table.totalCalls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastTestedAt => $composableBuilder(
    column: $table.lastTestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isConnected => $composableBuilder(
    column: $table.isConnected,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCalls => $composableBuilder(
    column: $table.totalCalls,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTestedAt => $composableBuilder(
    column: $table.lastTestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AiProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProvidersTable,
          AiProviderData,
          $$AiProvidersTableFilterComposer,
          $$AiProvidersTableOrderingComposer,
          $$AiProvidersTableAnnotationComposer,
          $$AiProvidersTableCreateCompanionBuilder,
          $$AiProvidersTableUpdateCompanionBuilder,
          (
            AiProviderData,
            BaseReferences<_$AppDatabase, $AiProvidersTable, AiProviderData>,
          ),
          AiProviderData,
          PrefetchHooks Function()
        > {
  $$AiProvidersTableTableManager(_$AppDatabase db, $AiProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> apiKey = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isConnected = const Value.absent(),
                Value<int> totalCalls = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime?> lastTestedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiProvidersCompanion(
                id: id,
                name: name,
                type: type,
                baseUrl: baseUrl,
                apiKey: apiKey,
                model: model,
                isEnabled: isEnabled,
                isConnected: isConnected,
                totalCalls: totalCalls,
                totalCost: totalCost,
                lastTestedAt: lastTestedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String type,
                required String baseUrl,
                required String apiKey,
                required String model,
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isConnected = const Value.absent(),
                Value<int> totalCalls = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime?> lastTestedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiProvidersCompanion.insert(
                id: id,
                name: name,
                type: type,
                baseUrl: baseUrl,
                apiKey: apiKey,
                model: model,
                isEnabled: isEnabled,
                isConnected: isConnected,
                totalCalls: totalCalls,
                totalCost: totalCost,
                lastTestedAt: lastTestedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProvidersTable,
      AiProviderData,
      $$AiProvidersTableFilterComposer,
      $$AiProvidersTableOrderingComposer,
      $$AiProvidersTableAnnotationComposer,
      $$AiProvidersTableCreateCompanionBuilder,
      $$AiProvidersTableUpdateCompanionBuilder,
      (
        AiProviderData,
        BaseReferences<_$AppDatabase, $AiProvidersTable, AiProviderData>,
      ),
      AiProviderData,
      PrefetchHooks Function()
    >;
typedef $$StageAssignmentsTableCreateCompanionBuilder =
    StageAssignmentsCompanion Function({
      Value<int> id,
      required String stage,
      required int providerId,
    });
typedef $$StageAssignmentsTableUpdateCompanionBuilder =
    StageAssignmentsCompanion Function({
      Value<int> id,
      Value<String> stage,
      Value<int> providerId,
    });

class $$StageAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $StageAssignmentsTable> {
  $$StageAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StageAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StageAssignmentsTable> {
  $$StageAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StageAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StageAssignmentsTable> {
  $$StageAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<int> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => column,
  );
}

class $$StageAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StageAssignmentsTable,
          StageAssignmentData,
          $$StageAssignmentsTableFilterComposer,
          $$StageAssignmentsTableOrderingComposer,
          $$StageAssignmentsTableAnnotationComposer,
          $$StageAssignmentsTableCreateCompanionBuilder,
          $$StageAssignmentsTableUpdateCompanionBuilder,
          (
            StageAssignmentData,
            BaseReferences<
              _$AppDatabase,
              $StageAssignmentsTable,
              StageAssignmentData
            >,
          ),
          StageAssignmentData,
          PrefetchHooks Function()
        > {
  $$StageAssignmentsTableTableManager(
    _$AppDatabase db,
    $StageAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StageAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StageAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StageAssignmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<int> providerId = const Value.absent(),
              }) => StageAssignmentsCompanion(
                id: id,
                stage: stage,
                providerId: providerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String stage,
                required int providerId,
              }) => StageAssignmentsCompanion.insert(
                id: id,
                stage: stage,
                providerId: providerId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StageAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StageAssignmentsTable,
      StageAssignmentData,
      $$StageAssignmentsTableFilterComposer,
      $$StageAssignmentsTableOrderingComposer,
      $$StageAssignmentsTableAnnotationComposer,
      $$StageAssignmentsTableCreateCompanionBuilder,
      $$StageAssignmentsTableUpdateCompanionBuilder,
      (
        StageAssignmentData,
        BaseReferences<
          _$AppDatabase,
          $StageAssignmentsTable,
          StageAssignmentData
        >,
      ),
      StageAssignmentData,
      PrefetchHooks Function()
    >;
typedef $$AnalysisResultsTableCreateCompanionBuilder =
    AnalysisResultsCompanion Function({
      Value<int> id,
      required String symbol,
      required double predictedPrice,
      required double confidence,
      required String recommendation,
      required String reasoning,
      Value<String> newsSummary,
      Value<String> timeframe,
      required double currentPrice,
      Value<DateTime> createdAt,
    });
typedef $$AnalysisResultsTableUpdateCompanionBuilder =
    AnalysisResultsCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<double> predictedPrice,
      Value<double> confidence,
      Value<String> recommendation,
      Value<String> reasoning,
      Value<String> newsSummary,
      Value<String> timeframe,
      Value<double> currentPrice,
      Value<DateTime> createdAt,
    });

class $$AnalysisResultsTableFilterComposer
    extends Composer<_$AppDatabase, $AnalysisResultsTable> {
  $$AnalysisResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get predictedPrice => $composableBuilder(
    column: $table.predictedPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasoning => $composableBuilder(
    column: $table.reasoning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newsSummary => $composableBuilder(
    column: $table.newsSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeframe => $composableBuilder(
    column: $table.timeframe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnalysisResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnalysisResultsTable> {
  $$AnalysisResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get predictedPrice => $composableBuilder(
    column: $table.predictedPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasoning => $composableBuilder(
    column: $table.reasoning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newsSummary => $composableBuilder(
    column: $table.newsSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeframe => $composableBuilder(
    column: $table.timeframe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnalysisResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnalysisResultsTable> {
  $$AnalysisResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<double> get predictedPrice => $composableBuilder(
    column: $table.predictedPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reasoning =>
      $composableBuilder(column: $table.reasoning, builder: (column) => column);

  GeneratedColumn<String> get newsSummary => $composableBuilder(
    column: $table.newsSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeframe =>
      $composableBuilder(column: $table.timeframe, builder: (column) => column);

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AnalysisResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnalysisResultsTable,
          AnalysisResultData,
          $$AnalysisResultsTableFilterComposer,
          $$AnalysisResultsTableOrderingComposer,
          $$AnalysisResultsTableAnnotationComposer,
          $$AnalysisResultsTableCreateCompanionBuilder,
          $$AnalysisResultsTableUpdateCompanionBuilder,
          (
            AnalysisResultData,
            BaseReferences<
              _$AppDatabase,
              $AnalysisResultsTable,
              AnalysisResultData
            >,
          ),
          AnalysisResultData,
          PrefetchHooks Function()
        > {
  $$AnalysisResultsTableTableManager(
    _$AppDatabase db,
    $AnalysisResultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnalysisResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnalysisResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnalysisResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<double> predictedPrice = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> recommendation = const Value.absent(),
                Value<String> reasoning = const Value.absent(),
                Value<String> newsSummary = const Value.absent(),
                Value<String> timeframe = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AnalysisResultsCompanion(
                id: id,
                symbol: symbol,
                predictedPrice: predictedPrice,
                confidence: confidence,
                recommendation: recommendation,
                reasoning: reasoning,
                newsSummary: newsSummary,
                timeframe: timeframe,
                currentPrice: currentPrice,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                required double predictedPrice,
                required double confidence,
                required String recommendation,
                required String reasoning,
                Value<String> newsSummary = const Value.absent(),
                Value<String> timeframe = const Value.absent(),
                required double currentPrice,
                Value<DateTime> createdAt = const Value.absent(),
              }) => AnalysisResultsCompanion.insert(
                id: id,
                symbol: symbol,
                predictedPrice: predictedPrice,
                confidence: confidence,
                recommendation: recommendation,
                reasoning: reasoning,
                newsSummary: newsSummary,
                timeframe: timeframe,
                currentPrice: currentPrice,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnalysisResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnalysisResultsTable,
      AnalysisResultData,
      $$AnalysisResultsTableFilterComposer,
      $$AnalysisResultsTableOrderingComposer,
      $$AnalysisResultsTableAnnotationComposer,
      $$AnalysisResultsTableCreateCompanionBuilder,
      $$AnalysisResultsTableUpdateCompanionBuilder,
      (
        AnalysisResultData,
        BaseReferences<
          _$AppDatabase,
          $AnalysisResultsTable,
          AnalysisResultData
        >,
      ),
      AnalysisResultData,
      PrefetchHooks Function()
    >;
typedef $$PortfolioPositionsTableCreateCompanionBuilder =
    PortfolioPositionsCompanion Function({
      Value<int> id,
      required String symbol,
      Value<String> companyName,
      required double shares,
      required double avgCostBasis,
      Value<double> currentPrice,
      Value<DateTime> acquiredAt,
      Value<String> currency,
      Value<String?> note,
    });
typedef $$PortfolioPositionsTableUpdateCompanionBuilder =
    PortfolioPositionsCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> companyName,
      Value<double> shares,
      Value<double> avgCostBasis,
      Value<double> currentPrice,
      Value<DateTime> acquiredAt,
      Value<String> currency,
      Value<String?> note,
    });

class $$PortfolioPositionsTableFilterComposer
    extends Composer<_$AppDatabase, $PortfolioPositionsTable> {
  $$PortfolioPositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgCostBasis => $composableBuilder(
    column: $table.avgCostBasis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PortfolioPositionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PortfolioPositionsTable> {
  $$PortfolioPositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgCostBasis => $composableBuilder(
    column: $table.avgCostBasis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PortfolioPositionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortfolioPositionsTable> {
  $$PortfolioPositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<double> get avgCostBasis => $composableBuilder(
    column: $table.avgCostBasis,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$PortfolioPositionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PortfolioPositionsTable,
          PositionData,
          $$PortfolioPositionsTableFilterComposer,
          $$PortfolioPositionsTableOrderingComposer,
          $$PortfolioPositionsTableAnnotationComposer,
          $$PortfolioPositionsTableCreateCompanionBuilder,
          $$PortfolioPositionsTableUpdateCompanionBuilder,
          (
            PositionData,
            BaseReferences<
              _$AppDatabase,
              $PortfolioPositionsTable,
              PositionData
            >,
          ),
          PositionData,
          PrefetchHooks Function()
        > {
  $$PortfolioPositionsTableTableManager(
    _$AppDatabase db,
    $PortfolioPositionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PortfolioPositionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PortfolioPositionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PortfolioPositionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<double> shares = const Value.absent(),
                Value<double> avgCostBasis = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PortfolioPositionsCompanion(
                id: id,
                symbol: symbol,
                companyName: companyName,
                shares: shares,
                avgCostBasis: avgCostBasis,
                currentPrice: currentPrice,
                acquiredAt: acquiredAt,
                currency: currency,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                Value<String> companyName = const Value.absent(),
                required double shares,
                required double avgCostBasis,
                Value<double> currentPrice = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PortfolioPositionsCompanion.insert(
                id: id,
                symbol: symbol,
                companyName: companyName,
                shares: shares,
                avgCostBasis: avgCostBasis,
                currentPrice: currentPrice,
                acquiredAt: acquiredAt,
                currency: currency,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PortfolioPositionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PortfolioPositionsTable,
      PositionData,
      $$PortfolioPositionsTableFilterComposer,
      $$PortfolioPositionsTableOrderingComposer,
      $$PortfolioPositionsTableAnnotationComposer,
      $$PortfolioPositionsTableCreateCompanionBuilder,
      $$PortfolioPositionsTableUpdateCompanionBuilder,
      (
        PositionData,
        BaseReferences<_$AppDatabase, $PortfolioPositionsTable, PositionData>,
      ),
      PositionData,
      PrefetchHooks Function()
    >;
typedef $$PaperTradesTableCreateCompanionBuilder =
    PaperTradesCompanion Function({
      Value<int> id,
      required String symbol,
      required String type,
      required double shares,
      required double price,
      Value<DateTime> executedAt,
      Value<String> status,
      Value<String?> exitReason,
      Value<double?> exitPrice,
      Value<DateTime?> closedAt,
      Value<double?> realizedPnl,
    });
typedef $$PaperTradesTableUpdateCompanionBuilder =
    PaperTradesCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> type,
      Value<double> shares,
      Value<double> price,
      Value<DateTime> executedAt,
      Value<String> status,
      Value<String?> exitReason,
      Value<double?> exitPrice,
      Value<DateTime?> closedAt,
      Value<double?> realizedPnl,
    });

class $$PaperTradesTableFilterComposer
    extends Composer<_$AppDatabase, $PaperTradesTable> {
  $$PaperTradesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exitReason => $composableBuilder(
    column: $table.exitReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exitPrice => $composableBuilder(
    column: $table.exitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get realizedPnl => $composableBuilder(
    column: $table.realizedPnl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaperTradesTableOrderingComposer
    extends Composer<_$AppDatabase, $PaperTradesTable> {
  $$PaperTradesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exitReason => $composableBuilder(
    column: $table.exitReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exitPrice => $composableBuilder(
    column: $table.exitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get realizedPnl => $composableBuilder(
    column: $table.realizedPnl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaperTradesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaperTradesTable> {
  $$PaperTradesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get exitReason => $composableBuilder(
    column: $table.exitReason,
    builder: (column) => column,
  );

  GeneratedColumn<double> get exitPrice =>
      $composableBuilder(column: $table.exitPrice, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<double> get realizedPnl => $composableBuilder(
    column: $table.realizedPnl,
    builder: (column) => column,
  );
}

class $$PaperTradesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaperTradesTable,
          PaperTradeData,
          $$PaperTradesTableFilterComposer,
          $$PaperTradesTableOrderingComposer,
          $$PaperTradesTableAnnotationComposer,
          $$PaperTradesTableCreateCompanionBuilder,
          $$PaperTradesTableUpdateCompanionBuilder,
          (
            PaperTradeData,
            BaseReferences<_$AppDatabase, $PaperTradesTable, PaperTradeData>,
          ),
          PaperTradeData,
          PrefetchHooks Function()
        > {
  $$PaperTradesTableTableManager(_$AppDatabase db, $PaperTradesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaperTradesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaperTradesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaperTradesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> shares = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> executedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> exitReason = const Value.absent(),
                Value<double?> exitPrice = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<double?> realizedPnl = const Value.absent(),
              }) => PaperTradesCompanion(
                id: id,
                symbol: symbol,
                type: type,
                shares: shares,
                price: price,
                executedAt: executedAt,
                status: status,
                exitReason: exitReason,
                exitPrice: exitPrice,
                closedAt: closedAt,
                realizedPnl: realizedPnl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                required String type,
                required double shares,
                required double price,
                Value<DateTime> executedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> exitReason = const Value.absent(),
                Value<double?> exitPrice = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<double?> realizedPnl = const Value.absent(),
              }) => PaperTradesCompanion.insert(
                id: id,
                symbol: symbol,
                type: type,
                shares: shares,
                price: price,
                executedAt: executedAt,
                status: status,
                exitReason: exitReason,
                exitPrice: exitPrice,
                closedAt: closedAt,
                realizedPnl: realizedPnl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaperTradesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaperTradesTable,
      PaperTradeData,
      $$PaperTradesTableFilterComposer,
      $$PaperTradesTableOrderingComposer,
      $$PaperTradesTableAnnotationComposer,
      $$PaperTradesTableCreateCompanionBuilder,
      $$PaperTradesTableUpdateCompanionBuilder,
      (
        PaperTradeData,
        BaseReferences<_$AppDatabase, $PaperTradesTable, PaperTradeData>,
      ),
      PaperTradeData,
      PrefetchHooks Function()
    >;
typedef $$PaperSettingsTableCreateCompanionBuilder =
    PaperSettingsCompanion Function({
      Value<int> id,
      Value<double> startingCapital,
      Value<double> takeProfitPercent,
      Value<double> stopLossPercent,
      Value<int> maxOpenTrades,
      Value<double> positionSizePercent,
    });
typedef $$PaperSettingsTableUpdateCompanionBuilder =
    PaperSettingsCompanion Function({
      Value<int> id,
      Value<double> startingCapital,
      Value<double> takeProfitPercent,
      Value<double> stopLossPercent,
      Value<int> maxOpenTrades,
      Value<double> positionSizePercent,
    });

class $$PaperSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $PaperSettingsTable> {
  $$PaperSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startingCapital => $composableBuilder(
    column: $table.startingCapital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get takeProfitPercent => $composableBuilder(
    column: $table.takeProfitPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stopLossPercent => $composableBuilder(
    column: $table.stopLossPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxOpenTrades => $composableBuilder(
    column: $table.maxOpenTrades,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get positionSizePercent => $composableBuilder(
    column: $table.positionSizePercent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaperSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaperSettingsTable> {
  $$PaperSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startingCapital => $composableBuilder(
    column: $table.startingCapital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get takeProfitPercent => $composableBuilder(
    column: $table.takeProfitPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stopLossPercent => $composableBuilder(
    column: $table.stopLossPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxOpenTrades => $composableBuilder(
    column: $table.maxOpenTrades,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get positionSizePercent => $composableBuilder(
    column: $table.positionSizePercent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaperSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaperSettingsTable> {
  $$PaperSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get startingCapital => $composableBuilder(
    column: $table.startingCapital,
    builder: (column) => column,
  );

  GeneratedColumn<double> get takeProfitPercent => $composableBuilder(
    column: $table.takeProfitPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stopLossPercent => $composableBuilder(
    column: $table.stopLossPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxOpenTrades => $composableBuilder(
    column: $table.maxOpenTrades,
    builder: (column) => column,
  );

  GeneratedColumn<double> get positionSizePercent => $composableBuilder(
    column: $table.positionSizePercent,
    builder: (column) => column,
  );
}

class $$PaperSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaperSettingsTable,
          PaperSettingsData,
          $$PaperSettingsTableFilterComposer,
          $$PaperSettingsTableOrderingComposer,
          $$PaperSettingsTableAnnotationComposer,
          $$PaperSettingsTableCreateCompanionBuilder,
          $$PaperSettingsTableUpdateCompanionBuilder,
          (
            PaperSettingsData,
            BaseReferences<
              _$AppDatabase,
              $PaperSettingsTable,
              PaperSettingsData
            >,
          ),
          PaperSettingsData,
          PrefetchHooks Function()
        > {
  $$PaperSettingsTableTableManager(_$AppDatabase db, $PaperSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaperSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaperSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaperSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> startingCapital = const Value.absent(),
                Value<double> takeProfitPercent = const Value.absent(),
                Value<double> stopLossPercent = const Value.absent(),
                Value<int> maxOpenTrades = const Value.absent(),
                Value<double> positionSizePercent = const Value.absent(),
              }) => PaperSettingsCompanion(
                id: id,
                startingCapital: startingCapital,
                takeProfitPercent: takeProfitPercent,
                stopLossPercent: stopLossPercent,
                maxOpenTrades: maxOpenTrades,
                positionSizePercent: positionSizePercent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> startingCapital = const Value.absent(),
                Value<double> takeProfitPercent = const Value.absent(),
                Value<double> stopLossPercent = const Value.absent(),
                Value<int> maxOpenTrades = const Value.absent(),
                Value<double> positionSizePercent = const Value.absent(),
              }) => PaperSettingsCompanion.insert(
                id: id,
                startingCapital: startingCapital,
                takeProfitPercent: takeProfitPercent,
                stopLossPercent: stopLossPercent,
                maxOpenTrades: maxOpenTrades,
                positionSizePercent: positionSizePercent,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaperSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaperSettingsTable,
      PaperSettingsData,
      $$PaperSettingsTableFilterComposer,
      $$PaperSettingsTableOrderingComposer,
      $$PaperSettingsTableAnnotationComposer,
      $$PaperSettingsTableCreateCompanionBuilder,
      $$PaperSettingsTableUpdateCompanionBuilder,
      (
        PaperSettingsData,
        BaseReferences<_$AppDatabase, $PaperSettingsTable, PaperSettingsData>,
      ),
      PaperSettingsData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$ApiKeysTableTableManager get apiKeys =>
      $$ApiKeysTableTableManager(_db, _db.apiKeys);
  $$WatchlistItemsTableTableManager get watchlistItems =>
      $$WatchlistItemsTableTableManager(_db, _db.watchlistItems);
  $$StockCacheTableTableManager get stockCache =>
      $$StockCacheTableTableManager(_db, _db.stockCache);
  $$AiProvidersTableTableManager get aiProviders =>
      $$AiProvidersTableTableManager(_db, _db.aiProviders);
  $$StageAssignmentsTableTableManager get stageAssignments =>
      $$StageAssignmentsTableTableManager(_db, _db.stageAssignments);
  $$AnalysisResultsTableTableManager get analysisResults =>
      $$AnalysisResultsTableTableManager(_db, _db.analysisResults);
  $$PortfolioPositionsTableTableManager get portfolioPositions =>
      $$PortfolioPositionsTableTableManager(_db, _db.portfolioPositions);
  $$PaperTradesTableTableManager get paperTrades =>
      $$PaperTradesTableTableManager(_db, _db.paperTrades);
  $$PaperSettingsTableTableManager get paperSettings =>
      $$PaperSettingsTableTableManager(_db, _db.paperSettings);
}
