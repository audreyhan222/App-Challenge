import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';


class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});
  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Alarm Clock',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _AlarmPage();
}

class _AlarmPage extends State<MyHomePage> {
   
  // creating text editing controller to take hour
  // and minute as input
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeniellesCodeForReal'),
        centerTitle: true,
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
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
              child: const Text(
                'Create timer',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                int minutes;
                minutes = (int.parse(minuteController.text)) * 60;
                 
                // create timer
                FlutterAlarmClock.createTimer(length: minutes);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AboutDialog(
                        children: [
                          Center(
                            child: Text("Timer is set",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          )
                        ],
                      );
                    });
              }),
        ),
        ElevatedButton(
          onPressed: () {
             
            // show timers
            FlutterAlarmClock.showTimers();
          },
          child: Text(
            "Show Timers",
            style: TextStyle(fontSize: 17),
          ),
        )
      ])),
    );
  }
}