import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<void> init();

  Future<dynamic> get({required String key});

  Future<bool> set({required String key, required dynamic data});

  Future<bool> has({required String key});

  Future<bool> remove({required String key});

  Future<void> clear();
}

class StorageServiceImpl implements StorageService {
  late SharedPreferences sharedPreferences;
  final Completer<SharedPreferences> initCompleter = Completer();

  @override
  Future<void> init() async {
    initCompleter.complete(SharedPreferences.getInstance());
    sharedPreferences = await initCompleter.future;
  }

  @override
  Future get({required String key}) async {
    log('${sharedPreferences.get(key)} 가져옴...', name: "get: $key");
    return sharedPreferences.get(key);
  }

  @override
  Future<bool> set({required String key, required dynamic data}) async {
    if (data is bool) {
      log("저장 완료", name: "set $key");
      return sharedPreferences.setBool(key, data);
    } else if (data is int) {
      log("저장 완료", name: "set $key");
      return sharedPreferences.setInt(key, data);
    } else if (data is double) {
      log("저장 완료", name: "set $key");
      return sharedPreferences.setDouble(key, data);
    } else if (data is String) {
      log("저장 완료", name: "set $key");
      return sharedPreferences.setString(key, data);
    } else if (data is List<String>) {
      log("저장 완료", name: "set $key");
      return sharedPreferences.setStringList(key, data);
    } else {
      throw ArgumentError("Unsufforted Type: ${data.runtimeType}");
    }
  }

  @override
  Future<bool> has({required String key}) async {
    log("포함여부 확인중...", name: "has $key");
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<bool> remove({required String key}) async {
    log("삭제 완료", name: "remove $key");
    return sharedPreferences.remove(key);
  }

  @override
  Future<void> clear() async {
    log("Pref 클리어!", name: "clear");
    await sharedPreferences.clear();
  }
}
