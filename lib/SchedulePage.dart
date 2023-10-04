import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}


class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Schedule"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewNotePage()),
                );
              },
              child: Text("Add Event"),
            ),
            Text(
              "Your recent Notes",
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
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteDisplay(note),
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

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
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

class NoteDisplay extends StatefulWidget {
  NoteDisplay(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteDisplay> createState() => _NoteDisplay();
}

class _NoteDisplay extends State<NoteDisplay> {
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

class NewNotePage extends StatelessWidget {
  var note_title = "Title";
  var note_text = "";
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                labelText: 'Enter Notes',
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
                        .collection ("notes")
                        .doc (note_data["Title"])
                        .set (note_data)
                        .onError((e, _) => print("Error writing document: $e"));
                    },
                  onError: (e) => print("User email or password is incorrect."),
                );
                Navigator.pop(context);
              },
              child: Text("Create Note")
            ),
          ],
        ),
      ),
    );
  }
}