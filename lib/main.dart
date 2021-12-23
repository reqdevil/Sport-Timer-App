import 'package:flutter/material.dart';
import 'package:timer_app/Pages/CountdownPage.dart';
import 'package:timer_app/Pages/SessionPage.dart';
import 'package:timer_app/Pages/TestPage.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'countdown',
      routes: {
        'countdown': (context) => const CountdownPage(),
        'session': (context) => const SessionPage(),
        'test': (context) => const TestPage(),
      },
    );
  }
}
