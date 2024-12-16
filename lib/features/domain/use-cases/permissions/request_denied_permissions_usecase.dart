import 'package:daily_pedometer/features/domain/repositories/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestDeniedPermissionsUsecase {
  final PermissionRepository repository;

  RequestDeniedPermissionsUsecase(this.repository);

  Future<void> execute(List<Permission> permissions) async {
    await repository.requestDeniedPermissions(permissions);
  }
}
