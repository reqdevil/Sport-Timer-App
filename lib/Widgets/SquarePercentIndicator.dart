// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer_app/Painters/CenterRadialPainter.dart';
import 'package:timer_app/Painters/EdgeRadialPainter.dart';
import 'package:timer_app/Utilities/StartAngle.dart';

class SquarePercentIndicator extends StatefulWidget {
  final double width;
  final double height;
  final double progress;

  // Border Radius
  final double borderRadius;

  // Colors
  final Color progressColor;
  final Color shadowColor;

  // Thickness
  final double progressWidth;
  final double shadowWidth;

  // True = Clockwise, False = Counter-Clockwise
  final bool reverse;

  final Widget? child;
  final StartAngle startAngle;

  SquarePercentIndicator({
    Key? key,
    this.progress = 1,
    this.reverse = false,
    this.borderRadius = 5,
    this.progressColor = Colors.blue,
    this.shadowColor = Colors.grey,
    this.progressWidth = 5,
    this.shadowWidth = 5,
    this.child,
    this.startAngle = StartAngle.topLeft,
    this.width = 150,
    this.height = 150,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SqaurePercentIndicatorState();
}

class _SqaurePercentIndicatorState extends State<SquarePercentIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        child: widget.child ?? Container(),
        painter: widget.startAngle == StartAngle.bottomCenter ||
                widget.startAngle == StartAngle.topCenter ||
                widget.startAngle == StartAngle.rightCenter ||
                widget.startAngle == StartAngle.leftCenter
            ? CenterRadialPainter(
                startAngle: widget.startAngle,
                progress: widget.progress,
                color: widget.progressColor,
                shadowColor: widget.shadowColor,
                reverse: widget.reverse,
                strokeCap: StrokeCap.round,
                paintingStyle: PaintingStyle.stroke,
                strokeWidth: widget.progressWidth,
                shadowWidth: widget.shadowWidth,
                borderRadius: widget.borderRadius,
              )
            : EdgeRadialPainter(
                startAngle: widget.startAngle,
                progress: widget.progress,
                color: widget.progressColor,
                shadowColor: widget.shadowColor,
                reverse: widget.reverse,
                strokeCap: StrokeCap.round,
                paintingStyle: PaintingStyle.stroke,
                strokeWidth: widget.progressWidth,
                shadowWidth: widget.shadowWidth,
                borderRadius: widget.borderRadius,
              ),
      ),
    );
  }
}
