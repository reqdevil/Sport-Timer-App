// ignore_for_file: file_names

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:timer_app/Utilities/StartAngle.dart';

class LinearPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color shadowColor;
  final StrokeCap strokeCap;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double shadowWidth;
  final double borderRadius;
  final bool reverse;
  final StartAngle startAngle;

  LinearPainter({
    required this.progress,
    this.color = Colors.blue,
    this.shadowColor = Colors.grey,
    this.strokeWidth = 4,
    this.shadowWidth = 1,
    this.reverse = false,
    required this.strokeCap,
    required this.paintingStyle,
    this.startAngle = StartAngle.topLeft,
    this.borderRadius = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    Paint shadowPaint = Paint()
      ..strokeWidth = shadowWidth
      ..color = shadowColor
      ..style = paintingStyle
      ..strokeCap = strokeCap;

    var path = Path();
    Path dashPath = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 50);

    // TOP RIGHT -> TOP LEFT
    path.moveTo(borderRadius, 0);
    path.lineTo(size.width - borderRadius, 0);
    path.arcTo(
      Rect.fromCircle(
          center: Offset(size.width - borderRadius, borderRadius),
          radius: borderRadius),
      -pi / 2,
      pi / 2,
      false,
    );

    // TOP LEFT -> BOTTOM LEFT
    path.lineTo(size.width, size.height - borderRadius);
    path.arcTo(
        Rect.fromCircle(
            center:
                Offset(size.width - borderRadius, size.height - borderRadius),
            radius: borderRadius),
        0,
        pi / 2,
        false);

    // BOTTOM LEFT -> BOTTOM RIGHT
    path.lineTo(0 + borderRadius, size.height);
    path.arcTo(
      Rect.fromCircle(
          center: Offset(borderRadius, size.height - borderRadius),
          radius: borderRadius),
      pi / 2,
      pi / 2,
      false,
    );

    // BOTTOM RIGHT -> TOP RIGHT
    path.lineTo(0, borderRadius);
    path.arcTo(
      Rect.fromCircle(
          center: Offset(borderRadius, borderRadius), radius: borderRadius),
      pi,
      pi / 2,
      false,
    );

    for (PathMetric pathMetric in path.computeMetrics()) {
      dashPath.addPath(
        pathMetric.extractPath(0, pathMetric.length * progress),
        Offset.zero,
      );
    }

    if (reverse) {
      dashPath = dashPath
          .transform(Matrix4Transform().rotate(pi / 2).m.storage)
          .transform(Matrix4Transform().flipHorizontally().m.storage);
    }

    dashPath = dashPath.transform(
        Matrix4Transform().rotateByCenter(startAngle.value, size).m.storage);

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
