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

class $FinancialRatiosTable extends FinancialRatios
    with TableInfo<$FinancialRatiosTable, FinancialRatioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialRatiosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _peRatioMeta = const VerificationMeta(
    'peRatio',
  );
  @override
  late final GeneratedColumn<double> peRatio = GeneratedColumn<double>(
    'pe_ratio',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pbRatioMeta = const VerificationMeta(
    'pbRatio',
  );
  @override
  late final GeneratedColumn<double> pbRatio = GeneratedColumn<double>(
    'pb_ratio',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _epsMeta = const VerificationMeta('eps');
  @override
  late final GeneratedColumn<double> eps = GeneratedColumn<double>(
    'eps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dividendYieldMeta = const VerificationMeta(
    'dividendYield',
  );
  @override
  late final GeneratedColumn<double> dividendYield = GeneratedColumn<double>(
    'dividend_yield',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _betaMeta = const VerificationMeta('beta');
  @override
  late final GeneratedColumn<double> beta = GeneratedColumn<double>(
    'beta',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _week52HighMeta = const VerificationMeta(
    'week52High',
  );
  @override
  late final GeneratedColumn<String> week52High = GeneratedColumn<String>(
    'week52_high',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _week52LowMeta = const VerificationMeta(
    'week52Low',
  );
  @override
  late final GeneratedColumn<String> week52Low = GeneratedColumn<String>(
    'week52_low',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _revenueGrowthMeta = const VerificationMeta(
    'revenueGrowth',
  );
  @override
  late final GeneratedColumn<double> revenueGrowth = GeneratedColumn<double>(
    'revenue_growth',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profitMarginMeta = const VerificationMeta(
    'profitMargin',
  );
  @override
  late final GeneratedColumn<double> profitMargin = GeneratedColumn<double>(
    'profit_margin',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debtToEquityMeta = const VerificationMeta(
    'debtToEquity',
  );
  @override
  late final GeneratedColumn<double> debtToEquity = GeneratedColumn<double>(
    'debt_to_equity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roeMeta = const VerificationMeta('roe');
  @override
  late final GeneratedColumn<double> roe = GeneratedColumn<double>(
    'roe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    peRatio,
    pbRatio,
    eps,
    dividendYield,
    beta,
    week52High,
    week52Low,
    marketCap,
    revenueGrowth,
    profitMargin,
    debtToEquity,
    roe,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_ratios';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialRatioData> instance, {
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
    if (data.containsKey('pe_ratio')) {
      context.handle(
        _peRatioMeta,
        peRatio.isAcceptableOrUnknown(data['pe_ratio']!, _peRatioMeta),
      );
    }
    if (data.containsKey('pb_ratio')) {
      context.handle(
        _pbRatioMeta,
        pbRatio.isAcceptableOrUnknown(data['pb_ratio']!, _pbRatioMeta),
      );
    }
    if (data.containsKey('eps')) {
      context.handle(
        _epsMeta,
        eps.isAcceptableOrUnknown(data['eps']!, _epsMeta),
      );
    }
    if (data.containsKey('dividend_yield')) {
      context.handle(
        _dividendYieldMeta,
        dividendYield.isAcceptableOrUnknown(
          data['dividend_yield']!,
          _dividendYieldMeta,
        ),
      );
    }
    if (data.containsKey('beta')) {
      context.handle(
        _betaMeta,
        beta.isAcceptableOrUnknown(data['beta']!, _betaMeta),
      );
    }
    if (data.containsKey('week52_high')) {
      context.handle(
        _week52HighMeta,
        week52High.isAcceptableOrUnknown(data['week52_high']!, _week52HighMeta),
      );
    }
    if (data.containsKey('week52_low')) {
      context.handle(
        _week52LowMeta,
        week52Low.isAcceptableOrUnknown(data['week52_low']!, _week52LowMeta),
      );
    }
    if (data.containsKey('market_cap')) {
      context.handle(
        _marketCapMeta,
        marketCap.isAcceptableOrUnknown(data['market_cap']!, _marketCapMeta),
      );
    }
    if (data.containsKey('revenue_growth')) {
      context.handle(
        _revenueGrowthMeta,
        revenueGrowth.isAcceptableOrUnknown(
          data['revenue_growth']!,
          _revenueGrowthMeta,
        ),
      );
    }
    if (data.containsKey('profit_margin')) {
      context.handle(
        _profitMarginMeta,
        profitMargin.isAcceptableOrUnknown(
          data['profit_margin']!,
          _profitMarginMeta,
        ),
      );
    }
    if (data.containsKey('debt_to_equity')) {
      context.handle(
        _debtToEquityMeta,
        debtToEquity.isAcceptableOrUnknown(
          data['debt_to_equity']!,
          _debtToEquityMeta,
        ),
      );
    }
    if (data.containsKey('roe')) {
      context.handle(
        _roeMeta,
        roe.isAcceptableOrUnknown(data['roe']!, _roeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialRatioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialRatioData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      peRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pe_ratio'],
      ),
      pbRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pb_ratio'],
      ),
      eps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}eps'],
      ),
      dividendYield: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dividend_yield'],
      ),
      beta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beta'],
      ),
      week52High: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}week52_high'],
      )!,
      week52Low: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}week52_low'],
      )!,
      marketCap: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}market_cap'],
      ),
      revenueGrowth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}revenue_growth'],
      ),
      profitMargin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}profit_margin'],
      ),
      debtToEquity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}debt_to_equity'],
      ),
      roe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}roe'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $FinancialRatiosTable createAlias(String alias) {
    return $FinancialRatiosTable(attachedDatabase, alias);
  }
}

