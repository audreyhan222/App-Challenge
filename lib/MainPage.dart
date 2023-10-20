import 'package:flutter/material.dart';
import 'AlarmPage.dart';
import 'NotesPage.dart';
import 'SchedulePage.dart';
import 'ConnectionsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

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
        title: Text("Home", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        elevation: 2.0,
        shadowColor: Colors.black,
      ),
      body: Row (
        children: [
          Column (
            children: [
              Container (
                height: 250,
                width: 180,
                child: Padding (
                  padding: const EdgeInsets.fromLTRB(10, 40, 5, 5),
                  child: GFButton (
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AlarmPage()),
                      );
                    },
                    child: Column (
                      children: [
                        Icon(null),
                        Text ("Alarm"),
                      ]
                    )
                  ),
                )
              ),
              Container (
                height: 300,
                width: 180,
                child: Padding (
                  padding: const EdgeInsets.fromLTRB(10.0, 5, 5, 10),
                  child: GFButton (
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => const SchedulePage()),
                      );
                    },
                    child: Column (
                      children: [
                        Icon(null),
                        Text("Schedule"),
                      ]
                    ),
                  ),
                ),
              ),
            ]
          ),
          Column (
            children: [
              Container (
                height: 350,
                width: 180,
                child: Padding (
                  padding: EdgeInsets.fromLTRB(5, 40, 10, 5),
                  child: GFButton (
                    color: Colors.pink,
                    shape: GFButtonShape.standard,
                    onPressed: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => const NotesPage()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(null),
                        Text("Notes"),
                      ]
                    ),
                  ),
                ),
              ),
              Container (
                height: 200, 
                width: 180,
                child: Padding (
                  padding: EdgeInsets.fromLTRB(5, 5, 10, 10),
                  child: GFButton (
                    color: Colors.pink,
                    shape: GFButtonShape.standard,
                    onPressed: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => const ConnectionsPage()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(null),
                        Text("Connections")
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      );
  }
}
