import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Notes", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        elevation: 2.0,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Container (
              height: 60,
              width: 300,
              child: GFButton (
                shape: GFButtonShape.pills,
                color: Color.fromRGBO(203, 153, 126, 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewNotePage()),
                  );
                },
                child: Text("Add Note", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 25)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").doc(globals.main_id).collection("notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
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
                    "Add a Note!",
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
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.all(10.0),
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
            style: GoogleFonts.merriweather(color:Color.fromRGBO( 203, 153, 126, 1), fontSize: 35)
          ),
          SizedBox(
            height: 4.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            doc["Text"],
            style: GoogleFonts.merriweather(color: Color.fromRGBO(140, 106, 89, 1), fontSize: 20),
            //overflow: TextOverflow.clip,
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
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
        elevation: 2.0,
        title: Text(widget.doc["Title"], style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded (
              child: Text(
                widget.doc["Text"],
                style: TextStyle(color: Color.fromRGBO(203, 153, 126, 2), fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
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
      appBar: AppBar (
        title: Text("Add Note", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
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
              style: TextStyle(color: Color.fromRGBO(203, 153, 126, 2), fontSize: 30),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color.fromRGBO(203, 153, 126, 2), fontSize: 30),
                hintText: 'Enter title',
              ),
              onChanged: (value) {
                note_title = value;
              }
            ),
            Expanded (
              child: Container (
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  obscureText: false,
                  style: TextStyle(color: Color.fromRGBO(140, 106, 89, 1), fontSize: 20),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Color.fromRGBO(140, 106, 89, 1), fontSize: 20),
                    hintText: 'Enter notes',
                  ),
                  onChanged: (value) {
                    note_text = value;
                  }
                ),
              ),
            ),

            Container(
              height: 60, 
              width: 300,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: Color.fromRGBO(203, 153, 126, 1),
                onPressed: () {
                  final note_data = <String, String> {
                    "Title": note_title,
                    "Show": "Yes",
                    "Text": note_text,
                  };
                  final notes_ref = globals.firestore.collection("users").doc(globals.main_id); // change to main_id
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
                child: Text("Create Note", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 20))
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}