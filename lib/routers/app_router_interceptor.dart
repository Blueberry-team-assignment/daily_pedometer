part of 'router.dart';

@riverpod
AppRouterInterceptor appRouterInterceptor(Ref ref) => AppRouterInterceptorImpl(
      ref.read(storageProvider),
    );

abstract class AppRouterInterceptor {
  FutureOr<String?> canGo(BuildContext context, GoRouterState state);
}

class AppRouterInterceptorImpl implements AppRouterInterceptor {
  // final Ref ref;
  final StorageService storage;

  AppRouterInterceptorImpl(this.storage);

  @override
  FutureOr<String?> canGo(BuildContext context, GoRouterState state) async {
    // if (state.fullPath )
    /// 최초 방문
    bool firstTime = await storage.get(key: isFirstTime) ?? true;
    bool reset = await storage.get(key: resetTime) ?? false;

    /// 리셋된 후에 이 화면으로 이동
    if (reset) {
      await storage.set(key: resetTime, data: false);
      return AppRoutes.targetResult;
    }

    if (!firstTime) {
      return AppRoutes.targetSettings;
    }
    return null;
  }
}
