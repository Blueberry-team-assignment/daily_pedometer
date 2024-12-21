import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateInitialStepsUsecaseProvider = Provider(
  (ref) => UpdateInitialStepsUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class UpdateInitialStepsUsecase {
  final PedometerRepository repository;

  UpdateInitialStepsUsecase(this.repository);

  Future<void> execute(int steps) async {
    await repository.updateInitialSteps(steps);
  }
}
