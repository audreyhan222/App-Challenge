import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/cupertino.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}


class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Schedule", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        elevation: 2.0,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              height: 60,
              width: 300,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: Color.fromRGBO(203, 153, 126, 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEventPage()),
                  );
                },
                child: Text("Add Event", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 25)),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").doc(globals.main_id).collection("schedule").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2.8/1,
                      children: snapshot.data!.docs
                          .map((event) => eventCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventDisplay(event),
                                    ));
                              }, event))
                          .toList(),
                    );
                  }
                  return Text(
                    "Add an Event!",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget eventCard(Function()? onTap, QueryDocumentSnapshot doc) {
  var date_nums = doc["Date"];
  var date_month = date_nums.split("-")[0];
  var date_day = date_nums.split("-")[1];
  return InkWell(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container (
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(203, 153, 126,1),
          ),
          
          child: Column (
            children: [
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: Text(date_month + "-" + date_day, style: GoogleFonts.kanit(color: Colors.white, fontSize: 30)),
              ),
            ],
          ),
        ),
        SizedBox(width: 5),
        Container (
          height: 100,
          width: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(237, 220, 210, 1),
          ),
          child: 
          Container(
            alignment: Alignment.center,
            child: Text(
              doc["Event"],
              style: GoogleFonts.merriweather(color: Color.fromRGBO(140, 106, 89, 1), fontSize: 20)
            ),
          ),
        ),
      ],
    ),
  );
}

class EventDisplay extends StatefulWidget {
  EventDisplay(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<EventDisplay> createState() => _EventDisplay();
}

class _EventDisplay extends State<EventDisplay> {
  @override
  Widget build(BuildContext context) {
    var date = widget.doc["Date"];
    var date_list = date.split("-");
    var event_date = DateTime(int.parse(date_list[2]), int.parse(date_list[0]), int.parse(date_list[1]));
    var difference = event_date.difference(DateTime.now()).inDays.toString();
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.doc["Event"], style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10),
            Expanded (
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                  widget.doc["Description"],
                  style: TextStyle(color: Color.fromRGBO(140, 106, 89, 2), fontSize: 25),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 100,
                ),
                ),),
            Container(
              height: 170,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height:20),
                  Container (
                    color: Color.fromRGBO(203, 153, 126, 1),
                    height: 150,
                    alignment: Alignment.center,
                    child: Text(
                      "Days Until Event: " + difference,
                      style: GoogleFonts.merriweather(color: Colors.white, fontSize: 30),
                    ),
                  ),

                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewEventPage extends StatelessWidget {
  var event = "Event Name";
  var date = DateTime.now().month.toString() + "-" + DateTime.now().day.toString() + "-" + DateTime.now().year.toString();
  var description = "Event Description";
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Add Event", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        elevation: 2.0,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Column (
          children: [
            TextField(
              style: TextStyle(color: Color.fromRGBO(203, 153, 126, 2), fontSize: 30),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color.fromRGBO(203, 153, 126, 2), fontSize: 30),
                hintText: 'Enter event',
              ),
              obscureText: false,
              onChanged: (value) {
                event = value;
              }
            ),
            Container(
              child: Container (
                height: 65,
                //color: Colors.blue,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  obscureText: false,
                  style: TextStyle(color: Color.fromRGBO(140, 106, 89, 1), fontSize: 20),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Color.fromRGBO(140, 106, 89, 1), fontSize: 20),
                    hintText: 'Enter a description',
                  ),
                  onChanged: (value) {
                    description = value;
                  }
                ),
              ),
            ),
            Expanded(
              child: 
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                  onDateTimeChanged: (DateTime newDateTime) {
                    date = newDateTime.month.toString() + "-" + newDateTime.day.toString() + "-" + newDateTime.year.toString();
                  },
                ),
              ),
            ),

            SizedBox(height: 10),
            Container(
              height: 60,
              width: 300,
              child: GFButton(
              shape: GFButtonShape.pills,
              color: Color.fromRGBO(203, 153, 126, 1),
              onPressed: () {
                final schedule_data = <String, String> {
                  "Event": event,
                  "Show": "Yes",
                  "Date": date,
                  "Description": description,
                };
                final notes_ref = firestore.collection("users").doc(globals.user_id);
                notes_ref.get().then (
                    (DocumentSnapshot doc) async {
                      final data = doc.data() as Map<String, dynamic>;
                      firestore
                        .collection("users")
                        .doc (data["Main Email"])
                        .collection ("schedule")
                        .doc (schedule_data["Title"])
                        .set (schedule_data)
                        .onError((e, _) => print("Error writing document: $e"));
                    },
                  onError: (e) => print("User email or password is incorrect."),
                );
                Navigator.pop(context);
              },
              child: Text("Create Event", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 20))
            ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}