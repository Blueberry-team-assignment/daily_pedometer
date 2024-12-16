import 'package:daily_pedometer/features/domain/repositories/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionUsecase {
  final PermissionRepository repository;

  RequestPermissionUsecase(this.repository);

  Future<void> execute(Permission permission) async {
    await repository.requestPermission(permission);
  }
}
