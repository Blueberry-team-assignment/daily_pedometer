import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RolledNumberPicker extends ConsumerWidget {
  final int initialValue; // 초기 선택 값
  final List<int> values; // 선택 가능한 값 리스트
  final ValueChanged<int> onChanged; // 값 변경 콜백
  final double itemExtent, magnification; // 각 아이템의 높이
  final TextStyle? textStyle; // 텍스트 스타일
  final bool useMagnifier;
  const RolledNumberPicker({
    super.key,
    required this.initialValue,
    required this.values,
    required this.onChanged,
    this.itemExtent = 40.0,
    this.magnification = 1.3,
    this.textStyle,
    this.useMagnifier = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPicker(
      magnification: magnification,
      useMagnifier: useMagnifier,
      itemExtent: itemExtent,
      scrollController: FixedExtentScrollController(
          initialItem: values.indexOf(initialValue)),
      onSelectedItemChanged: onChanged,
      children: values
          .map(
            (step) => Center(
              child: Text(
                '$step',
                style: textStyle,
              ),
            ),
          )
          .toList(),
    );
  }
}
