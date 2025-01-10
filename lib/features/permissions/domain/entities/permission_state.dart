import 'package:permission_handler/permission_handler.dart';

class PermissionState {
  final bool allPermissionsGranted;
  final List<Permission> deniedPermissions;
  final bool isLoading;

  PermissionState({
    required this.allPermissionsGranted,
    required this.deniedPermissions,
    required this.isLoading,
  });

  PermissionState copyWith({
    bool? allPermissionsGranted,
    List<Permission>? deniedPermissions,
    bool? isLoading,
  }) {
    return PermissionState(
      allPermissionsGranted:
          allPermissionsGranted ?? this.allPermissionsGranted,
      deniedPermissions: deniedPermissions ?? this.deniedPermissions,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory PermissionState.initial() {
    return PermissionState(
      allPermissionsGranted: false,
      deniedPermissions: [],
      isLoading: true,
    );
  }
}
