// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $permissionCheckRoute,
      $targetSettingsRoute,
      $pedometerRoute,
      $targetResultRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $permissionCheckRoute => GoRouteData.$route(
      path: '/permission',
      factory: $PermissionCheckRouteExtension._fromState,
    );

extension $PermissionCheckRouteExtension on PermissionCheckRoute {
  static PermissionCheckRoute _fromState(GoRouterState state) =>
      PermissionCheckRoute();

  String get location => GoRouteData.$location(
        '/permission',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $targetSettingsRoute => GoRouteData.$route(
      path: '/target-settings',
      factory: $TargetSettingsRouteExtension._fromState,
    );

extension $TargetSettingsRouteExtension on TargetSettingsRoute {
  static TargetSettingsRoute _fromState(GoRouterState state) =>
      TargetSettingsRoute();

  String get location => GoRouteData.$location(
        '/target-settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pedometerRoute => GoRouteData.$route(
      path: '/pedometer',
      factory: $PedometerRouteExtension._fromState,
    );

extension $PedometerRouteExtension on PedometerRoute {
  static PedometerRoute _fromState(GoRouterState state) => PedometerRoute();

  String get location => GoRouteData.$location(
        '/pedometer',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $targetResultRoute => GoRouteData.$route(
      path: '/target-result',
      factory: $TargetResultRouteExtension._fromState,
    );

extension $TargetResultRouteExtension on TargetResultRoute {
  static TargetResultRoute _fromState(GoRouterState state) =>
      TargetResultRoute();

  String get location => GoRouteData.$location(
        '/target-result',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'202f25e6c5234585a02745e1f3251eb530b40a10';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = AutoDisposeProvider<AppRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterRef = AutoDisposeProviderRef<AppRouter>;
String _$appRouterInterceptorHash() =>
    r'31f4433255d4313fa7db6acf926a080d2d5cf5f3';

/// See also [appRouterInterceptor].
@ProviderFor(appRouterInterceptor)
final appRouterInterceptorProvider =
    AutoDisposeProvider<AppRouterInterceptor>.internal(
  appRouterInterceptor,
  name: r'appRouterInterceptorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appRouterInterceptorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterInterceptorRef = AutoDisposeProviderRef<AppRouterInterceptor>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
