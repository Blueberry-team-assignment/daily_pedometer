import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/entities/steps_entity.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getStepStatusUsecaseProvider = Provider(
  (ref) => GetStepStatusUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class GetStepStatusUsecase {
  final PedometerRepository repository;

  GetStepStatusUsecase(this.repository);

  StepsEntity execute() {
    return repository.getStepStatus();
  }
}
