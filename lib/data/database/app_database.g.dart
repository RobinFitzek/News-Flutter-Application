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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $ApiKeysTable apiKeys = $ApiKeysTable(this);
  late final $WatchlistItemsTable watchlistItems = $WatchlistItemsTable(this);
  late final $StockCacheTable stockCache = $StockCacheTable(this);
  late final Index idxWatchlistSymbol = Index(
    'idx_watchlist_symbol',
    'CREATE INDEX idx_watchlist_symbol ON watchlist_items (symbol)',
  );
  late final Index idxCacheSymbol = Index(
    'idx_cache_symbol',
    'CREATE UNIQUE INDEX idx_cache_symbol ON stock_cache (symbol)',
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
    idxWatchlistSymbol,
    idxCacheSymbol,
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
}
