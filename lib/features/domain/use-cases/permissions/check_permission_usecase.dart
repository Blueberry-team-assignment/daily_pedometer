import 'package:daily_pedometer/features/domain/repositories/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissionUsecase {
  final PermissionRepository repository;

  CheckPermissionUsecase(this.repository);

  Future<bool> execute(Permission permission) async {
    return await repository.checkPermission(permission);
  }
}
