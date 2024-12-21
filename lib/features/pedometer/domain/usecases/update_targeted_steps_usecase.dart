import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateTargetedStepsUsecaseProvider = Provider(
  (ref) => UpdateTargetedStepsUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class UpdateTargetedStepsUsecase {
  final PedometerRepository repository;

  UpdateTargetedStepsUsecase(this.repository);

  Future<void> execute(int steps) async {
    await repository.updateTargetedSteps(steps);
  }
}
