import 'package:daily_pedometer/features/domain/entities/steps_entity.dart';
import 'package:pedometer/pedometer.dart';

abstract class PedometerRepository {
  /// [init]
  Future<void> initialize();

  /// [Dispose]
  void dispose();

  /// 현재 상태 반환
  Future<StepsEntity> getStepStatus();

  /// 현재 걸음 수 반환
  Future<int> getCurrentSteps();

  /// 걸음 수 업데이트
  Future<void> updateSteps(int steps);

  /// 초깃값 업데이트
  Future<void> updateInitialSteps(int steps);

  /// 목표 걸음 수 반환
  Future<int> getTargetedSteps();

  /// 목표 걸음 수 설정
  Future<void> setTargetedSteps(int steps);

  /// 목표 걸음 수까지 남은 걸음 수 반환
  Future<int> getRemainingSteps();

  /// 목표 도달 여부 확인
  Future<bool> checkTargetedReached();

  /// 목표 도달 시 결과 처리
  Future<bool> getResult();

  /// 걸음 수 초기화
  Future<void> resetSteps();

  /// 걸음 수 변경 리스너
  void onCountSteps(StepCount event);
}
