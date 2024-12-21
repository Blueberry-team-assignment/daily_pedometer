import 'dart:async';

import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/features/pedometer/domain/entities/steps_entity.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:daily_pedometer/features/pedometer/services/pedometer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final pedometerRepositoryProvider = Provider((ref) {
  final service = ref.watch(pedometerServiceProvider);
  final repository = PedometerRepositoryImpl(service, ref);
  ref.onDispose(() => repository.dispose());
  return repository;
});

class PedometerRepositoryImpl implements PedometerRepository {
  final PedometerService _service;
  final Ref ref;
  late StreamSubscription<StepCount> _stepCountSubscription;

  StepsEntity _stepsEntity = StepsEntity(
    steps: 0,
    initialSteps: 0,
    targetedSteps: 20000,
    maxSteps: 20000,
  );

  PedometerRepositoryImpl(this._service, this.ref);

  @override
  Future<void> initialize() async {
    _stepCountSubscription = _service.stepCountStream.listen(_onCountSteps);
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
  }

  @override
  StepsEntity getStepStatus() {
    return _stepsEntity;
  }

  @override
  int getCurrentSteps() {
    return _stepsEntity.steps;
  }

  @override
  int getTargetedSteps() {
    return _stepsEntity.targetedSteps;
  }

  @override
  int getRemainingSteps() {
    return (_stepsEntity.targetedSteps - _stepsEntity.steps)
        .clamp(0, _stepsEntity.targetedSteps);
  }

  @override
  Future<bool> getResult() async {
    if (checkTargetedReached()) {
      return true;
    }
    return false;
  }

  @override
  Future<void> updateSteps(int steps) async {
    _stepsEntity = _stepsEntity.copyWith(
      steps: (_stepsEntity.steps + steps),
    );
  }

  @override
  Future<void> updateInitialSteps(int steps) async {
    _stepsEntity = _stepsEntity.copyWith(
      initialSteps: steps,
    );
  }

  @override
  Future<void> updateTargetedSteps(int steps) async {
    _stepsEntity = _stepsEntity.copyWith(
      targetedSteps: steps,
    );
  }

  @override
  bool checkTargetedReached() {
    return _stepsEntity.steps >= _stepsEntity.targetedSteps;
  }

  @override
  void resetSteps() {
    _stepsEntity = _stepsEntity.copyWith(
      steps: 0,
      initialSteps: 0,
    );
  }

  void _onCountSteps(StepCount event) async {
    final storage = ref.read(storageProvider);
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
    await storage.set(key: stepsKey, data: newSteps);
  }
}
