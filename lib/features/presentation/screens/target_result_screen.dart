import 'package:daily_pedometer/features/pedometer/domain/usecases/get_result_usecase.dart';
import 'package:daily_pedometer/features/pedometer/domain/usecases/get_step_status_usecase.dart';
import 'package:daily_pedometer/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 자정에 reset을 하면, 해당 페이지로 이동! 하루 동안 걸은 결과를 보여줌
/// 명확하게, 걸음 수, 칼로리 양 등을 기록하면 좋을 듯
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
