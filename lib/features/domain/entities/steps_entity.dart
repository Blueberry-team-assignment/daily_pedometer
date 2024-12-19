import 'dart:convert';

class StepsEntity {
  /// [현재 걸음 수]
  final int steps;

  /// [총 걸음 수 - 초기화 시킬 걸음 수]
  final int initialSteps;

  /// [목표 걸음 수]
  final int targetedSteps;

  final int maxSteps;

  StepsEntity({
    required this.steps,
    required this.initialSteps,
    required this.targetedSteps,
    this.maxSteps = 50000,
  });

  StepsEntity copyWith({
    int? steps,
    int? initialSteps,
    int? targetedSteps,
    int? maxSteps,
  }) =>
      StepsEntity(
        steps: steps ?? this.steps,
        initialSteps: initialSteps ?? this.initialSteps,
        targetedSteps: targetedSteps ?? this.targetedSteps,
        maxSteps: maxSteps ?? this.maxSteps,
      );

  factory StepsEntity.fromRawJson(String str) =>
      StepsEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StepsEntity.fromJson(Map<String, dynamic> json) => StepsEntity(
        steps: json["steps"],
        initialSteps: json["initialSteps"],
        targetedSteps: json["targetedSteps"],
        maxSteps: json["maxSteps"],
      );

  Map<String, dynamic> toJson() => {
        "steps": steps,
        "initialSteps": initialSteps,
        "targetedSteps": targetedSteps,
        "maxSteps": maxSteps,
      };
}
