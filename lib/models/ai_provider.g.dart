// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiProviderImpl _$$AiProviderImplFromJson(Map<String, dynamic> json) =>
    _$AiProviderImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      type: $enumDecode(_$ProviderTypeEnumMap, json['type']),
      baseUrl: json['baseUrl'] as String,
      apiKey: json['apiKey'] as String,
      model: json['model'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      isConnected: json['isConnected'] as bool? ?? false,
      totalCalls: (json['totalCalls'] as num?)?.toInt() ?? 0,
      totalCost: (json['totalCost'] as num?)?.toDouble() ?? 0.0,
      lastTestedAt: json['lastTestedAt'] == null
          ? null
          : DateTime.parse(json['lastTestedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AiProviderImplToJson(_$AiProviderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ProviderTypeEnumMap[instance.type]!,
      'baseUrl': instance.baseUrl,
      'apiKey': instance.apiKey,
      'model': instance.model,
      'isEnabled': instance.isEnabled,
      'isConnected': instance.isConnected,
      'totalCalls': instance.totalCalls,
      'totalCost': instance.totalCost,
      'lastTestedAt': instance.lastTestedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ProviderTypeEnumMap = {
  ProviderType.gemini: 'gemini',
  ProviderType.perplexity: 'perplexity',
  ProviderType.openai: 'openai',
  ProviderType.claude: 'claude',
  ProviderType.custom: 'custom',
  ProviderType.ollama: 'ollama',
};
