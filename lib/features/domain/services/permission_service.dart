import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();

  PermissionService._internal();

  factory PermissionService() => _instance;

  /// [특정 권한의 상태를 반환]
  Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  /// [특정 권한을 요청]
  Future<void> requestPermission(Permission permission) async {
    await permission.request();
  }

  /// [특정 권한이 허용되었는지 확인]
  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// [리스트의 모든 권한이 허용되었는지 확인]
  Future<bool> checkAllPermissionsGranted(List<Permission> permissions) async {
    for (var permission in permissions) {
      if (!await isPermissionGranted(permission)) {
        return false;
      }
    }
    return true;
  }

  /// 허용되지 않은 권한들이 허용될 때까지 요청
  Future<void> requestDeniedPermissions(List<Permission> permissions) async {
    var deniedPermissions = List<Permission>.from(permissions);
    do {
      await deniedPermissions.request();

      // deniedPermissions = [
      //   for (var permission in deniedPermissions)
      //     if (!await isPermissionGranted(permission)) permission,
      // ];

      var stillDenied = <Permission>[];
      for (var permission in deniedPermissions) {
        final status = await permission.status;

        if (status.isPermanentlyDenied) {
          await openAppSettings();
          // continue;
        }

        if (!await isPermissionGranted(permission)) {
          stillDenied.add(permission);
        }
      }

      deniedPermissions = stillDenied;
    } while (deniedPermissions.isNotEmpty);
  }

  Future<void> goAppSettings(Permission permission) async {
    final status = await permission.status;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return;
  }
}
