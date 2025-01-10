import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/repositories/pedometer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getResultUsecaseProvider = Provider(
  (ref) => GetResultUsecase(
    ref.watch(pedometerRepositoryProvider),
  ),
);

class GetResultUsecase {
  final PedometerRepository repository;

  GetResultUsecase(this.repository);

  bool execute() {
    return repository.getResult();
  }
}
