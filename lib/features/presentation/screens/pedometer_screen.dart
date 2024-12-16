import 'package:daily_pedometer/features/presentation/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PedometerScreen extends ConsumerWidget {
  const PedometerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsState = ref.watch(stepsNotifierProviderProvider);
    return Center(
      child: stepsState.when(
        data: (steps) => Text(
          "Steps: $steps",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        error: (err, _) => Text("$err"),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
