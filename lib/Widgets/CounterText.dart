// ignore_for_file: file_names, must_be_immutable

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:timer_app/Utilities/AppColor.dart';

class CounterText extends StatefulWidget {
  late int count;

  CounterText({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  _CounterTextState createState() => _CounterTextState();
}

class _CounterTextState extends State<CounterText> {
  late Timer _timer;
  int timerCount = 60;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerCount.toString() + " sn. ",
      style: const TextStyle(
        color: AppColor.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.18,
      ),
      textAlign: TextAlign.center,
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCount == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            timerCount--;
          });
        }
      },
    );
  }
}
