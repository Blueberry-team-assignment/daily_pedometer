import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/externals/storage/storage_service.dart';
import 'package:daily_pedometer/features/pedometer/domain/entities/steps_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stepsEntityNotifierProvider =
    StateNotifierProvider<StepsNotifier, StepsEntity?>((ref) {
  final storage = ref.read(storageProvider);
  return StepsNotifier(storage);
});

class StepsNotifier extends StateNotifier<StepsEntity?> {
  final StorageService _storage;
  StepsNotifier(this._storage) : super(null);

  Future<void> initialize() async {
    final steps = await _storage.get(key: stepsKey) ?? 0;
    final initialSteps = await _storage.get(key: initialStepsKey) ?? -1;
    final targetedSteps = await _storage.get(key: targetedStepsKey) ?? 0;
    final maxSteps = await _storage.get(key: maxStepsKey) ?? 20000;

    state = StepsEntity(
      steps: steps,
      initialSteps: initialSteps,
      targetedSteps: targetedSteps,
      maxSteps: maxSteps,
    );
  }

  int getTargetedSteps() {
    return state?.targetedSteps ?? 0;
  }
}
