import 'dart:developer';

import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/common/providers/provider.dart';
import 'package:daily_pedometer/common/styles/app_theme.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/features/permissions/domain/usecases/request_denied_permissions_usecase.dart';
import 'package:daily_pedometer/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:background_fetch/background_fetch.dart';

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
  initializeBackgroundFetch();
  FlutterNativeSplash.remove();
}

class _App extends ConsumerStatefulWidget {
  const _App();

  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      final theme = ref.watch(themeNotifierProviderProvider);
      final lifecycle = ref.watch(appLifecycleNotifierProvider);
      _updateSystemNavigationBarColor(theme);
    });
  }

  void _updateSystemNavigationBarColor(ThemeMode theme) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness:
            theme == ThemeMode.light ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeNotifierProviderProvider);
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
      theme: AppTheme().createTheme(
        brightness:
            theme == ThemeMode.light ? Brightness.light : Brightness.dark,
      ),
    );
  }
}

void initializeBackgroundFetch() {
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 15, // 최소 15분 간격
      stopOnTerminate: false,
      enableHeadless: true,
      startOnBoot: true,
    ),
    onFetch,
  ).then((int status) {
    log('[BackgroundFetch] Configured: $status');
  }).catchError((e) {
    log('[BackgroundFetch] ERROR: $e');
  });

  // iOS 및 Android 헤드리스 작업 등록
  BackgroundFetch.registerHeadlessTask(onFetch);
}

Future<void> onFetch(String taskId) async {
  print('[BackgroundFetch] Event received: $taskId');

  // reset 메소드 실행
  await reset();

  // 작업 완료 알림
  BackgroundFetch.finish(taskId);
}

// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   log("[BackgroundFetch] Headless event received: ${task.taskId}");

//   if (task.taskId == taskID) {
//     await reset();
//     BackgroundFetch.finish(task.taskId);
//   }
// }

Future<void> reset() async {
  final container = ProviderContainer();
  final storage = container.read(storageProvider);

  /// 초기화
  try {
    await storage.set(key: stepsKey, data: 0);
    await platform.invokeMethod('updateService', {
      'steps': 0,
    });
  } catch (err) {
    log('[Error]: $err');
  }
}
