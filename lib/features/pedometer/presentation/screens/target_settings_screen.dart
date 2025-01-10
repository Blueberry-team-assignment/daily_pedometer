import 'dart:developer';
import 'dart:math' hide log;

import 'package:daily_pedometer/common/providers/provider.dart';
import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/notifiers/steps_notifier.dart';

import 'package:daily_pedometer/features/pedometer/presentation/widgets/steps_picker.dart';
import 'package:daily_pedometer/routers/router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TargetSettingsScreen extends ConsumerStatefulWidget {
  const TargetSettingsScreen({super.key});

  @override
  ConsumerState<TargetSettingsScreen> createState() =>
      _TargetSettingsScreenState();
}

class _TargetSettingsScreenState extends ConsumerState<TargetSettingsScreen> {
  int targetedSteps = 0;

  @override
  Widget build(BuildContext context) {
    final repository = ref.read(pedometerRepositoryProvider);
    final stepsNotifier = ref.watch(stepsEntityNotifierProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "목표 걸음 수",
                style: TextStyle(
                  fontSize: 42,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: StepsPicker(
              onChanged: (int value) async {
                targetedSteps = value;
              },
              onPressed: () async {
                repository.updateTargetedSteps(targetedSteps);
              },
            ),
          ),
          const Divider(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.topRight,
                    child: Text("목표 걸음 수: ${stepsNotifier.getTargetedSteps()}"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushReplacement(AppRoutes.pedometer);
                    },
                    child: Text("시작하기"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
