import 'dart:developer';
import 'dart:math' hide log;

import 'package:daily_pedometer/common/providers/provider.dart';
import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/usecases/get_step_status_usecase.dart';
import 'package:daily_pedometer/features/pedometer/presentation/widgets/rolled_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TargetSettingsScreen extends ConsumerStatefulWidget {
  const TargetSettingsScreen({super.key});

  @override
  ConsumerState<TargetSettingsScreen> createState() =>
      _TargetSettingsScreenState();
}

class _TargetSettingsScreenState extends ConsumerState<TargetSettingsScreen> {
  final List<int> selectedValues = [0, 0, 0, 0];
  final List<List<int>> digits = [
    List.generate(10, (index) => index),
    List.generate(10, (index) => index),
    List.generate(10, (index) => index),
    List.generate(10, (index) => index),
  ];
  int get targetedSteps {
    int result = 0;
    for (int i = 0; i < selectedValues.length; i++) {
      result +=
          selectedValues[i] * (pow(10, selectedValues.length - i - 1) as int);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                ...List.generate(
                  digits.length,
                  (index) {
                    return Expanded(
                      child: RolledNumberPicker(
                        initialValue: selectedValues[index],
                        values: digits[index],
                        onChanged: (value) {
                          setState(() {
                            selectedValues[index] = value;
                          });
                        },
                      ),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      // final theme =
                      //     ref.read(themeNotifierProviderProvider.notifier);
                      // theme.toggleTheme();
                      final repository = ref.read(pedometerRepositoryProvider);
                      repository.updateTargetedSteps(targetedSteps);
                      log('$targetedSteps');
                    },
                    child: Text("선택하기")),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // final theme =
                  //     ref.read(themeNotifierProviderProvider.notifier);
                  // theme.toggleTheme();
                  final repository = ref.read(pedometerRepositoryProvider);
                  repository.updateTargetedSteps(targetedSteps);
                  log('$targetedSteps');
                },
                child: Text("선택하기")),
          ),
        ],
      ),
    );
  }
}
