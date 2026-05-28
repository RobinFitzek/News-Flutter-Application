// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StageAssignmentImpl _$$StageAssignmentImplFromJson(
  Map<String, dynamic> json,
) => _$StageAssignmentImpl(
  id: (json['id'] as num?)?.toInt(),
  stage: $enumDecode(_$AnalysisStageEnumMap, json['stage']),
  providerId: (json['providerId'] as num).toInt(),
);

Map<String, dynamic> _$$StageAssignmentImplToJson(
  _$StageAssignmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'stage': _$AnalysisStageEnumMap[instance.stage]!,
  'providerId': instance.providerId,
};

const _$AnalysisStageEnumMap = {
  AnalysisStage.newsResearch: 'newsResearch',
  AnalysisStage.finalAnalysis: 'finalAnalysis',
};
