import 'package:daily_pedometer/features/permissions/domain/entities/permission_state.dart';
import 'package:daily_pedometer/features/permissions/services/permission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionNotifierProvider =
    StateNotifierProvider<PermissionNotifier, PermissionState>(
  (ref) {
    final service = ref.watch(permissionServiceProvider);
    return PermissionNotifier(service);
  },
);

class PermissionNotifier extends StateNotifier<PermissionState> {
  final PermissionService _service;
  PermissionNotifier(this._service)
      : super(
          PermissionState.initial(),
        );

  Future<void> checkPermissions(List<Permission> permissions) async {
    state = state.copyWith(isLoading: true);

    final denied = <Permission>[];
    for (var permission in permissions) {
      final isGranted = await _service.isPermissionGranted(permission);
      if (!isGranted) {
        denied.add(permission);
      }
    }

    final allGranted = denied.isEmpty;

    state = state.copyWith(
      allPermissionsGranted: allGranted,
      deniedPermissions: denied,
      isLoading: false,
    );
  }

  Future<void> openSettingsIfNecessary(Permission permission) async {
    await _service.goAppSettings(permission);
    await checkPermissions([permission]);
  }

  Future<void> requestPermissions(List<Permission> permissions) async {
    state = state.copyWith(isLoading: true);

    await _service.requestDeniedPermissions(permissions);
    await checkPermissions(permissions);
  }
}
