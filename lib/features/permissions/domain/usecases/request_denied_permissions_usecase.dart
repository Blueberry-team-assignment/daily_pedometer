import 'package:daily_pedometer/features/permissions/data/repositories/permission_repository_impl.dart';
import 'package:daily_pedometer/features/permissions/domain/repositories/permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final requestDeniedPermissionUsecaseProvider = Provider(
  (ref) => RequestDeniedPermissionsUsecase(
    ref.watch(permissionRepositoryProvider),
  ),
);

class RequestDeniedPermissionsUsecase {
  final PermissionRepository repository;

  RequestDeniedPermissionsUsecase(this.repository);

  Future<void> execute(List<Permission> permissions) async {
    await repository.requestDeniedPermissions(permissions);
  }
}
