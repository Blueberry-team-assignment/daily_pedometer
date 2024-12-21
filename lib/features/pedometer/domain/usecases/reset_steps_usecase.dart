import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final resetStepsUsecaseProvider = Provider(
  (ref) => ResetStepsUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class ResetStepsUsecase {
  final PedometerRepository repository;

  ResetStepsUsecase(this.repository);

  void execute() {
    repository.resetSteps();
  }
}
