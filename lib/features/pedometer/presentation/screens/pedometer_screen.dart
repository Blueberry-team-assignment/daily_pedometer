import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PedometerScreen extends ConsumerWidget {
  const PedometerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepCountAsync = ref.watch(stepCountStreamProvider);
    return Scaffold(
      body: Center(
        child: stepCountAsync.when(
          data: (steps) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("걸음 수", style: TextStyle(fontSize: 24)),
              Text(
                "$steps",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          error: (err, _) => Text("$err"),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
