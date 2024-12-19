import 'dart:async';

import 'package:daily_pedometer/features/domain/entities/steps_entity.dart';
import 'package:daily_pedometer/features/domain/repositories/pedometer_repository.dart';
import 'package:daily_pedometer/features/domain/services/pedometer_service.dart';
import 'package:pedometer/pedometer.dart';

class PedometerRepositoryImpl implements PedometerRepository {
  final PedometerService _pedometerService;

  PedometerRepositoryImpl(this._pedometerService);

  @override
  Future<void> initialize() async {
    await _pedometerService.initialize();
  }

  @override
  void dispose() {
    _pedometerService.dispose();
  }

  @override
  Future<StepsEntity> getStepStatus() async {
    return _pedometerService.getStepStatus();
  }

  @override
  Future<void> updateSteps(int steps) async {
    await _pedometerService.updateSteps(steps);
  }

  @override
  Future<void> setTargetedSteps(int steps) async {
    await _pedometerService.setTargetedSteps(steps);
  }

  @override
  Future<bool> checkTargetedReached() {
    return _pedometerService.checkTargetedReached();
  }

  @override
  Future<int> getCurrentSteps() {
    return _pedometerService.getCurrentSteps();
  }

  @override
  Future<int> getTargetedSteps() {
    return _pedometerService.getTargetedSteps();
  }

  @override
  Future<int> getRemainingSteps() {
    return _pedometerService.getRemainingSteps();
  }

  @override
  Future<bool> getResult() {
    return _pedometerService.getResult();
  }

  @override
  void onCountSteps(StepCount event) {
    _pedometerService.onCountSteps(event);
  }

  @override
  Future<void> resetSteps() async {
    await _pedometerService.resetSteps();
  }

  @override
  Future<void> updateInitialSteps(int steps) async {
    await _pedometerService.updateInitialSteps(steps);
  }
}
