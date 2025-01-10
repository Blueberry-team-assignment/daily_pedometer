import 'package:daily_pedometer/features/permissions/data/repositories/permission_repository_impl.dart';
import 'package:daily_pedometer/features/permissions/domain/repositories/permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// final requestPermissionUsecaseProvider = Provider(
//   (ref) => RequestPermissionUsecase(
//     ref.watch(permissionRepositoryProvider),
//   ),
// );

// class RequestPermissionUsecase {
//   final PermissionRepository repository;

//   RequestPermissionUsecase(this.repository);

//   Future<void> execute(Permission permission) async {
//     await repository.requestPermission(permission);
//   }
// }
