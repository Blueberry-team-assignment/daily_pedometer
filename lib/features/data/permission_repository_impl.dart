import 'package:daily_pedometer/features/data/permission_service.dart';
import 'package:daily_pedometer/features/domain/repositories/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionService _permissionService;

  PermissionRepositoryImpl(this._permissionService);

  @override
  Future<bool> checkPermission(Permission permission) async {
    final status = await _permissionService.getPermissionStatus(permission);
    return status.isGranted;
  }

  @override
  Future<void> requestPermission(Permission permission) async {
    await _permissionService.requestPermission(permission);
  }

  @override
  Future<bool> checkAllPermissionsGranted(List<Permission> permissions) async {
    return await _permissionService.checkAllPermissionsGranted(permissions);
  }

  @override
  Future<void> requestDeniedPermissions(List<Permission> permissions) async {
    await _permissionService.requestDeniedPermissions(permissions);
  }
}
