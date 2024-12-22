part of 'router.dart';

abstract class Route extends GoRouteData {
  final Widget body;
  const Route({
    required this.body,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return body;
  }
}

/// 앱 내 사용할 라우트 명명
class AppRoutes {
  AppRoutes._();

  /// [스플래시]
  static const String splash = "/splash";

  /// [권한 체크]
  static const String permission = "/permission";

  /// [설정: 목표 설정 및 세부 앱 설정]
  static const String targetSettings = "/target-settings";

  /// [걷기 화면 -- 메인 화면]
  static const String pedometer = "/pedometer";

  /// [하루 걷기 완료 후 결과 페이지]
  static const String targetResult = "/target-result";
}

class NavigatorKey {
  NavigatorKey._();

  static final routerKey = GlobalKey<NavigatorState>(debugLabel: 'router_key');
}

@TypedGoRoute<SplashRoute>(path: AppRoutes.splash)
class SplashRoute extends Route {
  SplashRoute() : super(body: const SplashScreen());
}

@TypedGoRoute<PermissionCheckRoute>(path: AppRoutes.permission)
class PermissionCheckRoute extends Route {
  PermissionCheckRoute() : super(body: const PermissionCheckScreen());
}

@TypedGoRoute<TargetSettingsRoute>(path: AppRoutes.targetSettings)
class TargetSettingsRoute extends Route {
  TargetSettingsRoute() : super(body: const TargetSettingsScreen());
}

@TypedGoRoute<PedometerRoute>(path: AppRoutes.pedometer)
class PedometerRoute extends Route {
  PedometerRoute() : super(body: const PedometerScreen());
}

@TypedGoRoute<TargetResultRoute>(path: AppRoutes.targetResult)
class TargetResultRoute extends Route {
  TargetResultRoute() : super(body: const TargetResultScreen());
}
