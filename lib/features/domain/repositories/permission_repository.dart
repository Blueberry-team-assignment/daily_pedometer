import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRepository {
  ///
  Future<bool> checkPermission(Permission permission);

  /// []
  Future<void> requestPermission(Permission permission);

  ///
  Future<bool> checkAllPermissionsGranted(List<Permission> permissions);

  ///
  Future<void> requestDeniedPermissions(List<Permission> permissions);
}
