import 'package:daily_pedometer/features/permissions/data/repositories/permission_repository_impl.dart';
import 'package:daily_pedometer/features/permissions/domain/repositories/permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// final checkPermissionUsecaseProvider = Provider(
//   (ref) => CheckPermissionUsecase(
//     ref.watch(permissionRepositoryProvider),
//   ),
// );

// class CheckPermissionUsecase {
//   final PermissionRepository repository;

//   CheckPermissionUsecase(this.repository);

//   Future<bool> execute(Permission permission) async {
//     return await repository.checkPermission(permission);
//   }
// }
