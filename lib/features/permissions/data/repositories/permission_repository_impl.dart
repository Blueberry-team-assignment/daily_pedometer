import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/externals/storage/storage_service.dart';
import 'package:daily_pedometer/features/permissions/services/permission_service.dart';
import 'package:daily_pedometer/features/permissions/domain/repositories/permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionRepositoryProvider = Provider((ref) {
  final service = ref.watch(permissionServiceProvider);
  final storage = ref.watch(storageProvider);
  final repository = PermissionRepositoryImpl(service, storage);
  return repository;
});

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionService _service;
  final StorageService storage;

  PermissionRepositoryImpl(this._service, this.storage);

  @override
  Future<bool> checkPermission(Permission permission) async {
    final status = await _service.getPermissionStatus(permission);
    return status.isGranted;
  }

  @override
  Future<void> requestPermission(Permission permission) async {
    await _service.requestPermission(permission);
  }

  @override
  Future<bool> checkAllPermissionsGranted(List<Permission> permissions) async {
    return await _service.checkAllPermissionsGranted(permissions);
  }

  @override
  Future<void> requestDeniedPermissions(List<Permission> permissions) async {
    await _service.requestDeniedPermissions(permissions);
  }
}
