import 'package:daily_pedometer/features/data/permission_repository_impl.dart';
import 'package:daily_pedometer/features/data/permission_service.dart';
import 'package:daily_pedometer/features/domain/use-cases/permissions/check_all_permission_granted_usecase.dart';
import 'package:daily_pedometer/features/domain/use-cases/permissions/check_permission_usecase.dart';
import 'package:daily_pedometer/features/domain/use-cases/permissions/request_denied_permissions_usecase.dart';
import 'package:daily_pedometer/features/domain/use-cases/permissions/request_permission_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [Repository Provider]
final permissionRepositoryProvider = Provider((ref) {
  return PermissionRepositoryImpl(PermissionService());
});

/// [Permission Usecase Provider]

/// [checkPermission]
final checkPermissionUsecaseProvider = Provider(
  (ref) => CheckPermissionUsecase(
    ref.read(permissionRepositoryProvider),
  ),
);

/// [requestPermission]
final requestPermissionUsecaseProvider = Provider(
  (ref) => RequestPermissionUsecase(
    ref.read(permissionRepositoryProvider),
  ),
);

/// [checkAllPermissionGranted]
final checkAllPermissionsGrantedUsecaseProvider = Provider(
  (ref) => CheckAllPermissionGrantedUsecase(
    ref.read(permissionRepositoryProvider),
  ),
);

/// [requestDeniedPermissions]
final requestDeniedPermissionsUsecaseProvider = Provider(
  (ref) => RequestDeniedPermissionsUsecase(
    ref.read(permissionRepositoryProvider),
  ),
);
