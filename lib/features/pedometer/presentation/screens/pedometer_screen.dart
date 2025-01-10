import 'package:daily_pedometer/common/widgets/donut_graph.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/domain/usecases/get_result_usecase.dart';
import 'package:daily_pedometer/features/pedometer/domain/usecases/get_step_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PedometerScreen extends ConsumerWidget {
  const PedometerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepCountAsync = ref.watch(stepCountStreamProvider);
    final getStepStatusUsecase = ref.watch(getStepStatusUsecaseProvider);

    bool getResult() {
      final getResultUsecase = ref.watch(getResultUsecaseProvider);
      return getResultUsecase.execute();
    }

    return Scaffold(
      body: Center(
        child: stepCountAsync.when(
          data: (steps) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DonutGraph(
                steps: steps,
                targetedSteps: getStepStatusUsecase.execute().targetedSteps,
              ),
              Text("걸음 수", style: TextStyle(fontSize: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$steps",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " / ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${getStepStatusUsecase.execute().targetedSteps}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // const Divider(),
              // Text(
              //   getResult() ? "Success" : "Fail",
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: getResult() ? Colors.green : Colors.red,
              //   ),
              // ),
            ],
          ),
          error: (err, _) => Text("$err"),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
