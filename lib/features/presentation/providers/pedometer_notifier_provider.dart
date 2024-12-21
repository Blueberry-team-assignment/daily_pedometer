part of 'provider.dart';

@riverpod
class PedometerNotifierProvider extends _$PedometerNotifierProvider {
  @override
  void build() {
    // state = StepsEntity(
    //   steps: steps,
    //   initialSteps: initialSteps,
    //   targetedSteps: targetedSteps,
    // );
  }

  /// 로컬 DB에서 데이터 로드
  Future<int> _loadSteps() async {
    final storage = ref.read(storageProvider);
    final savedStetps = await storage.get(key: stepsKey);
    return savedStetps;
  }

  /// 로컬 DB에 걸음 수 저장
  Future<void> saveSteps(int steps) async {
    final storage = ref.read(storageProvider);
    await storage.set(key: stepsKey, data: steps);
  }
}
