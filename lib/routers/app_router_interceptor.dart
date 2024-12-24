part of 'router.dart';

@riverpod
AppRouterInterceptor appRouterInterceptor(Ref ref) =>
    AppRouterInterceptorImpl(ref);

abstract class AppRouterInterceptor {
  FutureOr<String?> canGo(BuildContext context, GoRouterState state);
}

class AppRouterInterceptorImpl implements AppRouterInterceptor {
  final Ref ref;

  AppRouterInterceptorImpl(this.ref);

  @override
  FutureOr<String?> canGo(BuildContext context, GoRouterState state) async {
    // if (state.fullPath )
    final storage = ref.read(storageProvider);

    /// 최초 방문
    bool isFirstTime = await storage.get(key: 'isFistTime') ?? false;

    if (!isFirstTime && state.fullPath != AppRoutes.permission) {
      return AppRoutes.pedometer;
    }
    return null;
  }
}
