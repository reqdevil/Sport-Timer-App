// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:timer_app/Utilities/AppColor.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey[600],
                endIndent: 10,
                thickness: .8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Timer Presents',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Color Schemes',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sounds',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Session History',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Privacy',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'About App',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: AppColor.backgroundColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                alignment: Alignment.centerLeft,
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: AppColor.white,
                ),
                iconSize: 40,
              ),
              const Text(
                "Your Timer Session",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      "This will be placed Session",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("New Session"),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Load Session"),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Save Session"),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
