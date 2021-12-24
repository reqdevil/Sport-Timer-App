import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math' as math;

import 'package:timer_app/Utilities/AppColor.dart';
import 'package:timer_app/Widgets/ballwidget.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  final List<LinearProgress> _list = [];
  late Timer timer;
  late Color _color;
  late bool isBlinking;
  int _interval = 10;
  @override
  void initState() {
    setState(() {
      isBlinking = false;
    });

    _color = AppColor.primaryColor;
    for (var i = 0; i < 30; i++) {
      LinearProgress item =
          LinearProgress(GlobalObjectKey('key' + i.toString()), 0);

      _list.add(item);
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        startProgress();
      }
    });
    super.initState();
  }

  void startProgress() {
    setState(() {
      isBlinking = true;
    });
    int i = 0;
    timer = Timer.periodic(Duration(milliseconds: _interval), (_) {
      if (i == _list.length) {
        timer.cancel();
        setState(() {
          isBlinking = false;
        });
        print('cancelled');
      }
      if (i < _list.length) {
        setState(() {
          _list[i].percentage += 10;

          // _list[i + 1].percentage = 0;
        });
      }

      if (_list[i].percentage == 100) {
        // setState(() {
        //   if (_color == AppColor.primaryColor) {
        //     _color = AppColor.secondaryColor;
        //   } else if (_color == AppColor.secondaryColor) {
        //     _color = AppColor.primaryColor;
        //   }
        // });
        i++;
      }

      print(i);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Stack(
        // fit: StackFit.expand,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        children: [
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: 30,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, itemIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Transform.rotate(
                    angle: -math.pi / 22,
                    child: LinearPercentIndicator(
                      key: _list[itemIndex].key,
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      curve: Curves.linear,
                      restartAnimation: false,
                      animation: true,
                      animationDuration: 10,
                      alignment: MainAxisAlignment.center,
                      fillColor: Colors.transparent,
                      animateFromLastPercent: true,
                      width: MediaQuery.of(context).size.width,
                      lineHeight: 18.0,
                      percent: _list.isNotEmpty
                          ? _list.reversed.toList()[itemIndex].percentage / 100
                          : 0.0,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: Colors.white,
                      progressColor: Colors.indigo[400],
                    ),
                  ),
                );
              }),
          Positioned.fill(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: .5, sigmaY: 0.5),
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  for (var item in _list) {
                    item.percentage = 0;
                  }
                  timer.cancel();
                  startProgress();
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(32, 32),
                padding: const EdgeInsets.all(0),
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Icon(Icons.restart_alt_sharp,
                  color: Colors.white, size: 20),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Ball(
                  isBlinking: isBlinking,
                  primaryColor: AppColor.primaryColor,
                  secondaryColor: AppColor.secondaryColor,
                  interval: _interval * 10),
            ),
          )
        ],
      ),
    );
  }
}

class LinearProgress {
  // LinearPercentIndicator progressBar;
  GlobalObjectKey key;
  int percentage;

  LinearProgress(this.key, this.percentage);
}
