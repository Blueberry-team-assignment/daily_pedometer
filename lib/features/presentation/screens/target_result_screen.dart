import 'package:daily_pedometer/features/pedometer/domain/usecases/get_result_usecase.dart';
import 'package:daily_pedometer/features/pedometer/domain/usecases/get_step_status_usecase.dart';
import 'package:daily_pedometer/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TargetResultScreen extends ConsumerWidget {
  const TargetResultScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool getResult() {
      final getResultUsecase = ref.watch(getResultUsecaseProvider);
      return getResultUsecase.execute();
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                getResult() ? "Success" : "Fail",
                style: TextStyle(
                  fontSize: 64,
                  color: getResult() ? Colors.green : Colors.red,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.pushReplacementNamed(AppRoutes.splash);
            },
            child: Text("처음으로 돌아가기 >"),
          ),
        ],
      ),
    );
  }
}
