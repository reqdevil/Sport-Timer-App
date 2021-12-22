// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              iconSize: 40,
            ),
            
          ],
        ),
      ),
    );
  }
}
