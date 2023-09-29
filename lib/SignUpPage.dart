import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firestore = FirebaseFirestore.instance;
  var user_email = "";
  var user_password = "";
  var user_name = "";
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column (
          children: [
            ElevatedButton (
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Back")),
            TextField(
              obscureText: false,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Enter Name'
              ),
              onChanged: (value) {
                user_name = value;
              }
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email Address',
              ),
              onChanged: (value) {
                user_email = value;
              },
            ), 
            TextField(
              obscureText: true,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Create Password'
              ),
              onChanged: (value) {
                user_password = value;
              }
            ),

            //sign up button
            ElevatedButton (
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                );
                
                final user_data = <String, String> {
                  "Email" : user_email,
                  "Password": user_password,
                  "Username": user_name,
                  "Main Email": user_email,
                };

                firestore
                  .collection ("users")
                  .doc (user_email)
                  .set (user_data)
                  .onError((e, _) => print("Error writing document: $e"));

                final docRef = firestore.collection("users").doc(user_email);
                  docRef.get().then (
                    (DocumentSnapshot doc) async {
                      globals.user_doc = firestore.collection("users").doc(user_email);
                      globals.user_id = user_email;
                      globals.main_id = user_email;
                      final notes_data = <String, String> {
                        "Title": "Empty Note",
                        "Show": "No",
                        "Text": "none",
                      };

                      firestore
                        .collection("users")
                        .doc (user_email)
                        .collection ("notes")
                        .doc (notes_data["Title"])
                        .set (notes_data)
                        .onError((e, _) => print("Error writing document: $e"));

                      final alarm_data = <String, String> {
                        "Title": "Empty Alarm",
                        "Show": "No",
                        "Time": "none"
                      };

                      firestore
                        .collection("users")
                        .doc (user_email)
                        .collection ("alarms")
                        .doc (alarm_data["Title"])
                        .set (alarm_data)
                        .onError((e, _) => print("Error writing document: $e"));

                      final schedule_data = <String, String> {
                        "Title": "Empty Event",
                        "Show": "No",
                        "Date": "none"
                      };

                      firestore
                        .collection("users")
                        .doc (user_email)
                        .collection ("schedules")
                        .doc (schedule_data["Title"])
                        .set (schedule_data)
                        .onError((e, _) => print("Error writing document: $e"));

                    },
                    onError: (e) => print("There was an error in making the account"),
                  );

              }, 
              child: Text("Sign Up")
            ),
          ]
        )
      ),
    );
    
  }
}