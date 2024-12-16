import 'package:daily_pedometer/features/domain/repositories/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckAllPermissionGrantedUsecase {
  final PermissionRepository repository;

  CheckAllPermissionGrantedUsecase(this.repository);

  Future<bool> execute(List<Permission> permissions) async {
    return await repository.checkAllPermissionsGranted(permissions);
  }
}
