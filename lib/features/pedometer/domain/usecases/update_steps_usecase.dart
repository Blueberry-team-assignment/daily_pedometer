import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateStepsUsecaseProvider = Provider(
  (ref) => UpdateStepsUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class UpdateStepsUsecase {
  final PedometerRepository repository;

  UpdateStepsUsecase(this.repository);

  Future<void> execute(int steps) async {
    await repository.updateSteps(steps);
  }
}
