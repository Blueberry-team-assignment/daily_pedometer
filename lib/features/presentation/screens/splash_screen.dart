import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/features/permissions/domain/notifiers/permission_notifier.dart';
import 'package:daily_pedometer/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(permissionNotifierProvider);
    final notifier = ref.read(permissionNotifierProvider.notifier);
    final storage = ref.read(storageProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final firstTime = await storage.get(key: isFirstTime) ?? true;
      if (context.mounted) {
        if (firstTime) {
          if (permissionState.allPermissionsGranted) {
            await storage.set(key: isFirstTime, data: false);
            context.pushReplacement(AppRoutes.targetSettings);
          } else {
            await notifier.requestPermissions([
              Permission.location,
              Permission.activityRecognition,
            ]);
          }
        } else {
          context.pushReplacement(AppRoutes.targetSettings);
        }
      }
    });

    return Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
