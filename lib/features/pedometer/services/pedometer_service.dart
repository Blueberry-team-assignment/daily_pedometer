import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final pedometerServiceProvider = Provider((_) => PedometerService());

class PedometerService {
  static final PedometerService _instance = PedometerService._internal();
  PedometerService._internal();
  factory PedometerService() => _instance;

  /// 리팩토링
  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  Stream<StepCount> get stepCountStream => _stepCountStream;
}
