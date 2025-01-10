import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/externals/storage/storage_service.dart';
import 'package:daily_pedometer/features/pedometer/presentation/screens/pedometer_screen.dart';
import 'package:daily_pedometer/features/pedometer/presentation/screens/target_settings_screen.dart';
import 'package:daily_pedometer/features/permissions/presentation/screens/permission_check_screen.dart';
import 'package:daily_pedometer/features/presentation/screens/splash_screen.dart';
import 'package:daily_pedometer/features/presentation/screens/target_result_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'app_router.dart';
part 'app_routes.dart';
part 'app_router_interceptor.dart';
part 'router.g.dart';
