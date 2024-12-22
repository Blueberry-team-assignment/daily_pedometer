import 'package:daily_pedometer/common/providers/provider.dart';
import 'package:daily_pedometer/features/permissions/domain/usecases/request_denied_permissions_usecase.dart';
import 'package:daily_pedometer/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer();
  final checkAllPermissionsGrantedUseCase =
      container.read(requestDeniedPermissionUsecaseProvider);

  await checkAllPermissionsGrantedUseCase.execute([
    Permission.location,
    Permission.activityRecognition,
  ]);

  runApp(const ProviderScope(
    child: _App(),
  ));
  FlutterNativeSplash.remove();
}

class _App extends ConsumerWidget {
  const _App();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final lifecycle = ref.watch(appLifecycleNotifierProvider);
    return MaterialApp.router(
      routerConfig: router.config,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
