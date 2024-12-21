import 'package:daily_pedometer/features/permissions/data/repositories/permission_repository_impl.dart';
import 'package:daily_pedometer/features/permissions/domain/repositories/permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final checkAllPermissionGrantedUsecaseProvider = Provider(
  (ref) => CheckAllPermissionGrantedUsecase(
    ref.watch(permissionRepositoryProvider),
  ),
);

class CheckAllPermissionGrantedUsecase {
  final PermissionRepository repository;

  CheckAllPermissionGrantedUsecase(this.repository);

  Future<bool> execute(List<Permission> permissions) async {
    return await repository.checkAllPermissionsGranted(permissions);
  }
}
