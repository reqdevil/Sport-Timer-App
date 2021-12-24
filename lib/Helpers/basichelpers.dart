import 'package:flutter/services.dart';

class BasicHelpers {
  hideStatusbar() {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom, //This line is used for showing the bottom bar
    ]);
  }

  showStatusbar() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}
