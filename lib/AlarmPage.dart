import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:getwidget/getwidget.dart';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});
  @override
  State<AlarmPage> createState() => _AlarmPageState();
}


class _AlarmPageState extends State<AlarmPage> {
   
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Alarms", style: GoogleFonts.kanit(color: Color.fromRGBO(119, 119, 100, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 239, 235, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
        elevation: 2.0,
      ),
      body: Center(
          child: Column(children: [
        SizedBox(height: 30),
        Expanded (
          child: Column (
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(240, 239, 235, 1),
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: TextField(
                        
                        controller: hourController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(240, 239, 235, 1),
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: TextField(
                        controller: minuteController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
        Container(
          height: 60,
          width: 300,
          margin: const EdgeInsets.all(25),
          child: GFButton (
            shape: GFButtonShape.pills,
            type: GFButtonType.outline,
            color: Color.fromRGBO(165, 165, 141, 1),
            child: Text(
              'Create alarm',
              style: GoogleFonts.merriweather(color: Color.fromRGBO(165, 165, 141, 1), fontSize: 20),
            ),
            onPressed: () {

              int hour;
              int minutes;
              hour = int.parse(hourController.text);
              minutes = int.parse(minuteController.text);

              final alarm_data = <String, String> {
                "Hour": hour.toString(),
                "Minutes": minutes.toString(),
                "Added": "False",
              };

              if (globals.main_id == globals.user_id) {
                alarm_data["Added"] = "True";
                FlutterAlarmClock.createAlarm(hour: hour, minutes: minutes);
              }

              final docRef = globals.firestore.collection("users").doc(globals.main_id);
                docRef.get().then (
                  (DocumentSnapshot doc) async {
                    final data = doc.data() as Map<String, dynamic>;
                    firestore
                      .collection("users")
                      .doc (data["Main Email"])
                      .collection ("alarms")
                      .doc ()
                      .set (alarm_data)
                      .onError((e, _) => print("Error writing document: $e"));
                  }
                );
              
            },
          ),
        ),
        
        Container(
          height: 60,
          width: 300,
          child: GFButton (
          shape: GFButtonShape.pills,
          color: Color.fromRGBO(165, 165, 141, 1),
          onPressed: () {
            // show alarm
            // getAlarms();
            //getUserAlarms();
            FlutterAlarmClock.showAlarms();
          },
          child: Text(
            'Show Alarms',
            style: GoogleFonts.merriweather(color: Colors.white, fontSize: 20),
          ),
        ),
        ),
        SizedBox(height: 20),
      ])),
    );
  }
}