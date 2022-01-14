// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:timer_app/Utilities/AppColor.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final Duration? duration;
  bool hasCloseButton = true;
  AnimationController? animationController;

  CustomCircularProgressIndicator({
    Key? key,
    this.duration,
    this.animationController,
  }) : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    widget.animationController = controller;
    controller.addListener(() {
      if (controller.value == 1.0) {
        dismissAllToast(showAnim: true);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    // startTimer();
    return Transform(
      transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            value: controller.value,
            color: AppColor.white,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColor.white),
          ),
          ElevatedButton(
            onPressed: () {
              dismissAllToast(showAnim: true);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(30, 30),
              tapTargetSize: MaterialTapTargetSize.padded,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              primary: Colors.white.withOpacity(0.3), // <-- Button color
              onPrimary: AppColor.grey, // <-- Splash color
            ),
          ),
        ],
      ),
    );
  }
}
