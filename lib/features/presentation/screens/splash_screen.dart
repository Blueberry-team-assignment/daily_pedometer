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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (context.mounted) {
        if (permissionState.allPermissionsGranted) {
          context.pushReplacement(AppRoutes.targetSettings);
        } else {
          await notifier.requestPermissions([
            Permission.location,
            Permission.activityRecognition,
          ]);
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
