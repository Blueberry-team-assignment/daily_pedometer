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
    bool isFirstTime = await storage.get(key: 'isFistTime') ?? false;

    if (!isFirstTime && state.fullPath != AppRoutes.permission) {
      return AppRoutes.targetSettings;
    }
    return null;
  }
}
