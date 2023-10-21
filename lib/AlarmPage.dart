import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:google_fonts/google_fonts.dart';


class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});
  @override
  State<AlarmPage> createState() => _AlarmPageState();
}


class _AlarmPageState extends State<AlarmPage> {
   
  // creating text editing controller to take hour
  // and minute as input
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Alarms", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
        elevation: 2.0,
      ),
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.yellow,
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
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.yellow,
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
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
            child: const Text(
              'Create alarm',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {

//           ADD STUFF FOR FIREBASE HERE
//           reference notes page
//           make array to hold info about alarm
//           ex) hour, minutes, am/pm, set (true or false, indicating whether the alarm has been added to the phone)
//           reference notes page on how to add that to the firebase
//           title of alarm doc can just be the time or smth
//           just change the parts where it says notes collection to alarm collection
// 
// 


              int hour;
              int minutes;
              hour = int.parse(hourController.text);
              minutes = int.parse(minuteController.text);
               
              // creating alarm after converting hour
              // and minute into integer
              FlutterAlarmClock.createAlarm(hour: hour, minutes: minutes);
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
             
            // show alarm
            FlutterAlarmClock.showAlarms();
          },
          child: const Text(
            'Show Alarms',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ])),
    );
  }
}