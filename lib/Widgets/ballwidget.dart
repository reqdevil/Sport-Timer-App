import 'dart:async';

import 'package:flutter/widgets.dart';

class Ball extends StatefulWidget {
  bool isBlinking;
  Color primaryColor;
  Color secondaryColor;
  int interval;
  Ball(
      {Key? key,
      required this.isBlinking,
      required this.primaryColor,
      required this.secondaryColor,
      required this.interval})
      : super(key: key);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
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
      height: MediaQuery.of(context).size.width / 9,
      width: MediaQuery.of(context).size.width / 9,
      decoration: BoxDecoration(
          color: _color,
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: _color)),
    );
  }
}
