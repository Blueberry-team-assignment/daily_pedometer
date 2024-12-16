import 'package:daily_pedometer/common/providers/provider.dart';
import 'package:daily_pedometer/features/domain/providers/permission_usecase_provider.dart';
import 'package:daily_pedometer/features/presentation/screens/pedometer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer();
  final checkAllPermissionsGrantedUseCase =
      container.read(requestDeniedPermissionsUsecaseProvider);

  await checkAllPermissionsGrantedUseCase.execute([
    Permission.location,
    Permission.activityRecognition,
  ]);

  runApp(const ProviderScope(
    child: MyApp(),
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifecycle = ref.watch(appLifecycleNotifierProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(body: PedometerScreen()),
    );
  }
}
