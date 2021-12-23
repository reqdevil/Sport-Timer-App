// ignore_for_file: file_names

import 'dart:math';

enum StartAngle {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
  topCenter,
  leftCenter,
  rightCenter,
  bottomCenter,
}

extension GetValue on StartAngle {
  double get value => getRotationAngle;

  double get getRotationAngle {
    switch (this) {
      case StartAngle.topLeft:
      case StartAngle.leftCenter:
        return 0;
      case StartAngle.topRight:
      case StartAngle.topCenter:
        return pi * 0.5;
      case StartAngle.bottomRight:
      case StartAngle.rightCenter:
        return pi * 1.0;
      case StartAngle.bottomLeft:
      case StartAngle.bottomCenter:
        return pi * 1.5;
      default:
        return 0;
    }
  }
}
