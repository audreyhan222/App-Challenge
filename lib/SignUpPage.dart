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
              onPressed: () async {
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

                globals.firestore
                  .collection ("users")
                  .doc (user_email)
                  .set (user_data)
                  .onError((e, _) => print("Error writing document: $e"));
                
                var docRef = globals.firestore.collection("users").doc(user_email);
                docRef.get().then (
                  (DocumentSnapshot doc) async {
                    //final data = doc.data() as Map<String, dynamic>;
                    globals.user_doc = globals.firestore.collection("users").doc(user_email);
                    globals.user_id = user_email;
                    globals.main_id = user_email;
                    // globals.user_doc = globals.firestore.collection("users").doc(user_email);
                    // globals.user_id = user_email;
                    // globals.main_id = user_email;

                    // final userDocRef = globals.firestore.collection("users").doc(user_email);
                    // userDocRef.set(user_data).onError((e, _) => print("Error writing document: $e"));

                    // Create subcollections
                    // final notesCollectionRef = userDocRef.collection("notes");
                    // final alarmsCollectionRef = userDocRef.collection("alarms");
                    // final schedulesCollectionRef = userDocRef.collection("schedules");

                    // final notesData = <String, String> {
                    //   "Title": "Empty Note",
                    //   "Show": "No",
                    //   "Text": "none",
                    // };

                    // final alarmData = <String, String> {
                    //   "Title": "Empty Alarm",
                    //   "Show": "No",
                    //   "Time": "none",
                    // };

                    // final scheduleData = <String, String> {
                    //   "Title": "Empty Event",
                    //   "Show": "No",
                    //   "Date": "none",
                    // };

                    // try {
                    // // Firebase initialization and user data creation code

                    // // Create subcollections and documents
                    //   await notesCollectionRef.add(notesData);
                    //   await alarmsCollectionRef.add(alarmData);
                    //   await schedulesCollectionRef.add(scheduleData);

                    //   // All subcollections and documents were created successfully
                    //   print("Subcollections and documents created successfully");
                    // } catch (error) {
                    //   print("Error creating subcollections and documents: $error");
                    // }
                    // },
                    // onError: (e) => print("There was an error in making the account"),
                  }
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