class FinancialRatioData extends DataClass
    implements Insertable<FinancialRatioData> {
  final int id;
  final String symbol;
  final double? peRatio;
  final double? pbRatio;
  final double? eps;
  final double? dividendYield;
  final double? beta;
  final String week52High;
  final String week52Low;
  final double? marketCap;
  final double? revenueGrowth;
  final double? profitMargin;
  final double? debtToEquity;
  final double? roe;
  final DateTime? updatedAt;
  const FinancialRatioData({
    required this.id,
    required this.symbol,
    this.peRatio,
    this.pbRatio,
    this.eps,
    this.dividendYield,
    this.beta,
    required this.week52High,
    required this.week52Low,
    this.marketCap,
    this.revenueGrowth,
    this.profitMargin,
    this.debtToEquity,
    this.roe,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    if (!nullToAbsent || peRatio != null) {
      map['pe_ratio'] = Variable<double>(peRatio);
    }
    if (!nullToAbsent || pbRatio != null) {
      map['pb_ratio'] = Variable<double>(pbRatio);
    }
    if (!nullToAbsent || eps != null) {
      map['eps'] = Variable<double>(eps);
    }
    if (!nullToAbsent || dividendYield != null) {
      map['dividend_yield'] = Variable<double>(dividendYield);
    }
    if (!nullToAbsent || beta != null) {
      map['beta'] = Variable<double>(beta);
    }
    map['week52_high'] = Variable<String>(week52High);
    map['week52_low'] = Variable<String>(week52Low);
    if (!nullToAbsent || marketCap != null) {
      map['market_cap'] = Variable<double>(marketCap);
    }
    if (!nullToAbsent || revenueGrowth != null) {
      map['revenue_growth'] = Variable<double>(revenueGrowth);
    }
    if (!nullToAbsent || profitMargin != null) {
      map['profit_margin'] = Variable<double>(profitMargin);
    }
    if (!nullToAbsent || debtToEquity != null) {
      map['debt_to_equity'] = Variable<double>(debtToEquity);
    }
    if (!nullToAbsent || roe != null) {
      map['roe'] = Variable<double>(roe);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  FinancialRatiosCompanion toCompanion(bool nullToAbsent) {
    return FinancialRatiosCompanion(
      id: Value(id),
      symbol: Value(symbol),
      peRatio: peRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(peRatio),
      pbRatio: pbRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(pbRatio),
      eps: eps == null && nullToAbsent ? const Value.absent() : Value(eps),
      dividendYield: dividendYield == null && nullToAbsent
          ? const Value.absent()
          : Value(dividendYield),
      beta: beta == null && nullToAbsent ? const Value.absent() : Value(beta),
      week52High: Value(week52High),
      week52Low: Value(week52Low),
      marketCap: marketCap == null && nullToAbsent
          ? const Value.absent()
          : Value(marketCap),
      revenueGrowth: revenueGrowth == null && nullToAbsent
          ? const Value.absent()
          : Value(revenueGrowth),
      profitMargin: profitMargin == null && nullToAbsent
          ? const Value.absent()
          : Value(profitMargin),
      debtToEquity: debtToEquity == null && nullToAbsent
          ? const Value.absent()
          : Value(debtToEquity),
      roe: roe == null && nullToAbsent ? const Value.absent() : Value(roe),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory FinancialRatioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialRatioData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      peRatio: serializer.fromJson<double?>(json['peRatio']),
      pbRatio: serializer.fromJson<double?>(json['pbRatio']),
      eps: serializer.fromJson<double?>(json['eps']),
      dividendYield: serializer.fromJson<double?>(json['dividendYield']),
      beta: serializer.fromJson<double?>(json['beta']),
      week52High: serializer.fromJson<String>(json['week52High']),
      week52Low: serializer.fromJson<String>(json['week52Low']),
      marketCap: serializer.fromJson<double?>(json['marketCap']),
      revenueGrowth: serializer.fromJson<double?>(json['revenueGrowth']),
      profitMargin: serializer.fromJson<double?>(json['profitMargin']),
      debtToEquity: serializer.fromJson<double?>(json['debtToEquity']),
      roe: serializer.fromJson<double?>(json['roe']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'peRatio': serializer.toJson<double?>(peRatio),
      'pbRatio': serializer.toJson<double?>(pbRatio),
      'eps': serializer.toJson<double?>(eps),
      'dividendYield': serializer.toJson<double?>(dividendYield),
      'beta': serializer.toJson<double?>(beta),
      'week52High': serializer.toJson<String>(week52High),
      'week52Low': serializer.toJson<String>(week52Low),
      'marketCap': serializer.toJson<double?>(marketCap),
      'revenueGrowth': serializer.toJson<double?>(revenueGrowth),
      'profitMargin': serializer.toJson<double?>(profitMargin),
      'debtToEquity': serializer.toJson<double?>(debtToEquity),
      'roe': serializer.toJson<double?>(roe),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  FinancialRatioData copyWith({
    int? id,
    String? symbol,
    Value<double?> peRatio = const Value.absent(),
    Value<double?> pbRatio = const Value.absent(),
    Value<double?> eps = const Value.absent(),
    Value<double?> dividendYield = const Value.absent(),
    Value<double?> beta = const Value.absent(),
    String? week52High,
    String? week52Low,
    Value<double?> marketCap = const Value.absent(),
    Value<double?> revenueGrowth = const Value.absent(),
    Value<double?> profitMargin = const Value.absent(),
    Value<double?> debtToEquity = const Value.absent(),
    Value<double?> roe = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => FinancialRatioData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    peRatio: peRatio.present ? peRatio.value : this.peRatio,
    pbRatio: pbRatio.present ? pbRatio.value : this.pbRatio,
    eps: eps.present ? eps.value : this.eps,
    dividendYield: dividendYield.present
        ? dividendYield.value
        : this.dividendYield,
    beta: beta.present ? beta.value : this.beta,
    week52High: week52High ?? this.week52High,
    week52Low: week52Low ?? this.week52Low,
    marketCap: marketCap.present ? marketCap.value : this.marketCap,
    revenueGrowth: revenueGrowth.present
        ? revenueGrowth.value
        : this.revenueGrowth,
    profitMargin: profitMargin.present ? profitMargin.value : this.profitMargin,
    debtToEquity: debtToEquity.present ? debtToEquity.value : this.debtToEquity,
    roe: roe.present ? roe.value : this.roe,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  FinancialRatioData copyWithCompanion(FinancialRatiosCompanion data) {
    return FinancialRatioData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      peRatio: data.peRatio.present ? data.peRatio.value : this.peRatio,
      pbRatio: data.pbRatio.present ? data.pbRatio.value : this.pbRatio,
      eps: data.eps.present ? data.eps.value : this.eps,
      dividendYield: data.dividendYield.present
          ? data.dividendYield.value
          : this.dividendYield,
      beta: data.beta.present ? data.beta.value : this.beta,
      week52High: data.week52High.present
          ? data.week52High.value
          : this.week52High,
      week52Low: data.week52Low.present ? data.week52Low.value : this.week52Low,
      marketCap: data.marketCap.present ? data.marketCap.value : this.marketCap,
      revenueGrowth: data.revenueGrowth.present
          ? data.revenueGrowth.value
          : this.revenueGrowth,
      profitMargin: data.profitMargin.present
          ? data.profitMargin.value
          : this.profitMargin,
      debtToEquity: data.debtToEquity.present
          ? data.debtToEquity.value
          : this.debtToEquity,
      roe: data.roe.present ? data.roe.value : this.roe,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialRatioData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('peRatio: $peRatio, ')
          ..write('pbRatio: $pbRatio, ')
          ..write('eps: $eps, ')
          ..write('dividendYield: $dividendYield, ')
          ..write('beta: $beta, ')
          ..write('week52High: $week52High, ')
          ..write('week52Low: $week52Low, ')
          ..write('marketCap: $marketCap, ')
          ..write('revenueGrowth: $revenueGrowth, ')
          ..write('profitMargin: $profitMargin, ')
          ..write('debtToEquity: $debtToEquity, ')
          ..write('roe: $roe, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    peRatio,
    pbRatio,
    eps,
    dividendYield,
    beta,
    week52High,
    week52Low,
    marketCap,
    revenueGrowth,
    profitMargin,
    debtToEquity,
    roe,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialRatioData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.peRatio == this.peRatio &&
          other.pbRatio == this.pbRatio &&
          other.eps == this.eps &&
          other.dividendYield == this.dividendYield &&
          other.beta == this.beta &&
          other.week52High == this.week52High &&
          other.week52Low == this.week52Low &&
          other.marketCap == this.marketCap &&
          other.revenueGrowth == this.revenueGrowth &&
          other.profitMargin == this.profitMargin &&
          other.debtToEquity == this.debtToEquity &&
          other.roe == this.roe &&
          other.updatedAt == this.updatedAt);
}

class FinancialRatiosCompanion extends UpdateCompanion<FinancialRatioData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<double?> peRatio;
  final Value<double?> pbRatio;
  final Value<double?> eps;
  final Value<double?> dividendYield;
  final Value<double?> beta;
  final Value<String> week52High;
  final Value<String> week52Low;
  final Value<double?> marketCap;
  final Value<double?> revenueGrowth;
  final Value<double?> profitMargin;
  final Value<double?> debtToEquity;
  final Value<double?> roe;
  final Value<DateTime?> updatedAt;
  const FinancialRatiosCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.peRatio = const Value.absent(),
    this.pbRatio = const Value.absent(),
    this.eps = const Value.absent(),
    this.dividendYield = const Value.absent(),
    this.beta = const Value.absent(),
    this.week52High = const Value.absent(),
    this.week52Low = const Value.absent(),
    this.marketCap = const Value.absent(),
    this.revenueGrowth = const Value.absent(),
    this.profitMargin = const Value.absent(),
    this.debtToEquity = const Value.absent(),
    this.roe = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FinancialRatiosCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    this.peRatio = const Value.absent(),
    this.pbRatio = const Value.absent(),
    this.eps = const Value.absent(),
    this.dividendYield = const Value.absent(),
    this.beta = const Value.absent(),
    this.week52High = const Value.absent(),
    this.week52Low = const Value.absent(),
    this.marketCap = const Value.absent(),
    this.revenueGrowth = const Value.absent(),
    this.profitMargin = const Value.absent(),
    this.debtToEquity = const Value.absent(),
    this.roe = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : symbol = Value(symbol);
  static Insertable<FinancialRatioData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<double>? peRatio,
    Expression<double>? pbRatio,
    Expression<double>? eps,
    Expression<double>? dividendYield,
    Expression<double>? beta,
    Expression<String>? week52High,
    Expression<String>? week52Low,
    Expression<double>? marketCap,
    Expression<double>? revenueGrowth,
    Expression<double>? profitMargin,
    Expression<double>? debtToEquity,
    Expression<double>? roe,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (peRatio != null) 'pe_ratio': peRatio,
      if (pbRatio != null) 'pb_ratio': pbRatio,
      if (eps != null) 'eps': eps,
      if (dividendYield != null) 'dividend_yield': dividendYield,
      if (beta != null) 'beta': beta,
      if (week52High != null) 'week52_high': week52High,
      if (week52Low != null) 'week52_low': week52Low,
      if (marketCap != null) 'market_cap': marketCap,
      if (revenueGrowth != null) 'revenue_growth': revenueGrowth,
      if (profitMargin != null) 'profit_margin': profitMargin,
      if (debtToEquity != null) 'debt_to_equity': debtToEquity,
      if (roe != null) 'roe': roe,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FinancialRatiosCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<double?>? peRatio,
    Value<double?>? pbRatio,
    Value<double?>? eps,
    Value<double?>? dividendYield,
    Value<double?>? beta,
    Value<String>? week52High,
    Value<String>? week52Low,
    Value<double?>? marketCap,
    Value<double?>? revenueGrowth,
    Value<double?>? profitMargin,
    Value<double?>? debtToEquity,
    Value<double?>? roe,
    Value<DateTime?>? updatedAt,
  }) {
    return FinancialRatiosCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      peRatio: peRatio ?? this.peRatio,
      pbRatio: pbRatio ?? this.pbRatio,
      eps: eps ?? this.eps,
      dividendYield: dividendYield ?? this.dividendYield,
      beta: beta ?? this.beta,
      week52High: week52High ?? this.week52High,
      week52Low: week52Low ?? this.week52Low,
      marketCap: marketCap ?? this.marketCap,
      revenueGrowth: revenueGrowth ?? this.revenueGrowth,
      profitMargin: profitMargin ?? this.profitMargin,
      debtToEquity: debtToEquity ?? this.debtToEquity,
      roe: roe ?? this.roe,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (peRatio.present) {
      map['pe_ratio'] = Variable<double>(peRatio.value);
    }
    if (pbRatio.present) {
      map['pb_ratio'] = Variable<double>(pbRatio.value);
    }
    if (eps.present) {
      map['eps'] = Variable<double>(eps.value);
    }
    if (dividendYield.present) {
      map['dividend_yield'] = Variable<double>(dividendYield.value);
    }
    if (beta.present) {
      map['beta'] = Variable<double>(beta.value);
    }
    if (week52High.present) {
      map['week52_high'] = Variable<String>(week52High.value);
    }
    if (week52Low.present) {
      map['week52_low'] = Variable<String>(week52Low.value);
    }
    if (marketCap.present) {
      map['market_cap'] = Variable<double>(marketCap.value);
    }
    if (revenueGrowth.present) {
      map['revenue_growth'] = Variable<double>(revenueGrowth.value);
    }
    if (profitMargin.present) {
      map['profit_margin'] = Variable<double>(profitMargin.value);
    }
    if (debtToEquity.present) {
      map['debt_to_equity'] = Variable<double>(debtToEquity.value);
    }
    if (roe.present) {
      map['roe'] = Variable<double>(roe.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialRatiosCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('peRatio: $peRatio, ')
          ..write('pbRatio: $pbRatio, ')
          ..write('eps: $eps, ')
          ..write('dividendYield: $dividendYield, ')
          ..write('beta: $beta, ')
          ..write('week52High: $week52High, ')
          ..write('week52Low: $week52Low, ')
          ..write('marketCap: $marketCap, ')
          ..write('revenueGrowth: $revenueGrowth, ')
          ..write('profitMargin: $profitMargin, ')
          ..write('debtToEquity: $debtToEquity, ')
          ..write('roe: $roe, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CorporateActionsTable extends CorporateActions
    with TableInfo<$CorporateActionsTable, CorporateActionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CorporateActionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    type,
    date,
    description,
    amount,
    currency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'corporate_actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CorporateActionData> instance, {
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CorporateActionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CorporateActionData(
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
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
    );
  }

  @override
  $CorporateActionsTable createAlias(String alias) {
    return $CorporateActionsTable(attachedDatabase, alias);
  }
}

class CorporateActionData extends DataClass
    implements Insertable<CorporateActionData> {
  final int id;
  final String symbol;
  final String type;
  final DateTime date;
  final String? description;
  final double? amount;
  final String currency;
  const CorporateActionData({
    required this.id,
    required this.symbol,
    required this.type,
    required this.date,
    this.description,
    this.amount,
    required this.currency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    map['currency'] = Variable<String>(currency);
    return map;
  }

  CorporateActionsCompanion toCompanion(bool nullToAbsent) {
    return CorporateActionsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      type: Value(type),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      currency: Value(currency),
    );
  }

  factory CorporateActionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CorporateActionData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<double?>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<double?>(amount),
      'currency': serializer.toJson<String>(currency),
    };
  }

  CorporateActionData copyWith({
    int? id,
    String? symbol,
    String? type,
    DateTime? date,
    Value<String?> description = const Value.absent(),
    Value<double?> amount = const Value.absent(),
    String? currency,
  }) => CorporateActionData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    type: type ?? this.type,
    date: date ?? this.date,
    description: description.present ? description.value : this.description,
    amount: amount.present ? amount.value : this.amount,
    currency: currency ?? this.currency,
  );
  CorporateActionData copyWithCompanion(CorporateActionsCompanion data) {
    return CorporateActionData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CorporateActionData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, symbol, type, date, description, amount, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CorporateActionData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.type == this.type &&
          other.date == this.date &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.currency == this.currency);
}

class CorporateActionsCompanion extends UpdateCompanion<CorporateActionData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<double?> amount;
  final Value<String> currency;
  const CorporateActionsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
  });
  CorporateActionsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required String type,
    required DateTime date,
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
  }) : symbol = Value(symbol),
       type = Value(type),
       date = Value(date);
  static Insertable<CorporateActionData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? currency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
    });
  }

  CorporateActionsCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? type,
    Value<DateTime>? date,
    Value<String?>? description,
    Value<double?>? amount,
    Value<String>? currency,
  }) {
    return CorporateActionsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CorporateActionsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }
}

