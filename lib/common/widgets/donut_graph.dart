import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonutGraph extends ConsumerWidget {
  final int steps;
  final int targetedSteps;
  const DonutGraph({
    super.key,
    required this.steps,
    required this.targetedSteps,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: CustomPaint(
        size: const Size(300, 150),
        painter: DonutPainter(
          steps: steps,
          targetedSteps: targetedSteps,
        ),
      ),
    );
  }
}

class DonutPainter extends CustomPainter {
  final int steps;
  final int targetedSteps;

  DonutPainter({
    required this.steps,
    required this.targetedSteps,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final double percentage = (steps / targetedSteps).clamp(0.0, 1.0);

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color.fromARGB(255, 255, 62, 62),
          const Color.fromARGB(255, 255, 208, 0)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // 시작 각도 (180도)
      pi, // 끝 각도 (180도)
      false,
      basePaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // 시작 각도 (180도)
      pi * percentage, // 끝 각도
      false,
      progressPaint,
    );

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    if (steps >= targetedSteps) {
      // Success 메시지
      textPainter.text = TextSpan(
        text: "Success",
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      );
    } else {
      // 진행률 메시지
      textPainter.text = TextSpan(
        text: "걷는 중...",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }

    textPainter.layout();
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - radius / 2, // 반 도넛 중앙
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
