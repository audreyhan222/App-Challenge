import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              height: 20.0,
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
                    print(snapshot);
                    print(globals.main_id);
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      children: snapshot.data!.docs
                          .map((note) => eventCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventDisplay(note),
                                    ));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "there's no Notes",
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
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromRGBO(255, 241, 230, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(203, 153, 126, 1),
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 3.0,
            spreadRadius: 0.2,
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["Title"],
          ),
          SizedBox(
            height: 4.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc["Text"],
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["Title"],
            ),
            SizedBox(
              height: 4.0,
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["Text"],
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class NewEventPage extends StatelessWidget {
  var note_title = "Title";
  var note_text = "";
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Add Event", style: TextStyle(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 25)),
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
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Enter Title',
              ),
              onChanged: (value) {
                note_title = value;
              }
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Enter Event',
              ),
              onChanged: (value) {
                note_text = value;
              }
            ),

            TextButton(
              onPressed: () {
                final note_data = <String, String> {
                  "Title": note_title,
                  "Show": "Yes",
                  "Text": note_text,
                };
                final notes_ref = firestore.collection("users").doc(globals.user_id);
                notes_ref.get().then (
                    (DocumentSnapshot doc) async {
                      final data = doc.data() as Map<String, dynamic>;
                      firestore
                        .collection("users")
                        .doc (data["Main Email"])
                        .collection ("schedule")
                        .doc (note_data["Title"])
                        .set (note_data)
                        .onError((e, _) => print("Error writing document: $e"));
                    },
                  onError: (e) => print("User email or password is incorrect."),
                );
                Navigator.pop(context);
              },
              child: Text("Create Event")
            ),
          ],
        ),
      ),
    );
  }
}