class $EarningsEventsTable extends EarningsEvents
    with TableInfo<$EarningsEventsTable, EarningsEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EarningsEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _reportDateMeta = const VerificationMeta(
    'reportDate',
  );
  @override
  late final GeneratedColumn<DateTime> reportDate = GeneratedColumn<DateTime>(
    'report_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedEpsMeta = const VerificationMeta(
    'estimatedEps',
  );
  @override
  late final GeneratedColumn<double> estimatedEps = GeneratedColumn<double>(
    'estimated_eps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualEpsMeta = const VerificationMeta(
    'actualEps',
  );
  @override
  late final GeneratedColumn<double> actualEps = GeneratedColumn<double>(
    'actual_eps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surpriseMeta = const VerificationMeta(
    'surprise',
  );
  @override
  late final GeneratedColumn<double> surprise = GeneratedColumn<double>(
    'surprise',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surprisePercentMeta = const VerificationMeta(
    'surprisePercent',
  );
  @override
  late final GeneratedColumn<double> surprisePercent = GeneratedColumn<double>(
    'surprise_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    reportDate,
    estimatedEps,
    actualEps,
    surprise,
    surprisePercent,
    period,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'earnings_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<EarningsEventData> instance, {
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
    if (data.containsKey('report_date')) {
      context.handle(
        _reportDateMeta,
        reportDate.isAcceptableOrUnknown(data['report_date']!, _reportDateMeta),
      );
    } else if (isInserting) {
      context.missing(_reportDateMeta);
    }
    if (data.containsKey('estimated_eps')) {
      context.handle(
        _estimatedEpsMeta,
        estimatedEps.isAcceptableOrUnknown(
          data['estimated_eps']!,
          _estimatedEpsMeta,
        ),
      );
    }
    if (data.containsKey('actual_eps')) {
      context.handle(
        _actualEpsMeta,
        actualEps.isAcceptableOrUnknown(data['actual_eps']!, _actualEpsMeta),
      );
    }
    if (data.containsKey('surprise')) {
      context.handle(
        _surpriseMeta,
        surprise.isAcceptableOrUnknown(data['surprise']!, _surpriseMeta),
      );
    }
    if (data.containsKey('surprise_percent')) {
      context.handle(
        _surprisePercentMeta,
        surprisePercent.isAcceptableOrUnknown(
          data['surprise_percent']!,
          _surprisePercentMeta,
        ),
      );
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EarningsEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EarningsEventData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      reportDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}report_date'],
      )!,
      estimatedEps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_eps'],
      ),
      actualEps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_eps'],
      ),
      surprise: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}surprise'],
      ),
      surprisePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}surprise_percent'],
      ),
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
    );
  }

  @override
  $EarningsEventsTable createAlias(String alias) {
    return $EarningsEventsTable(attachedDatabase, alias);
  }
}

class EarningsEventData extends DataClass
    implements Insertable<EarningsEventData> {
  final int id;
  final String symbol;
  final DateTime reportDate;
  final double? estimatedEps;
  final double? actualEps;
  final double? surprise;
  final double? surprisePercent;
  final String period;
  const EarningsEventData({
    required this.id,
    required this.symbol,
    required this.reportDate,
    this.estimatedEps,
    this.actualEps,
    this.surprise,
    this.surprisePercent,
    required this.period,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['report_date'] = Variable<DateTime>(reportDate);
    if (!nullToAbsent || estimatedEps != null) {
      map['estimated_eps'] = Variable<double>(estimatedEps);
    }
    if (!nullToAbsent || actualEps != null) {
      map['actual_eps'] = Variable<double>(actualEps);
    }
    if (!nullToAbsent || surprise != null) {
      map['surprise'] = Variable<double>(surprise);
    }
    if (!nullToAbsent || surprisePercent != null) {
      map['surprise_percent'] = Variable<double>(surprisePercent);
    }
    map['period'] = Variable<String>(period);
    return map;
  }

  EarningsEventsCompanion toCompanion(bool nullToAbsent) {
    return EarningsEventsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      reportDate: Value(reportDate),
      estimatedEps: estimatedEps == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedEps),
      actualEps: actualEps == null && nullToAbsent
          ? const Value.absent()
          : Value(actualEps),
      surprise: surprise == null && nullToAbsent
          ? const Value.absent()
          : Value(surprise),
      surprisePercent: surprisePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(surprisePercent),
      period: Value(period),
    );
  }

  factory EarningsEventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EarningsEventData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      reportDate: serializer.fromJson<DateTime>(json['reportDate']),
      estimatedEps: serializer.fromJson<double?>(json['estimatedEps']),
      actualEps: serializer.fromJson<double?>(json['actualEps']),
      surprise: serializer.fromJson<double?>(json['surprise']),
      surprisePercent: serializer.fromJson<double?>(json['surprisePercent']),
      period: serializer.fromJson<String>(json['period']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'reportDate': serializer.toJson<DateTime>(reportDate),
      'estimatedEps': serializer.toJson<double?>(estimatedEps),
      'actualEps': serializer.toJson<double?>(actualEps),
      'surprise': serializer.toJson<double?>(surprise),
      'surprisePercent': serializer.toJson<double?>(surprisePercent),
      'period': serializer.toJson<String>(period),
    };
  }

  EarningsEventData copyWith({
    int? id,
    String? symbol,
    DateTime? reportDate,
    Value<double?> estimatedEps = const Value.absent(),
    Value<double?> actualEps = const Value.absent(),
    Value<double?> surprise = const Value.absent(),
    Value<double?> surprisePercent = const Value.absent(),
    String? period,
  }) => EarningsEventData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    reportDate: reportDate ?? this.reportDate,
    estimatedEps: estimatedEps.present ? estimatedEps.value : this.estimatedEps,
    actualEps: actualEps.present ? actualEps.value : this.actualEps,
    surprise: surprise.present ? surprise.value : this.surprise,
    surprisePercent: surprisePercent.present
        ? surprisePercent.value
        : this.surprisePercent,
    period: period ?? this.period,
  );
  EarningsEventData copyWithCompanion(EarningsEventsCompanion data) {
    return EarningsEventData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      reportDate: data.reportDate.present
          ? data.reportDate.value
          : this.reportDate,
      estimatedEps: data.estimatedEps.present
          ? data.estimatedEps.value
          : this.estimatedEps,
      actualEps: data.actualEps.present ? data.actualEps.value : this.actualEps,
      surprise: data.surprise.present ? data.surprise.value : this.surprise,
      surprisePercent: data.surprisePercent.present
          ? data.surprisePercent.value
          : this.surprisePercent,
      period: data.period.present ? data.period.value : this.period,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EarningsEventData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('reportDate: $reportDate, ')
          ..write('estimatedEps: $estimatedEps, ')
          ..write('actualEps: $actualEps, ')
          ..write('surprise: $surprise, ')
          ..write('surprisePercent: $surprisePercent, ')
          ..write('period: $period')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    reportDate,
    estimatedEps,
    actualEps,
    surprise,
    surprisePercent,
    period,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EarningsEventData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.reportDate == this.reportDate &&
          other.estimatedEps == this.estimatedEps &&
          other.actualEps == this.actualEps &&
          other.surprise == this.surprise &&
          other.surprisePercent == this.surprisePercent &&
          other.period == this.period);
}

class EarningsEventsCompanion extends UpdateCompanion<EarningsEventData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<DateTime> reportDate;
  final Value<double?> estimatedEps;
  final Value<double?> actualEps;
  final Value<double?> surprise;
  final Value<double?> surprisePercent;
  final Value<String> period;
  const EarningsEventsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.reportDate = const Value.absent(),
    this.estimatedEps = const Value.absent(),
    this.actualEps = const Value.absent(),
    this.surprise = const Value.absent(),
    this.surprisePercent = const Value.absent(),
    this.period = const Value.absent(),
  });
  EarningsEventsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required DateTime reportDate,
    this.estimatedEps = const Value.absent(),
    this.actualEps = const Value.absent(),
    this.surprise = const Value.absent(),
    this.surprisePercent = const Value.absent(),
    this.period = const Value.absent(),
  }) : symbol = Value(symbol),
       reportDate = Value(reportDate);
  static Insertable<EarningsEventData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<DateTime>? reportDate,
    Expression<double>? estimatedEps,
    Expression<double>? actualEps,
    Expression<double>? surprise,
    Expression<double>? surprisePercent,
    Expression<String>? period,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (reportDate != null) 'report_date': reportDate,
      if (estimatedEps != null) 'estimated_eps': estimatedEps,
      if (actualEps != null) 'actual_eps': actualEps,
      if (surprise != null) 'surprise': surprise,
      if (surprisePercent != null) 'surprise_percent': surprisePercent,
      if (period != null) 'period': period,
    });
  }

  EarningsEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<DateTime>? reportDate,
    Value<double?>? estimatedEps,
    Value<double?>? actualEps,
    Value<double?>? surprise,
    Value<double?>? surprisePercent,
    Value<String>? period,
  }) {
    return EarningsEventsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      reportDate: reportDate ?? this.reportDate,
      estimatedEps: estimatedEps ?? this.estimatedEps,
      actualEps: actualEps ?? this.actualEps,
      surprise: surprise ?? this.surprise,
      surprisePercent: surprisePercent ?? this.surprisePercent,
      period: period ?? this.period,
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
    if (reportDate.present) {
      map['report_date'] = Variable<DateTime>(reportDate.value);
    }
    if (estimatedEps.present) {
      map['estimated_eps'] = Variable<double>(estimatedEps.value);
    }
    if (actualEps.present) {
      map['actual_eps'] = Variable<double>(actualEps.value);
    }
    if (surprise.present) {
      map['surprise'] = Variable<double>(surprise.value);
    }
    if (surprisePercent.present) {
      map['surprise_percent'] = Variable<double>(surprisePercent.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EarningsEventsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('reportDate: $reportDate, ')
          ..write('estimatedEps: $estimatedEps, ')
          ..write('actualEps: $actualEps, ')
          ..write('surprise: $surprise, ')
          ..write('surprisePercent: $surprisePercent, ')
          ..write('period: $period')
          ..write(')'))
        .toString();
  }
}

class $InsiderTransactionsTable extends InsiderTransactions
    with TableInfo<$InsiderTransactionsTable, InsiderTransactionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsiderTransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _insiderNameMeta = const VerificationMeta(
    'insiderName',
  );
  @override
  late final GeneratedColumn<String> insiderName = GeneratedColumn<String>(
    'insider_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
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
  static const VerificationMeta _totalValueMeta = const VerificationMeta(
    'totalValue',
  );
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
    'total_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filingDateMeta = const VerificationMeta(
    'filingDate',
  );
  @override
  late final GeneratedColumn<DateTime> filingDate = GeneratedColumn<DateTime>(
    'filing_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insider_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<InsiderTransactionData> instance, {
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
    if (data.containsKey('insider_name')) {
      context.handle(
        _insiderNameMeta,
        insiderName.isAcceptableOrUnknown(
          data['insider_name']!,
          _insiderNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_insiderNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
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
    if (data.containsKey('total_value')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['total_value']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
    }
    if (data.containsKey('filing_date')) {
      context.handle(
        _filingDateMeta,
        filingDate.isAcceptableOrUnknown(data['filing_date']!, _filingDateMeta),
      );
    } else if (isInserting) {
      context.missing(_filingDateMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InsiderTransactionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InsiderTransactionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      insiderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}insider_name'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
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
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_value'],
      )!,
      filingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}filing_date'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
    );
  }

  @override
  $InsiderTransactionsTable createAlias(String alias) {
    return $InsiderTransactionsTable(attachedDatabase, alias);
  }
}

