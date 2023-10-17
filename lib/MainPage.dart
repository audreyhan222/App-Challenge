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
      appBar: AppBar (
        title: Text("Home", style: TextStyle(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 25)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
      ),
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
