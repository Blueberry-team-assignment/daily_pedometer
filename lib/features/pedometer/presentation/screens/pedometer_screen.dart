import 'package:daily_pedometer/features/pedometer/domain/usecases/check_targeted_reached_usecase.dart';
import 'package:daily_pedometer/features/pedometer/domain/usecases/get_step_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PedometerScreen extends ConsumerWidget {
  const PedometerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkTargertedReachedUsecase =
        ref.watch(checkTargetedReachedUsecaseProvider);
    return Center(
      child: FutureBuilder<bool>(
        future: Future(() => checkTargertedReachedUsecase.execute()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final targetReached = snapshot.data ?? false;
          return Text(
            targetReached ? "목표 도달!" : "목표까지 더 걸어야 합니다!",
          );
        },
      ),
      // child: stepsState.when(
      //   data: (steps) => Text(
      //     "Steps: $steps",
      //     style: Theme.of(context).textTheme.headlineLarge,
      //   ),
      //   error: (err, _) => Text("$err"),
      //   loading: () => CircularProgressIndicator(),
      // ),
    );
  }
}
