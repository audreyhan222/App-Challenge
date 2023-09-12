import 'package:add_name/ConnectionsPage.dart';
import 'package:flutter/material.dart';
import 'AlarmPage.dart';
import 'NotesPage.dart';
import 'SchedulePage.dart';
import 'ConnectionsPage.dart';

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
            onPressed: () {
              Navigator.push (
                context,
                MaterialPageRoute(builder: (context) => const SchedulePage()),
              );
            },
            child: Text("Schedule"),
          ),
          TextButton (
            onPressed: () {
              Navigator.push (
                context,
                MaterialPageRoute(builder: (context) => const NotesPage()),
              );
            },
            child: Text("Notes"),
          ),
          TextButton (
            onPressed: () {
              Navigator.push (
                context,
                MaterialPageRoute(builder: (context) => const ConnectionsPage()),
              );
            },
            child: Text("Connections")
          ),
        ],
      ),
    );
  }
}
