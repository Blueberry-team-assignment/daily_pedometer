import 'dart:convert';

class StepsEntity {
  /// [현재 걸음 수]
  final int steps;

  /// [총 걸음 수 - 초기화 시킬 걸음 수]
  final int? initialSteps;

  /// [목표 걸음 수]
  final int targetedSteps;

  StepsEntity({
    required this.steps,
    this.initialSteps,
    required this.targetedSteps,
  });

  StepsEntity copyWith({
    int? steps,
    int? initialSteps,
    int? targetedSteps,
  }) =>
      StepsEntity(
        steps: steps ?? this.steps,
        initialSteps: initialSteps ?? this.initialSteps,
        targetedSteps: targetedSteps ?? this.targetedSteps,
      );

  factory StepsEntity.fromRawJson(String str) =>
      StepsEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StepsEntity.fromJson(Map<String, dynamic> json) => StepsEntity(
        steps: json["steps"],
        initialSteps: json["initialSteps"],
        targetedSteps: json["targetedSteps"],
      );

  Map<String, dynamic> toJson() => {
        "steps": steps,
        "initialSteps": initialSteps,
        "targetedSteps": targetedSteps,
      };
}
