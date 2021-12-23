// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/Painters/LinearPainter.dart';
import 'package:timer_app/Utilities/AppColor.dart';
import 'package:timer_app/Widgets/SquarePercentIndicator.dart';
import 'package:timer_app/Utilities/StartAngle.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double progress = 1;
  int second = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CustomPaint(
                painter: LinearPainter(
                  progress: progress,
                  strokeCap: StrokeCap.round,
                  paintingStyle: PaintingStyle.stroke,
                ),
              ),
            ),
            // Center(
            //   child: AspectRatio(
            //     aspectRatio: 1,
            //     child: Container(
            //       margin: const EdgeInsets.all(50),
            //       color: AppColor.darkPrimaryColor,
            //       child: SquarePercentIndicator(
            //         borderRadius: 10,
            //         progress: progress,
            //         progressWidth: 20,
            //         shadowWidth: 20,
            //         progressColor: AppColor.secondaryColor,
            //         shadowColor: AppColor.primaryColor,
            //         startAngle: StartAngle.topCenter,
            //         reverse: true,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Expanded(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: const [
            //                   SizedBox(height: 30),
            //                   Text(
            //                     "ROUND",
            //                     style: TextStyle(
            //                       color: AppColor.white,
            //                       fontSize: 30,
            //                     ),
            //                   ),
            //                   Text(
            //                     "3 of 5",
            //                     style: TextStyle(
            //                       color: AppColor.white,
            //                       fontSize: 30,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Expanded(
            //               child: Text(
            //                 second.toString(),
            //                 style: const TextStyle(
            //                   fontSize: 100,
            //                   fontWeight: FontWeight.bold,
            //                   color: AppColor.white,
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: const [
            //                   Text(
            //                     "Pushups",
            //                     style: TextStyle(
            //                       color: AppColor.white,
            //                       fontSize: 30,
            //                     ),
            //                   ),
            //                   Text(
            //                     "Next: Burpies",
            //                     style: TextStyle(
            //                       color: AppColor.backgroundColor,
            //                       fontSize: 15,
            //                     ),
            //                   ),
            //                   SizedBox(height: 30),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void startAnimation(mSecond) {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        progress -= 1 / mSecond;

        if (timer.tick % 100 == 0) {
          second -= 1;
        }

        if (progress < 0) {
          timer.cancel();
        }
      });
    });
  }

  void resetAnimation() {
    setState(() {
      progress = 1;
      second = 10;
    });
  }
}
