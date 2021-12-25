import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
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
  final List<LinearProgress> _listProgress = [];
  final List<BallItem> _listBall = [];
  late Timer timer;
  int _interval = 10;
  int _currentBallIndex = 0;
  int _progressBarCount = 30;
  int _ballItemCount = 5;
  bool _firstStart = false;
  @override
  void initState() {
    for (var i = 0; i < _ballItemCount; i++) {
      BallItem itemBall = BallItem(false, _interval * 10);
      _listBall.add(itemBall);
    }
    setState(() {
      _listBall[0].isBlinking = true;
    });
    for (var i = 0; i < _progressBarCount; i++) {
      LinearProgress item =
          LinearProgress(GlobalObjectKey('key' + i.toString()), 0);

      _listProgress.add(item);
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (mounted) {
        setState(() {
          _firstStart = true;
        });
        await startProgress(_currentBallIndex);
      }
    });
    super.initState();
  }

  // int _currentProgressIndex = 0;
  Future<void> startProgress(int ballIndex) async {
    if (ballIndex == _listBall.length) {
      _listBall[ballIndex - 1].isBlinking = false;
      return;
    }
    for (var i = 0; i < _listProgress.length; i++) {
      _listProgress[i].percentage = 0;
    }
    int i = 0;
    _currentBallIndex = ballIndex;
    setState(() {
      for (var item in _listBall) {
        if (item == _listBall[ballIndex]) {
          item.isBlinking = true;
        } else {
          item.isBlinking = false;
        }
      }
    });
    timer = Timer.periodic(Duration(milliseconds: _interval), (_) async {
      if (i == _listProgress.length) {
        if (kDebugMode) {
          print('cancelled');
        }

        timer.cancel();
        _currentBallIndex++;
        await startProgress(_currentBallIndex);
      }
      if (i < _listProgress.length) {
        setState(() {
          _listProgress[i].percentage += 10;
        });
      }

      if (_listProgress[i].percentage == 100) {
        i++;
      }

      if (kDebugMode) {
        print(i);
      }
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
                      key: _listProgress[itemIndex].key,
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
                      percent: _listProgress.isNotEmpty
                          ? _listProgress.reversed
                                  .toList()[itemIndex]
                                  .percentage /
                              100
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
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 6,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemCount: _listBall.length,
                  itemBuilder: (context, index) {
                    return Ball(
                        isBlinking: _listBall[index].isBlinking,
                        primaryColor: AppColor.primaryColor,
                        secondaryColor: AppColor.secondaryColor,
                        interval: _listBall[index].interval);
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Visibility(
              visible: _firstStart,
              child: ElevatedButton(
                onPressed: () async {
                  _currentBallIndex = 0;
                  timer.cancel();
                  for (var i = 0; i < _listBall.length; i++) {
                    setState(() {
                      _listBall[i].isBlinking = false;
                    });
                  }
                  for (var i = 0; i < _listProgress.length; i++) {
                    setState(() {
                      _listProgress[i].percentage = 0;
                    });
                  }
                  await startProgress(_currentBallIndex);
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
          ),
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

class BallItem {
  bool isBlinking;
  int interval;
  BallItem(this.isBlinking, this.interval);
}
