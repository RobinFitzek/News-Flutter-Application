import 'package:freezed_annotation/freezed_annotation.dart';

part 'stage_assignment.freezed.dart';
part 'stage_assignment.g.dart';

@freezed
class StageAssignment with _$StageAssignment {
  const factory StageAssignment({
    int? id,
    required AnalysisStage stage,
    required int providerId,
  }) = _StageAssignment;

  factory StageAssignment.fromJson(Map<String, dynamic> json) =>
      _$StageAssignmentFromJson(json);
}

enum AnalysisStage { newsResearch, finalAnalysis }