class InsiderTransactionData extends DataClass
    implements Insertable<InsiderTransactionData> {
  final int id;
  final String symbol;
  final String insiderName;
  final String title;
  final String type;
  final double shares;
  final double price;
  final double totalValue;
  final DateTime filingDate;
  final DateTime transactionDate;
  const InsiderTransactionData({
    required this.id,
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['insider_name'] = Variable<String>(insiderName);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['shares'] = Variable<double>(shares);
    map['price'] = Variable<double>(price);
    map['total_value'] = Variable<double>(totalValue);
    map['filing_date'] = Variable<DateTime>(filingDate);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    return map;
  }

  InsiderTransactionsCompanion toCompanion(bool nullToAbsent) {
    return InsiderTransactionsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      insiderName: Value(insiderName),
      title: Value(title),
      type: Value(type),
      shares: Value(shares),
      price: Value(price),
      totalValue: Value(totalValue),
      filingDate: Value(filingDate),
      transactionDate: Value(transactionDate),
    );
  }

  factory InsiderTransactionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InsiderTransactionData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      insiderName: serializer.fromJson<String>(json['insiderName']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      shares: serializer.fromJson<double>(json['shares']),
      price: serializer.fromJson<double>(json['price']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      filingDate: serializer.fromJson<DateTime>(json['filingDate']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'insiderName': serializer.toJson<String>(insiderName),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'shares': serializer.toJson<double>(shares),
      'price': serializer.toJson<double>(price),
      'totalValue': serializer.toJson<double>(totalValue),
      'filingDate': serializer.toJson<DateTime>(filingDate),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
    };
  }

  InsiderTransactionData copyWith({
    int? id,
    String? symbol,
    String? insiderName,
    String? title,
    String? type,
    double? shares,
    double? price,
    double? totalValue,
    DateTime? filingDate,
    DateTime? transactionDate,
  }) => InsiderTransactionData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    insiderName: insiderName ?? this.insiderName,
    title: title ?? this.title,
    type: type ?? this.type,
    shares: shares ?? this.shares,
    price: price ?? this.price,
    totalValue: totalValue ?? this.totalValue,
    filingDate: filingDate ?? this.filingDate,
    transactionDate: transactionDate ?? this.transactionDate,
  );
  InsiderTransactionData copyWithCompanion(InsiderTransactionsCompanion data) {
    return InsiderTransactionData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      insiderName: data.insiderName.present
          ? data.insiderName.value
          : this.insiderName,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      shares: data.shares.present ? data.shares.value : this.shares,
      price: data.price.present ? data.price.value : this.price,
      totalValue: data.totalValue.present
          ? data.totalValue.value
          : this.totalValue,
      filingDate: data.filingDate.present
          ? data.filingDate.value
          : this.filingDate,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InsiderTransactionData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('insiderName: $insiderName, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('shares: $shares, ')
          ..write('price: $price, ')
          ..write('totalValue: $totalValue, ')
          ..write('filingDate: $filingDate, ')
          ..write('transactionDate: $transactionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InsiderTransactionData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.insiderName == this.insiderName &&
          other.title == this.title &&
          other.type == this.type &&
          other.shares == this.shares &&
          other.price == this.price &&
          other.totalValue == this.totalValue &&
          other.filingDate == this.filingDate &&
          other.transactionDate == this.transactionDate);
}

class InsiderTransactionsCompanion
    extends UpdateCompanion<InsiderTransactionData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> insiderName;
  final Value<String> title;
  final Value<String> type;
  final Value<double> shares;
  final Value<double> price;
  final Value<double> totalValue;
  final Value<DateTime> filingDate;
  final Value<DateTime> transactionDate;
  const InsiderTransactionsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.insiderName = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.shares = const Value.absent(),
    this.price = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.filingDate = const Value.absent(),
    this.transactionDate = const Value.absent(),
  });
  InsiderTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required String insiderName,
    required String title,
    required String type,
    required double shares,
    required double price,
    required double totalValue,
    required DateTime filingDate,
    required DateTime transactionDate,
  }) : symbol = Value(symbol),
       insiderName = Value(insiderName),
       title = Value(title),
       type = Value(type),
       shares = Value(shares),
       price = Value(price),
       totalValue = Value(totalValue),
       filingDate = Value(filingDate),
       transactionDate = Value(transactionDate);
  static Insertable<InsiderTransactionData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? insiderName,
    Expression<String>? title,
    Expression<String>? type,
    Expression<double>? shares,
    Expression<double>? price,
    Expression<double>? totalValue,
    Expression<DateTime>? filingDate,
    Expression<DateTime>? transactionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (insiderName != null) 'insider_name': insiderName,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (shares != null) 'shares': shares,
      if (price != null) 'price': price,
      if (totalValue != null) 'total_value': totalValue,
      if (filingDate != null) 'filing_date': filingDate,
      if (transactionDate != null) 'transaction_date': transactionDate,
    });
  }

  InsiderTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? insiderName,
    Value<String>? title,
    Value<String>? type,
    Value<double>? shares,
    Value<double>? price,
    Value<double>? totalValue,
    Value<DateTime>? filingDate,
    Value<DateTime>? transactionDate,
  }) {
    return InsiderTransactionsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      insiderName: insiderName ?? this.insiderName,
      title: title ?? this.title,
      type: type ?? this.type,
      shares: shares ?? this.shares,
      price: price ?? this.price,
      totalValue: totalValue ?? this.totalValue,
      filingDate: filingDate ?? this.filingDate,
      transactionDate: transactionDate ?? this.transactionDate,
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
    if (insiderName.present) {
      map['insider_name'] = Variable<String>(insiderName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
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
    if (totalValue.present) {
      map['total_value'] = Variable<double>(totalValue.value);
    }
    if (filingDate.present) {
      map['filing_date'] = Variable<DateTime>(filingDate.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsiderTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('insiderName: $insiderName, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('shares: $shares, ')
          ..write('price: $price, ')
          ..write('totalValue: $totalValue, ')
          ..write('filingDate: $filingDate, ')
          ..write('transactionDate: $transactionDate')
          ..write(')'))
        .toString();
  }
}

class $InstitutionalHoldersTable extends InstitutionalHolders
    with TableInfo<$InstitutionalHoldersTable, InstitutionalHolderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstitutionalHoldersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _holderNameMeta = const VerificationMeta(
    'holderName',
  );
  @override
  late final GeneratedColumn<String> holderName = GeneratedColumn<String>(
    'holder_name',
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
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentOutMeta = const VerificationMeta(
    'percentOut',
  );
  @override
  late final GeneratedColumn<double> percentOut = GeneratedColumn<double>(
    'percent_out',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportDateMeta = const VerificationMeta(
    'reportDate',
  );
  @override
  late final GeneratedColumn<DateTime> reportDate = GeneratedColumn<DateTime>(
    'report_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeMeta = const VerificationMeta('change');
  @override
  late final GeneratedColumn<double> change = GeneratedColumn<double>(
    'change',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symbol,
    holderName,
    shares,
    value,
    percentOut,
    reportDate,
    change,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'institutional_holders';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstitutionalHolderData> instance, {
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
    if (data.containsKey('holder_name')) {
      context.handle(
        _holderNameMeta,
        holderName.isAcceptableOrUnknown(data['holder_name']!, _holderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_holderNameMeta);
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('percent_out')) {
      context.handle(
        _percentOutMeta,
        percentOut.isAcceptableOrUnknown(data['percent_out']!, _percentOutMeta),
      );
    } else if (isInserting) {
      context.missing(_percentOutMeta);
    }
    if (data.containsKey('report_date')) {
      context.handle(
        _reportDateMeta,
        reportDate.isAcceptableOrUnknown(data['report_date']!, _reportDateMeta),
      );
    } else if (isInserting) {
      context.missing(_reportDateMeta);
    }
    if (data.containsKey('change')) {
      context.handle(
        _changeMeta,
        change.isAcceptableOrUnknown(data['change']!, _changeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstitutionalHolderData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstitutionalHolderData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      holderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holder_name'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shares'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      percentOut: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percent_out'],
      )!,
      reportDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}report_date'],
      )!,
      change: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}change'],
      ),
    );
  }

  @override
  $InstitutionalHoldersTable createAlias(String alias) {
    return $InstitutionalHoldersTable(attachedDatabase, alias);
  }
}

class InstitutionalHolderData extends DataClass
    implements Insertable<InstitutionalHolderData> {
  final int id;
  final String symbol;
  final String holderName;
  final double shares;
  final double value;
  final double percentOut;
  final DateTime reportDate;
  final double? change;
  const InstitutionalHolderData({
    required this.id,
    required this.symbol,
    required this.holderName,
    required this.shares,
    required this.value,
    required this.percentOut,
    required this.reportDate,
    this.change,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['holder_name'] = Variable<String>(holderName);
    map['shares'] = Variable<double>(shares);
    map['value'] = Variable<double>(value);
    map['percent_out'] = Variable<double>(percentOut);
    map['report_date'] = Variable<DateTime>(reportDate);
    if (!nullToAbsent || change != null) {
      map['change'] = Variable<double>(change);
    }
    return map;
  }

  InstitutionalHoldersCompanion toCompanion(bool nullToAbsent) {
    return InstitutionalHoldersCompanion(
      id: Value(id),
      symbol: Value(symbol),
      holderName: Value(holderName),
      shares: Value(shares),
      value: Value(value),
      percentOut: Value(percentOut),
      reportDate: Value(reportDate),
      change: change == null && nullToAbsent
          ? const Value.absent()
          : Value(change),
    );
  }

  factory InstitutionalHolderData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstitutionalHolderData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      holderName: serializer.fromJson<String>(json['holderName']),
      shares: serializer.fromJson<double>(json['shares']),
      value: serializer.fromJson<double>(json['value']),
      percentOut: serializer.fromJson<double>(json['percentOut']),
      reportDate: serializer.fromJson<DateTime>(json['reportDate']),
      change: serializer.fromJson<double?>(json['change']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'holderName': serializer.toJson<String>(holderName),
      'shares': serializer.toJson<double>(shares),
      'value': serializer.toJson<double>(value),
      'percentOut': serializer.toJson<double>(percentOut),
      'reportDate': serializer.toJson<DateTime>(reportDate),
      'change': serializer.toJson<double?>(change),
    };
  }

  InstitutionalHolderData copyWith({
    int? id,
    String? symbol,
    String? holderName,
    double? shares,
    double? value,
    double? percentOut,
    DateTime? reportDate,
    Value<double?> change = const Value.absent(),
  }) => InstitutionalHolderData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    holderName: holderName ?? this.holderName,
    shares: shares ?? this.shares,
    value: value ?? this.value,
    percentOut: percentOut ?? this.percentOut,
    reportDate: reportDate ?? this.reportDate,
    change: change.present ? change.value : this.change,
  );
  InstitutionalHolderData copyWithCompanion(
    InstitutionalHoldersCompanion data,
  ) {
    return InstitutionalHolderData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      holderName: data.holderName.present
          ? data.holderName.value
          : this.holderName,
      shares: data.shares.present ? data.shares.value : this.shares,
      value: data.value.present ? data.value.value : this.value,
      percentOut: data.percentOut.present
          ? data.percentOut.value
          : this.percentOut,
      reportDate: data.reportDate.present
          ? data.reportDate.value
          : this.reportDate,
      change: data.change.present ? data.change.value : this.change,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstitutionalHolderData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('holderName: $holderName, ')
          ..write('shares: $shares, ')
          ..write('value: $value, ')
          ..write('percentOut: $percentOut, ')
          ..write('reportDate: $reportDate, ')
          ..write('change: $change')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    holderName,
    shares,
    value,
    percentOut,
    reportDate,
    change,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstitutionalHolderData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.holderName == this.holderName &&
          other.shares == this.shares &&
          other.value == this.value &&
          other.percentOut == this.percentOut &&
          other.reportDate == this.reportDate &&
          other.change == this.change);
}

class InstitutionalHoldersCompanion
    extends UpdateCompanion<InstitutionalHolderData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> holderName;
  final Value<double> shares;
  final Value<double> value;
  final Value<double> percentOut;
  final Value<DateTime> reportDate;
  final Value<double?> change;
  const InstitutionalHoldersCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.holderName = const Value.absent(),
    this.shares = const Value.absent(),
    this.value = const Value.absent(),
    this.percentOut = const Value.absent(),
    this.reportDate = const Value.absent(),
    this.change = const Value.absent(),
  });
  InstitutionalHoldersCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required String holderName,
    required double shares,
    required double value,
    required double percentOut,
    required DateTime reportDate,
    this.change = const Value.absent(),
  }) : symbol = Value(symbol),
       holderName = Value(holderName),
       shares = Value(shares),
       value = Value(value),
       percentOut = Value(percentOut),
       reportDate = Value(reportDate);
  static Insertable<InstitutionalHolderData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? holderName,
    Expression<double>? shares,
    Expression<double>? value,
    Expression<double>? percentOut,
    Expression<DateTime>? reportDate,
    Expression<double>? change,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (holderName != null) 'holder_name': holderName,
      if (shares != null) 'shares': shares,
      if (value != null) 'value': value,
      if (percentOut != null) 'percent_out': percentOut,
      if (reportDate != null) 'report_date': reportDate,
      if (change != null) 'change': change,
    });
  }

  InstitutionalHoldersCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? holderName,
    Value<double>? shares,
    Value<double>? value,
    Value<double>? percentOut,
    Value<DateTime>? reportDate,
    Value<double?>? change,
  }) {
    return InstitutionalHoldersCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      holderName: holderName ?? this.holderName,
      shares: shares ?? this.shares,
      value: value ?? this.value,
      percentOut: percentOut ?? this.percentOut,
      reportDate: reportDate ?? this.reportDate,
      change: change ?? this.change,
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
    if (holderName.present) {
      map['holder_name'] = Variable<String>(holderName.value);
    }
    if (shares.present) {
      map['shares'] = Variable<double>(shares.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (percentOut.present) {
      map['percent_out'] = Variable<double>(percentOut.value);
    }
    if (reportDate.present) {
      map['report_date'] = Variable<DateTime>(reportDate.value);
    }
    if (change.present) {
      map['change'] = Variable<double>(change.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstitutionalHoldersCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('holderName: $holderName, ')
          ..write('shares: $shares, ')
          ..write('value: $value, ')
          ..write('percentOut: $percentOut, ')
          ..write('reportDate: $reportDate, ')
          ..write('change: $change')
          ..write(')'))
        .toString();
  }
}

class $DiscoveriesTable extends Discoveries
    with TableInfo<$DiscoveriesTable, DiscoveryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscoveriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strategyMeta = const VerificationMeta(
    'strategy',
  );
  @override
  late final GeneratedColumn<String> strategy = GeneratedColumn<String>(
    'strategy',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ai'),
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
  static const VerificationMeta _discoveredAtMeta = const VerificationMeta(
    'discoveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> discoveredAt = GeneratedColumn<DateTime>(
    'discovered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isPromotedMeta = const VerificationMeta(
    'isPromoted',
  );
  @override
  late final GeneratedColumn<bool> isPromoted = GeneratedColumn<bool>(
    'is_promoted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_promoted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDismissedMeta = const VerificationMeta(
    'isDismissed',
  );
  @override
  late final GeneratedColumn<bool> isDismissed = GeneratedColumn<bool>(
    'is_dismissed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dismissed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _potentialUpsideMeta = const VerificationMeta(
    'potentialUpside',
  );
  @override
  late final GeneratedColumn<double> potentialUpside = GeneratedColumn<double>(
    'potential_upside',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discoveries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiscoveryData> instance, {
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
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('strategy')) {
      context.handle(
        _strategyMeta,
        strategy.isAcceptableOrUnknown(data['strategy']!, _strategyMeta),
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
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('discovered_at')) {
      context.handle(
        _discoveredAtMeta,
        discoveredAt.isAcceptableOrUnknown(
          data['discovered_at']!,
          _discoveredAtMeta,
        ),
      );
    }
    if (data.containsKey('is_promoted')) {
      context.handle(
        _isPromotedMeta,
        isPromoted.isAcceptableOrUnknown(data['is_promoted']!, _isPromotedMeta),
      );
    }
    if (data.containsKey('is_dismissed')) {
      context.handle(
        _isDismissedMeta,
        isDismissed.isAcceptableOrUnknown(
          data['is_dismissed']!,
          _isDismissedMeta,
        ),
      );
    }
    if (data.containsKey('potential_upside')) {
      context.handle(
        _potentialUpsideMeta,
        potentialUpside.isAcceptableOrUnknown(
          data['potential_upside']!,
          _potentialUpsideMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiscoveryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscoveryData(
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
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      strategy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}strategy'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      discoveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}discovered_at'],
      )!,
      isPromoted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_promoted'],
      )!,
      isDismissed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dismissed'],
      )!,
      potentialUpside: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}potential_upside'],
      ),
    );
  }

  @override
  $DiscoveriesTable createAlias(String alias) {
    return $DiscoveriesTable(attachedDatabase, alias);
  }
}

