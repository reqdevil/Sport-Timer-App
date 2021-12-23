// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'session'),
              child: const Text("Session Page"),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'test'),
              child: const Text("Test Page"),
            )
          ],
        ),
      ),
    );
  }
}
