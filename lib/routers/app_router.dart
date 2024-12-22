part of 'router.dart';

@riverpod
AppRouter appRouter(Ref ref) {
  final interceptor = ref.read(appRouterInterceptorProvider);
  return AppRouter(interceptor);
}

class AppRouter {
  final AppRouterInterceptor interceptor;
  AppRouter(this.interceptor);
  late final config = GoRouter(
    initialLocation: AppRoutes.pedometer,
    routes: $appRoutes,
    debugLogDiagnostics: true,
    navigatorKey: NavigatorKey.routerKey,
    redirect: (context, state) async {
      final String? result = await interceptor.canGo(context, state);
      return result;
    },
  );
}
