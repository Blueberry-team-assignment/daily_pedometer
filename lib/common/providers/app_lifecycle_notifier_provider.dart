part of 'provider.dart';

final appLifecycleNotifierProvider =
    StateNotifierProvider<AppLifecycleNotifierProvider, AppLifecycleState>(
        (_) => AppLifecycleNotifierProvider());

class AppLifecycleNotifierProvider extends StateNotifier<AppLifecycleState>
    with WidgetsBindingObserver {
  AppLifecycleNotifierProvider() : super(AppLifecycleState.resumed) {
    WidgetsBinding.instance.addObserver(this);
  }

  static const platform = MethodChannel('com.ejapp.daily_pedometer');

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// 앱이 완전히 종료되었을 때
    if (state == AppLifecycleState.detached) {
      _startNativeStepService();
    }

    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        log('AppLifecycleState: $state');
        break;
    }
  }

  Future<void> _startNativeStepService() async {
    await platform.invokeListMethod('startService');
  }
}
