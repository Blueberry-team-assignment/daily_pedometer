part of 'provider.dart';

@riverpod
class StepsNotifierProvider extends _$StepsNotifierProvider {
  // static const _stepChannel = EventChannel("com.ejapp.daily_pedometer");
  static const platform = EventChannel("com.ejapp.daily_pedometer");

  @override
  Future<int> build() async {
    log("state: $state");
    final initialSteps = await _loadSteps();
    // _listenToSteps();
    return initialSteps;
  }

  /// 로컬 데이터 로드
  Future<int> _loadSteps() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSteps = prefs.getInt(stepsKey) ?? 0;
    return savedSteps;
  }

  /// 로컬 데이터 저장
  Future<void> _saveSteps(int steps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("steps", steps);
  }

  /// EventChannel 데이터 수신
  // void _listenToSteps() {
  //   _stepChannel.receiveBroadcastStream().listen((event) async {
  //     final newSteps = event as int;
  //     log("---> 네이티브에서 불러오는 걸음: $newSteps");

  //     if (state is AsyncData<int>) {
  //       final currentStep = state.value ?? 0;
  //       if (newSteps > currentStep) {
  //         state = AsyncData(newSteps);
  //         await _saveSteps(newSteps);
  //       }
  //     }
  //   }, onError: (error) {
  //     log('Error: $error');
  //   });
  // }
}
