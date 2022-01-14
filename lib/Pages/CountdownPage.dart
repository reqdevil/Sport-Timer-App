// ignore_for_file: file_names

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:timer_app/Model/BallItem.dart';
import 'package:timer_app/Model/LinearProgress.dart';
import 'package:timer_app/Utilities/AppColor.dart';
import 'package:timer_app/Widgets/BallWidget.dart';
import 'package:timer_app/Widgets/CustomDialogBox.dart';
import 'package:timer_app/Widgets/SquarePercentIndicator.dart';
import 'package:timer_app/Utilities/StartAngle.dart';
import 'dart:math' as math;

class CountdownPage extends StatefulWidget {
  final int roundNumber;
  final List<String> roundNames;
  final List<String> roundSeconds;
  final String restSeconds;

  const CountdownPage({
    Key? key,
    required this.roundNumber,
    required this.roundNames,
    required this.roundSeconds,
    required this.restSeconds,
  }) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late bool _isRest;
  double _progress = 1;
  int _currentRound = 0;
  late int _tempSecond;
  late String _roundName;
  late String _nextRoundName;

  final List<LinearProgress> _backgroundLines = [];
  final List<BallItem> _circleList = [];
  final _lineCount = 30;

  final _interval = 20;
  late Timer _secondTimer;
  late Timer _progressTimer;

  @override
  void initState() {
    super.initState();

    _isRest = false;
    _tempSecond = int.parse(widget.roundSeconds[_currentRound]);
    _roundName = widget.roundNames[_currentRound];
    _nextRoundName = widget.roundNames[_currentRound + 1];

    for (var i = 0; i < widget.roundNumber; i++) {
      BallItem itemBall = BallItem(false, _interval * 50);
      _circleList.add(itemBall);
    }

    setState(() {
      _circleList[0].isBlinking = true;
    });

    for (var i = 0; i < _lineCount; i++) {
      LinearProgress item =
          LinearProgress(GlobalObjectKey('key' + i.toString()), 0);

      _backgroundLines.add(item);
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (mounted) {
        await startAnimation(int.parse(widget.roundSeconds[_currentRound]));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _progressTimer.cancel();
    _secondTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            // BACKGROUND LINES
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
                      key: _backgroundLines[itemIndex].key,
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
                      percent: _backgroundLines.isNotEmpty
                          ? _backgroundLines.reversed
                                  .toList()[itemIndex]
                                  .percentage /
                              100
                          : 0.0,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: AppColor.white,
                      progressColor: AppColor.darkPrimaryColor,
                    ),
                  ),
                );
              },
            ),
            // BLURRY LINE
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
            // TOP CENTER CIRCLES
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 6,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    itemCount: _circleList.length,
                    itemBuilder: (context, index) {
                      return BallWidget(
                        isBlinking: _circleList[index].isBlinking,
                        primaryColor: AppColor.primaryColor,
                        secondaryColor: AppColor.secondaryColor,
                        interval: _circleList[index].interval,
                        number: index + 1,
                      );
                    },
                  ),
                ),
              ),
            ),
            // SECOND TIMER
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(50),
                  color: AppColor.darkPrimaryColor,
                  child: SquarePercentIndicator(
                    borderRadius: 10,
                    progress: _progress,
                    progressWidth: 20,
                    shadowWidth: 20,
                    progressColor: AppColor.secondaryColor,
                    shadowColor: AppColor.primaryColor,
                    startAngle: StartAngle.topCenter,
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                _isRest ? "REST" : "ROUND",
                                style: _isRest
                                    ? const TextStyle(
                                        color: AppColor.white,
                                        fontSize: 50,
                                      )
                                    : const TextStyle(
                                        color: AppColor.white,
                                        fontSize: 30,
                                      ),
                              ),
                              if (!_isRest)
                                Text(
                                  (_currentRound + 1).toString() +
                                      " of " +
                                      widget.roundNumber.toString(),
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: 30,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _tempSecond.toString(),
                            style: const TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (!_isRest)
                                Text(
                                  _roundName,
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: 30,
                                  ),
                                ),
                              if (_nextRoundName != "NONE")
                                Text(
                                  "Next: " + _nextRoundName,
                                  style: _isRest
                                      ? const TextStyle(
                                          color: AppColor.backgroundColor,
                                          fontSize: 30,
                                        )
                                      : const TextStyle(
                                          color: AppColor.backgroundColor,
                                          fontSize: 15,
                                        ),
                                ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // POP CONTEXT
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                child: const Icon(
                  Icons.arrow_left,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            // RESTART ANIMATION
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(32, 32),
                  padding: const EdgeInsets.all(0),
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startAnimation(
    int second,
  ) async {
    int i = 0;
    double _backgroundProgress = (100 / ((second / 30) * 1000)) * _interval;
    double _squareProgress = second * (1000 / _interval);

    _tempSecond = second;
    _roundName = widget.roundNames[_currentRound];
    if (!(widget.roundNames.length - 1 == _currentRound)) {
      _nextRoundName = widget.roundNames[_currentRound + 1];
    } else {
      _nextRoundName = "NONE";
    }

    for (i = 0; i < _backgroundLines.length; i++) {
      _backgroundLines[i].percentage = 0;
    }
    i = 0;

    _progress = 1;

    setState(() {
      for (var item in _circleList) {
        if (item == _circleList[_currentRound]) {
          item.isBlinking = true;
        } else {
          item.isBlinking = false;
        }
      }
    });

    _secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_tempSecond != 0) {
          _tempSecond -= 1;
        }
      });
    });

    _progressTimer =
        Timer.periodic(Duration(milliseconds: _interval), (_) async {
      if (i >= _backgroundLines.length || _progress <= 0) {
        _progressTimer.cancel();
        _secondTimer.cancel();

        if (_isRest) {
          _currentRound++;
          _isRest = !_isRest;

          await startAnimation(int.parse(widget.roundSeconds[_currentRound]));
          return;
        } else {
          if (_currentRound == _circleList.length - 1) {
            setState(() {
              _circleList[_currentRound].isBlinking = false;
            });

            return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return WillPopScope(
                  onWillPop: () => Future.value(false),
                  child: const CustomDialogBox(
                    title: "",
                    descriptions: 'FINISHED',
                    submitText: 'OK',
                    widget: Icon(
                      Icons.thumb_up_alt_rounded,
                      color: AppColor.primaryColor,
                      size: 50,
                    ),
                  ),
                );
              },
            );
          }

          _isRest = !_isRest;
          await startAnimation(int.parse(widget.restSeconds));
          return;
        }
      }

      if (_backgroundLines[i].percentage + _backgroundProgress >= 100) {
        _backgroundLines[i].percentage = 100;
        i++;

        setState(() {
          _progress -= 1 / _squareProgress;
        });
      } else {
        setState(() {
          _progress -= 1 / _squareProgress;
          _backgroundLines[i].percentage += _backgroundProgress;
        });
      }
    });
  }
}
