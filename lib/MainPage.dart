import 'package:flutter/material.dart';
import 'AlarmPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          TextButton (
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlarmPage()),
              );
            },
            child: Text ("Alarm"),
          ),
          TextButton (
            onPressed: null,
            child: Text("Schedule"),
          ),
          TextButton (
            onPressed: null,
            child: Text("Notes"),
          ),
          TextButton (
            onPressed: null,
            child: Text("Connections")
          ),
        ],
      ),
    );
  }
}
