import 'dart:async';
import 'dart:developer';

import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/externals/storage/storage_service.dart';
import 'package:daily_pedometer/features/pedometer/domain/entities/steps_entity.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:daily_pedometer/features/pedometer/services/pedometer_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final stepsEntityProvider = FutureProvider<StepsEntity>((ref) async {
  final storage = ref.read(storageProvider);

  final steps = await storage.get(key: stepsKey) ?? 0;
  final initialSteps = await storage.get(key: initialStepsKey) ?? -1;
  final targetedSteps = await storage.get(key: targetedStepsKey) ?? 0;
  final maxSteps = await storage.get(key: maxStepsKey) ?? 20000;

  return StepsEntity(
    steps: steps,
    initialSteps: initialSteps,
    targetedSteps: targetedSteps,
    maxSteps: maxSteps,
  );
});

final pedometerRepositoryProvider = Provider((ref) {
  final service = ref.watch(pedometerServiceProvider);
  final storage = ref.watch(storageProvider);
  // final entity = ref.watch(stepsEntityProvider).value;
  // if (entity == null) {
  //   throw Exception('StepsEntity not initialized');
  // }
  // final repository = PedometerRepositoryImpl(service, storage, entity);
  // ref.onDispose(() => repository.dispose());
  // return repository;
  final stepsEntityAsync = ref.watch(stepsEntityProvider);

  return stepsEntityAsync.when(
    data: (entity) {
      final repository = PedometerRepositoryImpl(service, storage, entity);
      ref.onDispose(() => repository.dispose());
      return repository;
    },
    loading: () => throw Exception('StepsEntity is loading'),
    error: (error, stackTrace) => throw Exception('StepsEntity failed to load'),
  );
});

final pedometerInitializationProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(pedometerRepositoryProvider);
  await repository.initialize();

  ref.watch(stepCountSubscriptionProvider);
});

final stepCountSubscriptionProvider =
    Provider<StreamSubscription<StepCount>>((ref) {
  final pedometerService = ref.watch(pedometerServiceProvider);

  final subscription = pedometerService.stepCountStream.listen((event) {
    ref.read(pedometerRepositoryProvider).onCountSteps(event);
  });

  ref.onDispose(() => subscription.cancel());

  return subscription;
});

final stepCountStreamProvider = StreamProvider<int>((ref) {
  final repository = ref.watch(pedometerRepositoryProvider);
  return repository.stepcountStream;
});

class PedometerRepositoryImpl implements PedometerRepository {
  final PedometerService _service;
  // final Ref ref;
  final StorageService storage;
  late StreamSubscription<StepCount> _stepCountSubscription;

  // StepsEntity _stepsEntity = StepsEntity(
  //   steps: 0,
  //   initialSteps: -1,
  //   targetedSteps: 20000,
  //   maxSteps: 20000,
  // );
  StepsEntity _stepsEntity;

  late final Stream<int> stepcountStream =
      _service.stepCountStream.map((event) {
    final newSteps = event.steps - _stepsEntity.initialSteps;

    if (newSteps < 0) return 0;

    onCountSteps(event);

    return newSteps.clamp(0, _stepsEntity.maxSteps);
  });

  PedometerRepositoryImpl(
    this._service,
    this.storage,
    this._stepsEntity,
  );

  @override
  Future<void> initialize() async {
    _stepCountSubscription = _service.stepCountStream.listen(onCountSteps);
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
      steps: steps,
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

    log("---> 목표 걸음 수가 변경됨: ${_stepsEntity.targetedSteps}");
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
    log('---> initialSteps: ${_stepsEntity.initialSteps}');
    log('---> pedometerRepository: $newSteps');

    /// MethodChannel 필요
    updateNativeService(newSteps);

    /// DB에 걸음 수 저장
    await storage.set(key: initialStepsKey, data: _stepsEntity.initialSteps);
    await storage.set(key: stepsKey, data: newSteps);
  }

  /// MethodChannel
  Future<void> updateNativeService(int steps) async {
    try {
      await platform.invokeMethod('updateService', {
        'steps': steps,
      });
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
    }
  }
}
