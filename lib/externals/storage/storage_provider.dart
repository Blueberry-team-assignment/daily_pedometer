import 'package:daily_pedometer/externals/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storageProvider = Provider<StorageService>((ref) {
  final StorageServiceImpl storageSerivce = StorageServiceImpl();
  storageSerivce.init();
  return storageSerivce;
});
