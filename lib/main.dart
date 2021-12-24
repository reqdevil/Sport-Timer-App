import 'package:flutter/material.dart';
import 'package:timer_app/Helpers/basichelpers.dart';
import 'package:timer_app/Pages/CountdownPage.dart';
import 'package:timer_app/Pages/SessionPage.dart';
import 'package:timer_app/Pages/TestPage.dart';
import 'package:timer_app/Pages/progresspage.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'countdown',
      routes: {
        'countdown': (context) => const CountdownPage(),
        'session': (context) => const SessionPage(),
        'test': (context) => const ProgressPage(),
      },
    );
  }
}
