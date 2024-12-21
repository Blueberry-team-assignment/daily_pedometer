import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final checkTargetedReachedUsecaseProvider = Provider(
  (ref) => CheckTargetedReachedUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class CheckTargetedReachedUsecase {
  final PedometerRepository repository;

  CheckTargetedReachedUsecase(this.repository);

  bool execute() {
    return repository.checkTargetedReached();
  }
}
