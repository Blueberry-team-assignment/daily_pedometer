import 'dart:async';

import 'package:daily_pedometer/features/domain/entities/steps_entity.dart';
import 'package:pedometer/pedometer.dart';

class PedometerService {
  static final PedometerService _instance = PedometerService._internal();
  PedometerService._internal();
  factory PedometerService() => _instance;

  StepsEntity _stepsEntity = StepsEntity(
    steps: 0,
    initialSteps: 0,
    targetedSteps: 20000,
    maxSteps: 20000,
  );
  late StreamSubscription<StepCount> _stepCountSubscription;

  /// [초기화]
  Future<void> initialize() async {
    _stepCountSubscription = Pedometer.stepCountStream.listen(onCountSteps);
  }

  /// [dispose]
  void dispose() {
    _stepCountSubscription.cancel();
  }

  /// [현재 상태 반환]
  Future<StepsEntity> getStepStatus() async {
    return _stepsEntity;
  }

  /// [걸음 수 업데이트]
  Future<void> updateSteps(int steps) async {
    _stepsEntity = _stepsEntity.copyWith(
      steps: (_stepsEntity.steps + steps),
    );
  }

  /// [목표 걸음 수 세팅]
  Future<void> setTargetedSteps(int steps) async {
    _stepsEntity = _stepsEntity.copyWith(
      targetedSteps: steps,
    );
  }

  /// [걸음 수 초기화]
  Future<void> resetSteps() async {
    _stepsEntity = _stepsEntity.copyWith(
      steps: 0,
      initialSteps: 0,
    );
  }

  /// [현재 걸음 반환]
  Future<int> getCurrentSteps() async {
    return _stepsEntity.steps;
  }

  /// [목표에 도달했는지 여부 확인]
  Future<bool> checkTargetedReached() async {
    return _stepsEntity.steps >= _stepsEntity.targetedSteps;
  }

  /// [목표 걸음 수 반환]
  Future<int> getTargetedSteps() async {
    return _stepsEntity.targetedSteps;
  }

  /// [목표 걸음 수 까지 남은 걸음 수 반환]
  Future<int> getRemainingSteps() async {
    return (_stepsEntity.targetedSteps - _stepsEntity.steps)
        .clamp(0, _stepsEntity.targetedSteps);
  }

  /// [걸음 결과 처리]
  Future<bool> getResult() async {
    if (await checkTargetedReached()) {
      return true;
    }
    return false;
  }

  /// [초기 걸음 수 변경]
  Future<void> updateInitialSteps(int steps) async {
    _stepsEntity = _stepsEntity.copyWith(
      initialSteps: steps,
    );
  }

  /// [걸음 수 변경 리스너]
  void onCountSteps(StepCount event) async {
    if (_stepsEntity.initialSteps == -1) {
      updateInitialSteps(event.steps - _stepsEntity.steps);

      if (_stepsEntity.initialSteps < 0) {
        updateInitialSteps(0);
      }
      return;
    }

    int newSteps = event.steps - _stepsEntity.initialSteps;

    if (newSteps < 0) {
      newSteps = 0;
    }

    if (_stepsEntity.steps > _stepsEntity.maxSteps) {
      updateSteps(_stepsEntity.maxSteps);
    } else {
      updateSteps(newSteps);
    }

    /// MethodChannel 필요
    /// DB에 걸음 수 저장
  }
}
