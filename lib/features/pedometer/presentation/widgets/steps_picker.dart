import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepsPicker extends ConsumerStatefulWidget {
  const StepsPicker({super.key});
  @override
  ConsumerState<StepsPicker> createState() => _StepsPickerState();
}

class _StepsPickerState extends ConsumerState<StepsPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(

              ///
              ),
        ),
      ],
    );
  }
}