class DiscoveryData extends DataClass implements Insertable<DiscoveryData> {
  final int id;
  final String symbol;
  final String companyName;
  final String reason;
  final String strategy;
  final double currentPrice;
  final double confidence;
  final DateTime discoveredAt;
  final bool isPromoted;
  final bool isDismissed;
  final double? potentialUpside;
  const DiscoveryData({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.reason,
    required this.strategy,
    required this.currentPrice,
    required this.confidence,
    required this.discoveredAt,
    required this.isPromoted,
    required this.isDismissed,
    this.potentialUpside,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['company_name'] = Variable<String>(companyName);
    map['reason'] = Variable<String>(reason);
    map['strategy'] = Variable<String>(strategy);
    map['current_price'] = Variable<double>(currentPrice);
    map['confidence'] = Variable<double>(confidence);
    map['discovered_at'] = Variable<DateTime>(discoveredAt);
    map['is_promoted'] = Variable<bool>(isPromoted);
    map['is_dismissed'] = Variable<bool>(isDismissed);
    if (!nullToAbsent || potentialUpside != null) {
      map['potential_upside'] = Variable<double>(potentialUpside);
    }
    return map;
  }

  DiscoveriesCompanion toCompanion(bool nullToAbsent) {
    return DiscoveriesCompanion(
      id: Value(id),
      symbol: Value(symbol),
      companyName: Value(companyName),
      reason: Value(reason),
      strategy: Value(strategy),
      currentPrice: Value(currentPrice),
      confidence: Value(confidence),
      discoveredAt: Value(discoveredAt),
      isPromoted: Value(isPromoted),
      isDismissed: Value(isDismissed),
      potentialUpside: potentialUpside == null && nullToAbsent
          ? const Value.absent()
          : Value(potentialUpside),
    );
  }

  factory DiscoveryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiscoveryData(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      companyName: serializer.fromJson<String>(json['companyName']),
      reason: serializer.fromJson<String>(json['reason']),
      strategy: serializer.fromJson<String>(json['strategy']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      confidence: serializer.fromJson<double>(json['confidence']),
      discoveredAt: serializer.fromJson<DateTime>(json['discoveredAt']),
      isPromoted: serializer.fromJson<bool>(json['isPromoted']),
      isDismissed: serializer.fromJson<bool>(json['isDismissed']),
      potentialUpside: serializer.fromJson<double?>(json['potentialUpside']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'companyName': serializer.toJson<String>(companyName),
      'reason': serializer.toJson<String>(reason),
      'strategy': serializer.toJson<String>(strategy),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'confidence': serializer.toJson<double>(confidence),
      'discoveredAt': serializer.toJson<DateTime>(discoveredAt),
      'isPromoted': serializer.toJson<bool>(isPromoted),
      'isDismissed': serializer.toJson<bool>(isDismissed),
      'potentialUpside': serializer.toJson<double?>(potentialUpside),
    };
  }

  DiscoveryData copyWith({
    int? id,
    String? symbol,
    String? companyName,
    String? reason,
    String? strategy,
    double? currentPrice,
    double? confidence,
    DateTime? discoveredAt,
    bool? isPromoted,
    bool? isDismissed,
    Value<double?> potentialUpside = const Value.absent(),
  }) => DiscoveryData(
    id: id ?? this.id,
    symbol: symbol ?? this.symbol,
    companyName: companyName ?? this.companyName,
    reason: reason ?? this.reason,
    strategy: strategy ?? this.strategy,
    currentPrice: currentPrice ?? this.currentPrice,
    confidence: confidence ?? this.confidence,
    discoveredAt: discoveredAt ?? this.discoveredAt,
    isPromoted: isPromoted ?? this.isPromoted,
    isDismissed: isDismissed ?? this.isDismissed,
    potentialUpside: potentialUpside.present
        ? potentialUpside.value
        : this.potentialUpside,
  );
  DiscoveryData copyWithCompanion(DiscoveriesCompanion data) {
    return DiscoveryData(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      reason: data.reason.present ? data.reason.value : this.reason,
      strategy: data.strategy.present ? data.strategy.value : this.strategy,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      discoveredAt: data.discoveredAt.present
          ? data.discoveredAt.value
          : this.discoveredAt,
      isPromoted: data.isPromoted.present
          ? data.isPromoted.value
          : this.isPromoted,
      isDismissed: data.isDismissed.present
          ? data.isDismissed.value
          : this.isDismissed,
      potentialUpside: data.potentialUpside.present
          ? data.potentialUpside.value
          : this.potentialUpside,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiscoveryData(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('companyName: $companyName, ')
          ..write('reason: $reason, ')
          ..write('strategy: $strategy, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('confidence: $confidence, ')
          ..write('discoveredAt: $discoveredAt, ')
          ..write('isPromoted: $isPromoted, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('potentialUpside: $potentialUpside')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscoveryData &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.companyName == this.companyName &&
          other.reason == this.reason &&
          other.strategy == this.strategy &&
          other.currentPrice == this.currentPrice &&
          other.confidence == this.confidence &&
          other.discoveredAt == this.discoveredAt &&
          other.isPromoted == this.isPromoted &&
          other.isDismissed == this.isDismissed &&
          other.potentialUpside == this.potentialUpside);
}

class DiscoveriesCompanion extends UpdateCompanion<DiscoveryData> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> companyName;
  final Value<String> reason;
  final Value<String> strategy;
  final Value<double> currentPrice;
  final Value<double> confidence;
  final Value<DateTime> discoveredAt;
  final Value<bool> isPromoted;
  final Value<bool> isDismissed;
  final Value<double?> potentialUpside;
  const DiscoveriesCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.companyName = const Value.absent(),
    this.reason = const Value.absent(),
    this.strategy = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.confidence = const Value.absent(),
    this.discoveredAt = const Value.absent(),
    this.isPromoted = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.potentialUpside = const Value.absent(),
  });
  DiscoveriesCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    this.companyName = const Value.absent(),
    required String reason,
    this.strategy = const Value.absent(),
    required double currentPrice,
    required double confidence,
    this.discoveredAt = const Value.absent(),
    this.isPromoted = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.potentialUpside = const Value.absent(),
  }) : symbol = Value(symbol),
       reason = Value(reason),
       currentPrice = Value(currentPrice),
       confidence = Value(confidence);
  static Insertable<DiscoveryData> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? companyName,
    Expression<String>? reason,
    Expression<String>? strategy,
    Expression<double>? currentPrice,
    Expression<double>? confidence,
    Expression<DateTime>? discoveredAt,
    Expression<bool>? isPromoted,
    Expression<bool>? isDismissed,
    Expression<double>? potentialUpside,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (companyName != null) 'company_name': companyName,
      if (reason != null) 'reason': reason,
      if (strategy != null) 'strategy': strategy,
      if (currentPrice != null) 'current_price': currentPrice,
      if (confidence != null) 'confidence': confidence,
      if (discoveredAt != null) 'discovered_at': discoveredAt,
      if (isPromoted != null) 'is_promoted': isPromoted,
      if (isDismissed != null) 'is_dismissed': isDismissed,
      if (potentialUpside != null) 'potential_upside': potentialUpside,
    });
  }

  DiscoveriesCompanion copyWith({
    Value<int>? id,
    Value<String>? symbol,
    Value<String>? companyName,
    Value<String>? reason,
    Value<String>? strategy,
    Value<double>? currentPrice,
    Value<double>? confidence,
    Value<DateTime>? discoveredAt,
    Value<bool>? isPromoted,
    Value<bool>? isDismissed,
    Value<double?>? potentialUpside,
  }) {
    return DiscoveriesCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      reason: reason ?? this.reason,
      strategy: strategy ?? this.strategy,
      currentPrice: currentPrice ?? this.currentPrice,
      confidence: confidence ?? this.confidence,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      isPromoted: isPromoted ?? this.isPromoted,
      isDismissed: isDismissed ?? this.isDismissed,
      potentialUpside: potentialUpside ?? this.potentialUpside,
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
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (strategy.present) {
      map['strategy'] = Variable<String>(strategy.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (discoveredAt.present) {
      map['discovered_at'] = Variable<DateTime>(discoveredAt.value);
    }
    if (isPromoted.present) {
      map['is_promoted'] = Variable<bool>(isPromoted.value);
    }
    if (isDismissed.present) {
      map['is_dismissed'] = Variable<bool>(isDismissed.value);
    }
    if (potentialUpside.present) {
      map['potential_upside'] = Variable<double>(potentialUpside.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscoveriesCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('companyName: $companyName, ')
          ..write('reason: $reason, ')
          ..write('strategy: $strategy, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('confidence: $confidence, ')
          ..write('discoveredAt: $discoveredAt, ')
          ..write('isPromoted: $isPromoted, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('potentialUpside: $potentialUpside')
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
  late final $FinancialRatiosTable financialRatios = $FinancialRatiosTable(
    this,
  );
  late final $CorporateActionsTable corporateActions = $CorporateActionsTable(
    this,
  );
  late final $EarningsEventsTable earningsEvents = $EarningsEventsTable(this);
  late final $InsiderTransactionsTable insiderTransactions =
      $InsiderTransactionsTable(this);
  late final $InstitutionalHoldersTable institutionalHolders =
      $InstitutionalHoldersTable(this);
  late final $DiscoveriesTable discoveries = $DiscoveriesTable(this);
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
  late final Index idxFinRatioSymbol = Index(
    'idx_fin_ratio_symbol',
    'CREATE UNIQUE INDEX idx_fin_ratio_symbol ON financial_ratios (symbol)',
  );
  late final Index idxCaSymbol = Index(
    'idx_ca_symbol',
    'CREATE INDEX idx_ca_symbol ON corporate_actions (symbol)',
  );
  late final Index idxEarningsSymbol = Index(
    'idx_earnings_symbol',
    'CREATE INDEX idx_earnings_symbol ON earnings_events (symbol)',
  );
  late final Index idxInsiderSymbol = Index(
    'idx_insider_symbol',
    'CREATE INDEX idx_insider_symbol ON insider_transactions (symbol)',
  );
  late final Index idxInstSymbol = Index(
    'idx_inst_symbol',
    'CREATE INDEX idx_inst_symbol ON institutional_holders (symbol)',
  );
  late final Index idxDiscSymbol = Index(
    'idx_disc_symbol',
    'CREATE INDEX idx_disc_symbol ON discoveries (symbol)',
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
    financialRatios,
    corporateActions,
    earningsEvents,
    insiderTransactions,
    institutionalHolders,
    discoveries,
    idxWatchlistSymbol,
    idxCacheSymbol,
    idxStageUnique,
    idxAnalysisSymbol,
    idxAnalysisCreated,
    idxPositionSymbol,
    idxPaperSymbol,
    idxFinRatioSymbol,
    idxCaSymbol,
    idxEarningsSymbol,
    idxInsiderSymbol,
    idxInstSymbol,
    idxDiscSymbol,
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
typedef $$FinancialRatiosTableCreateCompanionBuilder =
    FinancialRatiosCompanion Function({
      Value<int> id,
      required String symbol,
      Value<double?> peRatio,
      Value<double?> pbRatio,
      Value<double?> eps,
      Value<double?> dividendYield,
      Value<double?> beta,
      Value<String> week52High,
      Value<String> week52Low,
      Value<double?> marketCap,
      Value<double?> revenueGrowth,
      Value<double?> profitMargin,
      Value<double?> debtToEquity,
      Value<double?> roe,
      Value<DateTime?> updatedAt,
    });
typedef $$FinancialRatiosTableUpdateCompanionBuilder =
    FinancialRatiosCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<double?> peRatio,
      Value<double?> pbRatio,
      Value<double?> eps,
      Value<double?> dividendYield,
      Value<double?> beta,
      Value<String> week52High,
      Value<String> week52Low,
      Value<double?> marketCap,
      Value<double?> revenueGrowth,
      Value<double?> profitMargin,
      Value<double?> debtToEquity,
      Value<double?> roe,
      Value<DateTime?> updatedAt,
    });

class $$FinancialRatiosTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialRatiosTable> {
  $$FinancialRatiosTableFilterComposer({
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

  ColumnFilters<double> get peRatio => $composableBuilder(
    column: $table.peRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pbRatio => $composableBuilder(
    column: $table.pbRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get eps => $composableBuilder(
    column: $table.eps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dividendYield => $composableBuilder(
    column: $table.dividendYield,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get beta => $composableBuilder(
    column: $table.beta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get week52High => $composableBuilder(
    column: $table.week52High,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get week52Low => $composableBuilder(
    column: $table.week52Low,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get marketCap => $composableBuilder(
    column: $table.marketCap,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get revenueGrowth => $composableBuilder(
    column: $table.revenueGrowth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get profitMargin => $composableBuilder(
    column: $table.profitMargin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get debtToEquity => $composableBuilder(
    column: $table.debtToEquity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get roe => $composableBuilder(
    column: $table.roe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinancialRatiosTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialRatiosTable> {
  $$FinancialRatiosTableOrderingComposer({
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

  ColumnOrderings<double> get peRatio => $composableBuilder(
    column: $table.peRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pbRatio => $composableBuilder(
    column: $table.pbRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get eps => $composableBuilder(
    column: $table.eps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dividendYield => $composableBuilder(
    column: $table.dividendYield,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get beta => $composableBuilder(
    column: $table.beta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get week52High => $composableBuilder(
    column: $table.week52High,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get week52Low => $composableBuilder(
    column: $table.week52Low,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get marketCap => $composableBuilder(
    column: $table.marketCap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get revenueGrowth => $composableBuilder(
    column: $table.revenueGrowth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get profitMargin => $composableBuilder(
    column: $table.profitMargin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get debtToEquity => $composableBuilder(
    column: $table.debtToEquity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get roe => $composableBuilder(
    column: $table.roe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinancialRatiosTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialRatiosTable> {
  $$FinancialRatiosTableAnnotationComposer({
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

  GeneratedColumn<double> get peRatio =>
      $composableBuilder(column: $table.peRatio, builder: (column) => column);

  GeneratedColumn<double> get pbRatio =>
      $composableBuilder(column: $table.pbRatio, builder: (column) => column);

  GeneratedColumn<double> get eps =>
      $composableBuilder(column: $table.eps, builder: (column) => column);

  GeneratedColumn<double> get dividendYield => $composableBuilder(
    column: $table.dividendYield,
    builder: (column) => column,
  );

  GeneratedColumn<double> get beta =>
      $composableBuilder(column: $table.beta, builder: (column) => column);

  GeneratedColumn<String> get week52High => $composableBuilder(
    column: $table.week52High,
    builder: (column) => column,
  );

  GeneratedColumn<String> get week52Low =>
      $composableBuilder(column: $table.week52Low, builder: (column) => column);

  GeneratedColumn<double> get marketCap =>
      $composableBuilder(column: $table.marketCap, builder: (column) => column);

  GeneratedColumn<double> get revenueGrowth => $composableBuilder(
    column: $table.revenueGrowth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get profitMargin => $composableBuilder(
    column: $table.profitMargin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get debtToEquity => $composableBuilder(
    column: $table.debtToEquity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get roe =>
      $composableBuilder(column: $table.roe, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FinancialRatiosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialRatiosTable,
          FinancialRatioData,
          $$FinancialRatiosTableFilterComposer,
          $$FinancialRatiosTableOrderingComposer,
          $$FinancialRatiosTableAnnotationComposer,
          $$FinancialRatiosTableCreateCompanionBuilder,
          $$FinancialRatiosTableUpdateCompanionBuilder,
          (
            FinancialRatioData,
            BaseReferences<
              _$AppDatabase,
              $FinancialRatiosTable,
              FinancialRatioData
            >,
          ),
          FinancialRatioData,
          PrefetchHooks Function()
        > {
  $$FinancialRatiosTableTableManager(
    _$AppDatabase db,
    $FinancialRatiosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialRatiosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialRatiosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialRatiosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<double?> peRatio = const Value.absent(),
                Value<double?> pbRatio = const Value.absent(),
                Value<double?> eps = const Value.absent(),
                Value<double?> dividendYield = const Value.absent(),
                Value<double?> beta = const Value.absent(),
                Value<String> week52High = const Value.absent(),
                Value<String> week52Low = const Value.absent(),
                Value<double?> marketCap = const Value.absent(),
                Value<double?> revenueGrowth = const Value.absent(),
                Value<double?> profitMargin = const Value.absent(),
                Value<double?> debtToEquity = const Value.absent(),
                Value<double?> roe = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => FinancialRatiosCompanion(
                id: id,
                symbol: symbol,
                peRatio: peRatio,
                pbRatio: pbRatio,
                eps: eps,
                dividendYield: dividendYield,
                beta: beta,
                week52High: week52High,
                week52Low: week52Low,
                marketCap: marketCap,
                revenueGrowth: revenueGrowth,
                profitMargin: profitMargin,
                debtToEquity: debtToEquity,
                roe: roe,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                Value<double?> peRatio = const Value.absent(),
                Value<double?> pbRatio = const Value.absent(),
                Value<double?> eps = const Value.absent(),
                Value<double?> dividendYield = const Value.absent(),
                Value<double?> beta = const Value.absent(),
                Value<String> week52High = const Value.absent(),
                Value<String> week52Low = const Value.absent(),
                Value<double?> marketCap = const Value.absent(),
                Value<double?> revenueGrowth = const Value.absent(),
                Value<double?> profitMargin = const Value.absent(),
                Value<double?> debtToEquity = const Value.absent(),
                Value<double?> roe = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => FinancialRatiosCompanion.insert(
                id: id,
                symbol: symbol,
                peRatio: peRatio,
                pbRatio: pbRatio,
                eps: eps,
                dividendYield: dividendYield,
                beta: beta,
                week52High: week52High,
                week52Low: week52Low,
                marketCap: marketCap,
                revenueGrowth: revenueGrowth,
                profitMargin: profitMargin,
                debtToEquity: debtToEquity,
                roe: roe,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinancialRatiosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialRatiosTable,
      FinancialRatioData,
      $$FinancialRatiosTableFilterComposer,
      $$FinancialRatiosTableOrderingComposer,
      $$FinancialRatiosTableAnnotationComposer,
      $$FinancialRatiosTableCreateCompanionBuilder,
      $$FinancialRatiosTableUpdateCompanionBuilder,
      (
        FinancialRatioData,
        BaseReferences<
          _$AppDatabase,
          $FinancialRatiosTable,
          FinancialRatioData
        >,
      ),
      FinancialRatioData,
      PrefetchHooks Function()
    >;
typedef $$CorporateActionsTableCreateCompanionBuilder =
    CorporateActionsCompanion Function({
      Value<int> id,
      required String symbol,
      required String type,
      required DateTime date,
      Value<String?> description,
      Value<double?> amount,
      Value<String> currency,
    });
typedef $$CorporateActionsTableUpdateCompanionBuilder =
    CorporateActionsCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> type,
      Value<DateTime> date,
      Value<String?> description,
      Value<double?> amount,
      Value<String> currency,
    });

class $$CorporateActionsTableFilterComposer
    extends Composer<_$AppDatabase, $CorporateActionsTable> {
  $$CorporateActionsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CorporateActionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CorporateActionsTable> {
  $$CorporateActionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CorporateActionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CorporateActionsTable> {
  $$CorporateActionsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$CorporateActionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CorporateActionsTable,
          CorporateActionData,
          $$CorporateActionsTableFilterComposer,
          $$CorporateActionsTableOrderingComposer,
          $$CorporateActionsTableAnnotationComposer,
          $$CorporateActionsTableCreateCompanionBuilder,
          $$CorporateActionsTableUpdateCompanionBuilder,
          (
            CorporateActionData,
            BaseReferences<
              _$AppDatabase,
              $CorporateActionsTable,
              CorporateActionData
            >,
          ),
          CorporateActionData,
          PrefetchHooks Function()
        > {
  $$CorporateActionsTableTableManager(
    _$AppDatabase db,
    $CorporateActionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CorporateActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CorporateActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CorporateActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
              }) => CorporateActionsCompanion(
                id: id,
                symbol: symbol,
                type: type,
                date: date,
                description: description,
                amount: amount,
                currency: currency,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                required String type,
                required DateTime date,
                Value<String?> description = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
              }) => CorporateActionsCompanion.insert(
                id: id,
                symbol: symbol,
                type: type,
                date: date,
                description: description,
                amount: amount,
                currency: currency,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CorporateActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CorporateActionsTable,
      CorporateActionData,
      $$CorporateActionsTableFilterComposer,
      $$CorporateActionsTableOrderingComposer,
      $$CorporateActionsTableAnnotationComposer,
      $$CorporateActionsTableCreateCompanionBuilder,
      $$CorporateActionsTableUpdateCompanionBuilder,
      (
        CorporateActionData,
        BaseReferences<
          _$AppDatabase,
          $CorporateActionsTable,
          CorporateActionData
        >,
      ),
      CorporateActionData,
      PrefetchHooks Function()
    >;
typedef $$EarningsEventsTableCreateCompanionBuilder =
    EarningsEventsCompanion Function({
      Value<int> id,
      required String symbol,
      required DateTime reportDate,
      Value<double?> estimatedEps,
      Value<double?> actualEps,
      Value<double?> surprise,
      Value<double?> surprisePercent,
      Value<String> period,
    });
typedef $$EarningsEventsTableUpdateCompanionBuilder =
    EarningsEventsCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<DateTime> reportDate,
      Value<double?> estimatedEps,
      Value<double?> actualEps,
      Value<double?> surprise,
      Value<double?> surprisePercent,
      Value<String> period,
    });

class $$EarningsEventsTableFilterComposer
    extends Composer<_$AppDatabase, $EarningsEventsTable> {
  $$EarningsEventsTableFilterComposer({
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

  ColumnFilters<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedEps => $composableBuilder(
    column: $table.estimatedEps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualEps => $composableBuilder(
    column: $table.actualEps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get surprise => $composableBuilder(
    column: $table.surprise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get surprisePercent => $composableBuilder(
    column: $table.surprisePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EarningsEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EarningsEventsTable> {
  $$EarningsEventsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedEps => $composableBuilder(
    column: $table.estimatedEps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualEps => $composableBuilder(
    column: $table.actualEps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get surprise => $composableBuilder(
    column: $table.surprise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get surprisePercent => $composableBuilder(
    column: $table.surprisePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EarningsEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EarningsEventsTable> {
  $$EarningsEventsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedEps => $composableBuilder(
    column: $table.estimatedEps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualEps =>
      $composableBuilder(column: $table.actualEps, builder: (column) => column);

  GeneratedColumn<double> get surprise =>
      $composableBuilder(column: $table.surprise, builder: (column) => column);

  GeneratedColumn<double> get surprisePercent => $composableBuilder(
    column: $table.surprisePercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);
}

class $$EarningsEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EarningsEventsTable,
          EarningsEventData,
          $$EarningsEventsTableFilterComposer,
          $$EarningsEventsTableOrderingComposer,
          $$EarningsEventsTableAnnotationComposer,
          $$EarningsEventsTableCreateCompanionBuilder,
          $$EarningsEventsTableUpdateCompanionBuilder,
          (
            EarningsEventData,
            BaseReferences<
              _$AppDatabase,
              $EarningsEventsTable,
              EarningsEventData
            >,
          ),
          EarningsEventData,
          PrefetchHooks Function()
        > {
  $$EarningsEventsTableTableManager(
    _$AppDatabase db,
    $EarningsEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EarningsEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EarningsEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EarningsEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<DateTime> reportDate = const Value.absent(),
                Value<double?> estimatedEps = const Value.absent(),
                Value<double?> actualEps = const Value.absent(),
                Value<double?> surprise = const Value.absent(),
                Value<double?> surprisePercent = const Value.absent(),
                Value<String> period = const Value.absent(),
              }) => EarningsEventsCompanion(
                id: id,
                symbol: symbol,
                reportDate: reportDate,
                estimatedEps: estimatedEps,
                actualEps: actualEps,
                surprise: surprise,
                surprisePercent: surprisePercent,
                period: period,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                required DateTime reportDate,
                Value<double?> estimatedEps = const Value.absent(),
                Value<double?> actualEps = const Value.absent(),
                Value<double?> surprise = const Value.absent(),
                Value<double?> surprisePercent = const Value.absent(),
                Value<String> period = const Value.absent(),
              }) => EarningsEventsCompanion.insert(
                id: id,
                symbol: symbol,
                reportDate: reportDate,
                estimatedEps: estimatedEps,
                actualEps: actualEps,
                surprise: surprise,
                surprisePercent: surprisePercent,
                period: period,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EarningsEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EarningsEventsTable,
      EarningsEventData,
      $$EarningsEventsTableFilterComposer,
      $$EarningsEventsTableOrderingComposer,
      $$EarningsEventsTableAnnotationComposer,
      $$EarningsEventsTableCreateCompanionBuilder,
      $$EarningsEventsTableUpdateCompanionBuilder,
      (
        EarningsEventData,
        BaseReferences<_$AppDatabase, $EarningsEventsTable, EarningsEventData>,
      ),
      EarningsEventData,
      PrefetchHooks Function()
    >;
typedef $$InsiderTransactionsTableCreateCompanionBuilder =
    InsiderTransactionsCompanion Function({
      Value<int> id,
      required String symbol,
      required String insiderName,
      required String title,
      required String type,
      required double shares,
      required double price,
      required double totalValue,
      required DateTime filingDate,
      required DateTime transactionDate,
    });
typedef $$InsiderTransactionsTableUpdateCompanionBuilder =
    InsiderTransactionsCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> insiderName,
      Value<String> title,
      Value<String> type,
      Value<double> shares,
      Value<double> price,
      Value<double> totalValue,
      Value<DateTime> filingDate,
      Value<DateTime> transactionDate,
    });

class $$InsiderTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $InsiderTransactionsTable> {
  $$InsiderTransactionsTableFilterComposer({
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

  ColumnFilters<String> get insiderName => $composableBuilder(
    column: $table.insiderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
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

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get filingDate => $composableBuilder(
    column: $table.filingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InsiderTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InsiderTransactionsTable> {
  $$InsiderTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get insiderName => $composableBuilder(
    column: $table.insiderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
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

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get filingDate => $composableBuilder(
    column: $table.filingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InsiderTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsiderTransactionsTable> {
  $$InsiderTransactionsTableAnnotationComposer({
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

  GeneratedColumn<String> get insiderName => $composableBuilder(
    column: $table.insiderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get filingDate => $composableBuilder(
    column: $table.filingDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );
}

class $$InsiderTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InsiderTransactionsTable,
          InsiderTransactionData,
          $$InsiderTransactionsTableFilterComposer,
          $$InsiderTransactionsTableOrderingComposer,
          $$InsiderTransactionsTableAnnotationComposer,
          $$InsiderTransactionsTableCreateCompanionBuilder,
          $$InsiderTransactionsTableUpdateCompanionBuilder,
          (
            InsiderTransactionData,
            BaseReferences<
              _$AppDatabase,
              $InsiderTransactionsTable,
              InsiderTransactionData
            >,
          ),
          InsiderTransactionData,
          PrefetchHooks Function()
        > {
  $$InsiderTransactionsTableTableManager(
    _$AppDatabase db,
    $InsiderTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsiderTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsiderTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InsiderTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> insiderName = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> shares = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<DateTime> filingDate = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
              }) => InsiderTransactionsCompanion(
                id: id,
                symbol: symbol,
                insiderName: insiderName,
                title: title,
                type: type,
                shares: shares,
                price: price,
                totalValue: totalValue,
                filingDate: filingDate,
                transactionDate: transactionDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                required String insiderName,
                required String title,
                required String type,
                required double shares,
                required double price,
                required double totalValue,
                required DateTime filingDate,
                required DateTime transactionDate,
              }) => InsiderTransactionsCompanion.insert(
                id: id,
                symbol: symbol,
                insiderName: insiderName,
                title: title,
                type: type,
                shares: shares,
                price: price,
                totalValue: totalValue,
                filingDate: filingDate,
                transactionDate: transactionDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InsiderTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InsiderTransactionsTable,
      InsiderTransactionData,
      $$InsiderTransactionsTableFilterComposer,
      $$InsiderTransactionsTableOrderingComposer,
      $$InsiderTransactionsTableAnnotationComposer,
      $$InsiderTransactionsTableCreateCompanionBuilder,
      $$InsiderTransactionsTableUpdateCompanionBuilder,
      (
        InsiderTransactionData,
        BaseReferences<
          _$AppDatabase,
          $InsiderTransactionsTable,
          InsiderTransactionData
        >,
      ),
      InsiderTransactionData,
      PrefetchHooks Function()
    >;
typedef $$InstitutionalHoldersTableCreateCompanionBuilder =
    InstitutionalHoldersCompanion Function({
      Value<int> id,
      required String symbol,
      required String holderName,
      required double shares,
      required double value,
      required double percentOut,
      required DateTime reportDate,
      Value<double?> change,
    });
typedef $$InstitutionalHoldersTableUpdateCompanionBuilder =
    InstitutionalHoldersCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> holderName,
      Value<double> shares,
      Value<double> value,
      Value<double> percentOut,
      Value<DateTime> reportDate,
      Value<double?> change,
    });

class $$InstitutionalHoldersTableFilterComposer
    extends Composer<_$AppDatabase, $InstitutionalHoldersTable> {
  $$InstitutionalHoldersTableFilterComposer({
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

  ColumnFilters<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentOut => $composableBuilder(
    column: $table.percentOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get change => $composableBuilder(
    column: $table.change,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InstitutionalHoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $InstitutionalHoldersTable> {
  $$InstitutionalHoldersTableOrderingComposer({
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

  ColumnOrderings<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentOut => $composableBuilder(
    column: $table.percentOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get change => $composableBuilder(
    column: $table.change,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstitutionalHoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstitutionalHoldersTable> {
  $$InstitutionalHoldersTableAnnotationComposer({
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

  GeneratedColumn<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get percentOut => $composableBuilder(
    column: $table.percentOut,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get change =>
      $composableBuilder(column: $table.change, builder: (column) => column);
}

class $$InstitutionalHoldersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstitutionalHoldersTable,
          InstitutionalHolderData,
          $$InstitutionalHoldersTableFilterComposer,
          $$InstitutionalHoldersTableOrderingComposer,
          $$InstitutionalHoldersTableAnnotationComposer,
          $$InstitutionalHoldersTableCreateCompanionBuilder,
          $$InstitutionalHoldersTableUpdateCompanionBuilder,
          (
            InstitutionalHolderData,
            BaseReferences<
              _$AppDatabase,
              $InstitutionalHoldersTable,
              InstitutionalHolderData
            >,
          ),
          InstitutionalHolderData,
          PrefetchHooks Function()
        > {
  $$InstitutionalHoldersTableTableManager(
    _$AppDatabase db,
    $InstitutionalHoldersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstitutionalHoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstitutionalHoldersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstitutionalHoldersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> holderName = const Value.absent(),
                Value<double> shares = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<double> percentOut = const Value.absent(),
                Value<DateTime> reportDate = const Value.absent(),
                Value<double?> change = const Value.absent(),
              }) => InstitutionalHoldersCompanion(
                id: id,
                symbol: symbol,
                holderName: holderName,
                shares: shares,
                value: value,
                percentOut: percentOut,
                reportDate: reportDate,
                change: change,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                required String holderName,
                required double shares,
                required double value,
                required double percentOut,
                required DateTime reportDate,
                Value<double?> change = const Value.absent(),
              }) => InstitutionalHoldersCompanion.insert(
                id: id,
                symbol: symbol,
                holderName: holderName,
                shares: shares,
                value: value,
                percentOut: percentOut,
                reportDate: reportDate,
                change: change,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InstitutionalHoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstitutionalHoldersTable,
      InstitutionalHolderData,
      $$InstitutionalHoldersTableFilterComposer,
      $$InstitutionalHoldersTableOrderingComposer,
      $$InstitutionalHoldersTableAnnotationComposer,
      $$InstitutionalHoldersTableCreateCompanionBuilder,
      $$InstitutionalHoldersTableUpdateCompanionBuilder,
      (
        InstitutionalHolderData,
        BaseReferences<
          _$AppDatabase,
          $InstitutionalHoldersTable,
          InstitutionalHolderData
        >,
      ),
      InstitutionalHolderData,
      PrefetchHooks Function()
    >;
typedef $$DiscoveriesTableCreateCompanionBuilder =
    DiscoveriesCompanion Function({
      Value<int> id,
      required String symbol,
      Value<String> companyName,
      required String reason,
      Value<String> strategy,
      required double currentPrice,
      required double confidence,
      Value<DateTime> discoveredAt,
      Value<bool> isPromoted,
      Value<bool> isDismissed,
      Value<double?> potentialUpside,
    });
typedef $$DiscoveriesTableUpdateCompanionBuilder =
    DiscoveriesCompanion Function({
      Value<int> id,
      Value<String> symbol,
      Value<String> companyName,
      Value<String> reason,
      Value<String> strategy,
      Value<double> currentPrice,
      Value<double> confidence,
      Value<DateTime> discoveredAt,
      Value<bool> isPromoted,
      Value<bool> isDismissed,
      Value<double?> potentialUpside,
    });

class $$DiscoveriesTableFilterComposer
    extends Composer<_$AppDatabase, $DiscoveriesTable> {
  $$DiscoveriesTableFilterComposer({
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

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strategy => $composableBuilder(
    column: $table.strategy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get discoveredAt => $composableBuilder(
    column: $table.discoveredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPromoted => $composableBuilder(
    column: $table.isPromoted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get potentialUpside => $composableBuilder(
    column: $table.potentialUpside,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiscoveriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscoveriesTable> {
  $$DiscoveriesTableOrderingComposer({
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

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strategy => $composableBuilder(
    column: $table.strategy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get discoveredAt => $composableBuilder(
    column: $table.discoveredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPromoted => $composableBuilder(
    column: $table.isPromoted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get potentialUpside => $composableBuilder(
    column: $table.potentialUpside,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiscoveriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscoveriesTable> {
  $$DiscoveriesTableAnnotationComposer({
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

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get strategy =>
      $composableBuilder(column: $table.strategy, builder: (column) => column);

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get discoveredAt => $composableBuilder(
    column: $table.discoveredAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPromoted => $composableBuilder(
    column: $table.isPromoted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get potentialUpside => $composableBuilder(
    column: $table.potentialUpside,
    builder: (column) => column,
  );
}

class $$DiscoveriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiscoveriesTable,
          DiscoveryData,
          $$DiscoveriesTableFilterComposer,
          $$DiscoveriesTableOrderingComposer,
          $$DiscoveriesTableAnnotationComposer,
          $$DiscoveriesTableCreateCompanionBuilder,
          $$DiscoveriesTableUpdateCompanionBuilder,
          (
            DiscoveryData,
            BaseReferences<_$AppDatabase, $DiscoveriesTable, DiscoveryData>,
          ),
          DiscoveryData,
          PrefetchHooks Function()
        > {
  $$DiscoveriesTableTableManager(_$AppDatabase db, $DiscoveriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscoveriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscoveriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscoveriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> strategy = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> discoveredAt = const Value.absent(),
                Value<bool> isPromoted = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<double?> potentialUpside = const Value.absent(),
              }) => DiscoveriesCompanion(
                id: id,
                symbol: symbol,
                companyName: companyName,
                reason: reason,
                strategy: strategy,
                currentPrice: currentPrice,
                confidence: confidence,
                discoveredAt: discoveredAt,
                isPromoted: isPromoted,
                isDismissed: isDismissed,
                potentialUpside: potentialUpside,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symbol,
                Value<String> companyName = const Value.absent(),
                required String reason,
                Value<String> strategy = const Value.absent(),
                required double currentPrice,
                required double confidence,
                Value<DateTime> discoveredAt = const Value.absent(),
                Value<bool> isPromoted = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<double?> potentialUpside = const Value.absent(),
              }) => DiscoveriesCompanion.insert(
                id: id,
                symbol: symbol,
                companyName: companyName,
                reason: reason,
                strategy: strategy,
                currentPrice: currentPrice,
                confidence: confidence,
                discoveredAt: discoveredAt,
                isPromoted: isPromoted,
                isDismissed: isDismissed,
                potentialUpside: potentialUpside,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiscoveriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiscoveriesTable,
      DiscoveryData,
      $$DiscoveriesTableFilterComposer,
      $$DiscoveriesTableOrderingComposer,
      $$DiscoveriesTableAnnotationComposer,
      $$DiscoveriesTableCreateCompanionBuilder,
      $$DiscoveriesTableUpdateCompanionBuilder,
      (
        DiscoveryData,
        BaseReferences<_$AppDatabase, $DiscoveriesTable, DiscoveryData>,
      ),
      DiscoveryData,
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
  $$FinancialRatiosTableTableManager get financialRatios =>
      $$FinancialRatiosTableTableManager(_db, _db.financialRatios);
  $$CorporateActionsTableTableManager get corporateActions =>
      $$CorporateActionsTableTableManager(_db, _db.corporateActions);
  $$EarningsEventsTableTableManager get earningsEvents =>
      $$EarningsEventsTableTableManager(_db, _db.earningsEvents);
  $$InsiderTransactionsTableTableManager get insiderTransactions =>
      $$InsiderTransactionsTableTableManager(_db, _db.insiderTransactions);
  $$InstitutionalHoldersTableTableManager get institutionalHolders =>
      $$InstitutionalHoldersTableTableManager(_db, _db.institutionalHolders);
  $$DiscoveriesTableTableManager get discoveries =>
      $$DiscoveriesTableTableManager(_db, _db.discoveries);
}
