import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AlarmPage.dart';
import 'NotesPage.dart';
import 'SchedulePage.dart';
import 'ConnectionsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'globals.dart' as globals;

Future<void> getAlarms() async {
  final DocumentReference userDocRef = globals.firestore.collection("users").doc(globals.user_id);

    try {
      // Access the "alarms" subcollection and fetch its documents
      QuerySnapshot alarmQuerySnapshot = await userDocRef.collection("alarms").get();

      if (alarmQuerySnapshot.docs.isNotEmpty) {
        var alarms_list = alarmQuerySnapshot.docs;
        for (final alarmDoc in alarms_list) {
          final data = alarmDoc.data() as Map<String, dynamic>;
          final added = data["Added"];
          if (added == "False") {
            var hour = data["Hour"];
            var minutes = data["Minutes"];
            FlutterAlarmClock.createAlarm(hour: int.parse(hour.toString()), minutes: int.parse(minutes.toString()));
            final alarm_data = <String, String> {
              "Hour": hour.toString(),
              "Minutes": minutes.toString(),
              "Added": "True",
            };
            globals.firestore.collection("users").doc(globals.user_id).collection("alarms").doc(alarmDoc.reference.id).set(alarm_data);
          }
        }
      } else {
        print("No alarms found in the subcollection.");
      }
    } catch (e) {
      print("Error fetching alarms: $e");
    }
}
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build (BuildContext context) {
    if (globals.user_id == globals.main_id) {
      getAlarms();
    }
    return Scaffold(
      appBar: AppBar (
        title: Image.asset('assets/titlewecare.png', fit: BoxFit.cover),
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
                  padding: const EdgeInsets.fromLTRB(10, 60, 5, 5),
                  child: ElevatedButton (
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(183, 183, 164, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AlarmPage()),
                      );
                    },
                    child: Column (
                      children: [
                        SizedBox(height:50),
                        Icon(null),
                        Text ("Alarm", style: GoogleFonts.kanit(color: Colors.white, fontSize: 25)),
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
                  child: ElevatedButton (
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(221, 190, 169, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => const SchedulePage()),
                      );
                    },
                    child: Column (
                      children: [
                        SizedBox(height:100),
                        Icon(null),
                        Text("Schedule", style: GoogleFonts.kanit(color: Colors.white, fontSize: 25)),
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
                  padding: EdgeInsets.fromLTRB(5, 60, 10, 5),
                  child: ElevatedButton (
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(221, 190, 169, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => const NotesPage()),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(height:90),
                        Icon(null),
                        Text("Notes", style: GoogleFonts.kanit(color: Colors.white, fontSize: 25)),
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
                  child: ElevatedButton (
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(183, 183, 164, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => const ConnectionsPage()),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(height:50),
                        Icon(null),
                        Text("Connections", style: GoogleFonts.kanit(color: Colors.white, fontSize: 20))
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
