import 'package:flutter/material.dart';
import 'package:timer_app/Helpers/BasicHelpers.dart';
import 'package:timer_app/Pages/MainPage.dart';

void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatefulWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  @override
  void initState() {
    BasicHelpers().hideStatusbar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
