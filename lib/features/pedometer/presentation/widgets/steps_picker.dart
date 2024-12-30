import 'dart:math';

import 'package:daily_pedometer/features/pedometer/presentation/widgets/rolled_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepsPicker extends ConsumerStatefulWidget {
  // final List<List<int>> digits;
  // final List<int> selectedValues;
  final VoidCallback? onPressed;
  final String buttonTitle;
  const StepsPicker({
    super.key,
    this.onPressed,
    this.buttonTitle = "선택하기",
    // required this.digits,
    // required this.selectedValues,
  });
  @override
  ConsumerState<StepsPicker> createState() => _StepsPickerState();
}

class _StepsPickerState extends ConsumerState<StepsPicker> {
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
    return Column(
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
                onPressed: widget.onPressed,
                child: Text(widget.buttonTitle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
