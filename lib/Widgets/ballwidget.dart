// ignore: file_names

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:timer_app/Utilities/AppColor.dart';

class BallWidget extends StatefulWidget {
  final bool isBlinking;
  final Color primaryColor;
  final Color secondaryColor;
  final int interval;
  final int number;

  const BallWidget({
    Key? key,
    required this.isBlinking,
    required this.primaryColor,
    required this.secondaryColor,
    required this.interval,
    required this.number,
  }) : super(key: key);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<BallWidget> {
  late Color _color;
  late Timer _timer;
  @override
  void initState() {
    _color = widget.primaryColor;

    changeColor();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  changeColor() {
    _timer = Timer.periodic(Duration(milliseconds: widget.interval), (_) {
      if (widget.isBlinking) {
        setState(() {
          if (_color == widget.primaryColor) {
            _color = widget.secondaryColor;
          } else if (_color == widget.secondaryColor) {
            _color = widget.primaryColor;
          }
        });
      } else {
        setState(() {
          _color = widget.primaryColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 6,
      width: MediaQuery.of(context).size.width / 7,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: _color),
      ),
      child: Center(
        child: Text(
          widget.number.toString(),
          style: const TextStyle(
            fontSize: 30,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
