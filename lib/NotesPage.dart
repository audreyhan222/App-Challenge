import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewNotePage()),
                );
              },
              child: Text("Add Note"),
            ),
          ],
        ),
      )
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